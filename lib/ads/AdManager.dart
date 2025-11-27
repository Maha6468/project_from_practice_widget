import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:adblock_detector/adblock_detector.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ironsource_x/ironsource.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../common/firebase_notification/main dart configration.txt.dart' as PreferenceHelper;
import '../common/perfrance.dart';
import 'IronSourceErrorListener.dart';
import 'MyIronSourceListerner.dart';

enum AdLoadState { notLoaded, loading, loaded }

class AdManager implements IronSourceErrorListener{
  static final AdManager _instance = AdManager._internal();

  factory AdManager() => _instance;

  static AdManager get instance => _instance;

  AdManager._internal();

  String? _selectedNetwork;
  String? _countryCode;

  InterstitialAd? _admobInterstitial;
  bool _isAdmobAdLoaded = false;
  bool _isUnityAdReady = false;

  final String _admobInterstitialAdUnitId = Platform.isAndroid ? 'ca-app-pub-9323045181924630/7438005611' : "ca-app-pub-9323045181924630/2142476163"; // real ad id
  // final String _admobInterstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712'; // test ad id

  final String _applovinSdkKey =
      'nWrUHGUTy7heNC4pHiMHaS8ubwUIllDwpJpZHaqiLb3TXdEpz23uZsCfVadpNOXJFC5gnN_xiaaV0f3zkzt5Je';
  final String _applovinInterstitialAdUnitId = Platform.isAndroid ? 'd69c67d6be09e8f0' : "0e120febd74a39f2";

  final String _unityGameId = Platform.isAndroid ? '5229152' : '5229153';
  final String _unityAdUnitId =
  Platform.isAndroid ? 'Interstitial_Android' : 'Interstitial_iOS';
  final bool _unityTestMode = false;

  final String _ironApiKey = Platform.isAndroid ? '201510415' : '2167213bd';
  final String _ironInterstitialAdUnitId = Platform.isAndroid ? 'wx2z7k6bpuekqy4d': "gg24sy56rcs5rlu9";

  final String _defaultAdNetwork = 'ironsource';

  var _applovinInterstitialLoadState = AdLoadState.notLoaded;
  var _applovinInterstitialRetryAttempt = 0;
  int _maxExponentialRetryCount = 6;

  bool isFanInterstitialAdLoaded = false;

  static String adErrorMessage = "";

  Future<void> initialize() async {
    await _fetchCountry();
    await _fetchAdConfiguration();

    if (_selectedNetwork != null) {
      if (_selectedNetwork!.contains('admob')) {
        _initializeAdMob();
      }
      if (_selectedNetwork!.contains('applovin')) {
        _initializeAppLovin();
      }
      if (_selectedNetwork!.contains('ironsource')) {
        _initializeIronSource();
      }
      if (_selectedNetwork!.contains('unity')) {
        _initializeUnityAds();
      }
      if (_selectedNetwork!.contains('fan')) {
        _initializeFan();
      }
    }
  }

  Future<void> _fetchCountry() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      String url = 'https://api.bigdatacloud.net/data/reverse-geocode-client?'
          'latitude=${position.latitude}&longitude=${position.longitude}';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _countryCode = data['countryCode'];
        print("AdManager: _countryCode: $_countryCode");
      }
    } catch (e) {
      print('Error fetching country: $e');
    }
  }

  Future<void> _fetchAdConfiguration() async {
    try {
      String url =
          'https://app.orbaic.com/api/get-ad-configuration'; // Updated URL
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data != null && data['result'] != null) {
          final result = data['result'];
          _selectedNetwork = result[_countryCode] ??
              result['default']; // Use country-specific or default
          logStatus('Ad configuration fetched: $_selectedNetwork');
        } else {
          logStatus('Ad configuration missing in response.');
          _selectedNetwork = _defaultAdNetwork; // Fallback to app's default
        }
      } else {
        logStatus(
            'Failed to fetch ad configuration. Status code: ${response.statusCode}');
        _selectedNetwork = _defaultAdNetwork; // Fallback to app's default
      }
    } catch (e) {
      logStatus('Error fetching ad configuration: $e');
      _selectedNetwork = _defaultAdNetwork; // Fallback to app's default
    }
  }

  Future<void> _initializeAdMob() async {
    await MobileAds.instance.initialize();
    _loadAdMobAd();
  }

  void _loadAdMobAd() {
    InterstitialAd.load(
      adUnitId: _admobInterstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _admobInterstitial = ad;
          _isAdmobAdLoaded = true;
        },
        onAdFailedToLoad: (error) {
          print('AdMob failed to load: $error');
          _isAdmobAdLoaded = false;
          adErrorMessage = error.message;
        },
      ),
    );
  }

  Future<void> _initializeFan() async {
    await FacebookAudienceNetwork.init(
        testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
        iOSAdvertiserTrackingEnabled: true //default false
    );
    _loadFanAd();
  }

  void _loadFanAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: Platform.isAndroid
          ? "YOUR_PLACEMENT_ID"
          : "1920917498431294_1960887241100986",
      listener: (result, value) {
        switch (result) {
          case InterstitialAdResult.LOADED:
            isFanInterstitialAdLoaded = true;
            print("Interstitial Ad Loaded");
            break;
          case InterstitialAdResult.ERROR:
            isFanInterstitialAdLoaded = false;
            print("Error loading Interstitial Ad: $value");
            break;
          case InterstitialAdResult.DISMISSED:
            isFanInterstitialAdLoaded = false;
            _loadFanAd();
            print("Error loading Interstitial Ad: $value");
            break;
        // Handle other cases if necessary
          default:
            break;
        }
      },
    );
  }

  Future<void> _initializeAppLovin() async {
    MaxConfiguration? configuration =
    await AppLovinMAX.initialize(_applovinSdkKey);
    if (configuration != null) {
      // _isInitialized = true;

      logStatus('SDK Initialized in ${configuration.countryCode}');

      AppLovinMAX.loadInterstitial(_applovinInterstitialAdUnitId);
    }
  }

  Future<void> _initializeUnityAds() async {
    // await UnityAds.init(gameId: _unityGameId, testMode: true);
    UnityAds.init(
      gameId: _unityGameId,
      testMode: _unityTestMode,
      onComplete: () {
        logStatus('Unity Ads initialized.');
      },
      onFailed: (error, message) {
        logStatus("Unity Ads initialization failed: $error, $message");
        adErrorMessage = message;
      },
    );

    // Load the Unity ad
    UnityAds.load(
      placementId: _unityAdUnitId,
      onComplete: (placementId) {
        _isUnityAdReady = true;
        logStatus("Unity Ad is ready: $placementId");
      },
      onFailed: (placementId, error, message) {
        _isUnityAdReady = false;
        logStatus("Unity Ad failed to load: $placementId, $error, $message");
      },
    );
  }

  final _ironCompleter = Completer<void>();

  Future<void> _initializeIronSource() async {
    await IronSource.initialize(
        appKey: _ironApiKey, listener: MyIronSourceListener(_ironCompleter, this));
    IronSource.loadInterstitial();
  }

  Future<bool> isAdReady() async {
    var isAdEnabled =
        await PreferenceHelper.instance.getData(Pref.isAdEnabled) ?? true;
    if (!isAdEnabled) {
      print("isAdReady: Ad is disabled.");
      return true;
    }
    print("isAdReady: Ad is enabled.");
    print("isAdReady: _selectedNetwork: $_selectedNetwork");

    if (_selectedNetwork != null) {
      List<String> networks = _selectedNetwork!.split(',');

      // Check each network in the specified order
      for (String network in networks) {
        switch (network.trim()) {
          case 'admob':
            if (_isAdmobAdLoaded && _admobInterstitial != null) {
              return true; // Return true if AdMob is ready
            }
            break;

          case 'applovin':
            if (_applovinInterstitialLoadState == AdLoadState.loaded) {
              return true; // Return true if AppLovin is ready
            }
            break;

          case 'unity':
            if (_isUnityAdReady) {
              return true; // Return true if Unity is ready
            }
            break;

          case 'ironsource':
            if (await IronSource.isInterstitialReady()) {
              return true; // Return true if IronSource is ready
            }
            break;

          case 'fan':
            if (isFanInterstitialAdLoaded) {
              return true; // Return true if fan is ready
            }
            break;

          default:
          // Skip unrecognized networks
            break;
        }
      }
    }
    return false; // Return false if no network is ready
  }

  Future<void> showAd() async {
    var isAdEnabled =
        await PreferenceHelper.instance.getData(Pref.isAdEnabled) ?? true;
    if (!isAdEnabled) {
      print("showAd: Ad is disabled.");
      return;
    }

    print("showAd: Ad is enabled.");

    if (_selectedNetwork != null && _selectedNetwork!.isNotEmpty) {
      List<String> networks =
      _selectedNetwork!.split(',').map((e) => e.trim()).toList();

      print("showAd: _selectedNetwork: $_selectedNetwork");

      for (String network in networks) {
        switch (network) {
          case 'admob':
            if (_isAdmobAdLoaded && _admobInterstitial != null) {
              final completer = Completer<void>();

              _admobInterstitial!.fullScreenContentCallback =
                  FullScreenContentCallback(
                    onAdDismissedFullScreenContent: (ad) {
                      print("AdMob interstitial dismissed.");
                      _loadAdMobAd(); // Reload AdMob ad
                      completer.complete(); // Notify that the ad is closed
                    },
                  );

              _admobInterstitial!.show();
              await completer.future; // Wait until the ad is closed
              return; // Stop checking other networks once AdMob ad is shown
            }
            break;

          case 'applovin':
            if ((await AppLovinMAX.isInterstitialReady(
                _applovinInterstitialAdUnitId)) ??
                false) {
              final completer = Completer<void>();

              AppLovinMAX.setInterstitialListener(InterstitialListener(
                onAdLoadedCallback: (ad) {
                  _applovinInterstitialLoadState = AdLoadState.loaded;

                  // Interstitial ad is ready to be shown. AppLovinMAX.isInterstitialAdReady(_interstitial_ad_unit_id) will now return 'true'
                  logStatus('Interstitial ad loaded from ${ad.networkName}');

                  // Reset retry attempt
                  _applovinInterstitialRetryAttempt = 0;
                },
                onAdLoadFailedCallback: (adUnitId, error) {
                  _applovinInterstitialLoadState = AdLoadState.notLoaded;

                  logStatus(
                      'Interstitial ad failed: error_code: ${error.code}');

//                   if (error.code == ErrorCode.fullscreenAdAlreadyLoading) {
//                     logStatus('Interstitial ad failed: ad is already loading');
//                     return;
//                   } else if (error.code == ErrorCode.fullscreenAdLoadWhileShowing) {
//                     logStatus(
//                         'Interstitial ad failed: ad is currently being shown for this ad unit');
//                     return;
//                   }

                  // Interstitial ad failed to load
                  // We recommend retrying with exponentially higher delays up to a maximum delay (in this case 64 seconds)
                  _applovinInterstitialRetryAttempt =
                      _applovinInterstitialRetryAttempt + 1;
                  if (_applovinInterstitialRetryAttempt >
                      _maxExponentialRetryCount) {
                    logStatus(
                        'Interstitial ad failed to load with code ${error.code}');
                    return;
                  }

                  int retryDelay = pow(
                      2,
                      min(_maxExponentialRetryCount,
                          _applovinInterstitialRetryAttempt))
                      .toInt();
                  logStatus(
                      'Interstitial ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

                  Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
                    _applovinInterstitialLoadState = AdLoadState.loading;
                    logStatus('Interstitial ad retrying to load...');
                    AppLovinMAX.loadInterstitial(_applovinInterstitialAdUnitId);
                  });
                },
                onAdDisplayedCallback: (ad) {
                  logStatus('Interstitial ad displayed');
                },
                onAdDisplayFailedCallback: (ad, error) {
                  _applovinInterstitialLoadState = AdLoadState.notLoaded;
                  logStatus(
                      'Interstitial ad failed to display with code ${error.code} and message ${error.message}');
                },
                onAdClickedCallback: (ad) {
                  logStatus('Interstitial ad clicked');
                },
                onAdHiddenCallback: (ad) {
                  _applovinInterstitialLoadState = AdLoadState.notLoaded;
                  logStatus('Interstitial ad hidden');
                  completer.complete();
                  AppLovinMAX.loadInterstitial(_applovinInterstitialAdUnitId);
                },
              ));

              AppLovinMAX.showInterstitial(_applovinInterstitialAdUnitId);
              await completer.future; // Wait until the ad is closed
              return; // Stop checking once AppLovin ad is shown
            }
            break;

          case 'unity':
            if (await UnityAds.isInitialized()) {
              final completer = Completer<void>();
              UnityAds.showVideoAd(
                placementId: _unityAdUnitId,
                onStart: (placementId) =>
                    print('Unity: Video Ad $placementId started'),
                onClick: (placementId) =>
                    print('Unity: Video Ad $placementId click'),
                onSkipped: (placementId) =>
                    print('Unity: Video Ad $placementId skipped'),
                onComplete: (placementId) => completer.complete(),
                onFailed: (placementId, error, message) => print(
                    'Unity: Video Ad $placementId failed: $error $message'),
              );

              UnityAds.showVideoAd(placementId: _unityAdUnitId);
              await completer.future; // Wait until the ad is closed
              return; // Stop checking once Unity ad is shown
            }
            break;

          case 'ironsource':
            if ((await IronSource.isInterstitialReady()) ?? false) {
              // final completer = Completer<void>();
              // MyIronSourceListener(completer);
              await IronSource.showInterstitial();
              await _initializeIronSource();
              // await completer.future; // Wait until the ad is closed
              return; // Stop checking once IronSource ad is shown
            }
            break;

          case 'fan':
            if (isFanInterstitialAdLoaded) {
              FacebookInterstitialAd.showInterstitialAd(delay: 500);
              return; // Stop checking once fan ad is shown
            }
            break;

          default:
            break;
        }
      }
    }

    print("No ad is ready to be shown.");
  }

  @override
  void onIronErrorOccurred(String msg) {
    // errorMessage = msg;
  }

}



void logStatus(String s) {
  print("AdManager: $s");
}

Future<bool> isAdBlockingEnabled() async {
  AdBlockDetector adBlockDetector = AdBlockDetector();
  return await adBlockDetector.isAdBlockEnabled(
    testAdNetworks: [AdNetworks.googleAdMob],
  );
}


Future<bool> hasInternetConnection() async {
  return await ConnectivityWrapper.instance.isConnected;
}