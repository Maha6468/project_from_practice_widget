import 'dart:async';

import 'package:flutter_ironsource_x/ironsource.dart';
import 'package:flutter_ironsource_x/models.dart';

import 'IronSourceErrorListener.dart';

class MyIronSourceListener implements IronSourceListener {
  final Completer<void> completer;
  final IronSourceErrorListener errorListener;

  MyIronSourceListener(this.completer, this.errorListener);

  @override
  void onInterstitialAdClicked() {
    print("IronSourceAd123: Interstitial Ad Clicked");
  }

  @override
  void onInterstitialAdClosed() {
    print("IronSourceAd123: Interstitial Ad Closed");
    completer.complete(); // Notify that the ad is closed
    IronSource.loadInterstitial();
  }

  @override
  void onInterstitialAdLoadFailed(IronSourceError error) {
    print("IronSourceAd123: Interstitial Ad Load Failed: ${error.errorMessage}");
    String? errorMessage = error.errorMessage ?? "Unknown error occurred while loading the interstitial ad.";

    // Notify the other class about the error
    errorListener.onIronErrorOccurred(errorMessage);
  }

  @override
  void onInterstitialAdOpened() {
    print("IronSourceAd123: Interstitial Ad Opened");
  }

  @override
  void onInterstitialAdReady() {
    print("IronSourceAd123: Interstitial Ad Ready");
  }

  @override
  void onInterstitialAdShowFailed(IronSourceError error) {
    print("IronSourceAd123: Interstitial Ad Show Failed: ${error.errorMessage}");
    completer.completeError(error); // Notify of failure
  }

  @override
  void onInterstitialAdShowSucceeded() {
    print("IronSourceAd123: Interstitial Ad Show Succeeded");
  }

  @override
  void onRewardedVideoAdRewarded(Placement placement) {
    print("IronSourceAd123: User rewarded with ${placement.rewardAmount} ${placement.rewardName}");
  }

  @override
  void onGetOfferwallCreditsFailed(IronSourceError error) {
    // TODO: implement onGetOfferwallCreditsFailed
  }

  @override
  void onOfferwallAdCredited(OfferwallCredit reward) {
    // TODO: implement onOfferwallAdCredited
  }

  @override
  void onOfferwallAvailable(bool available) {
    // TODO: implement onOfferwallAvailable
  }

  @override
  void onOfferwallClosed() {
    // TODO: implement onOfferwallClosed
  }

  @override
  void onOfferwallOpened() {
    // TODO: implement onOfferwallOpened
  }

  @override
  void onOfferwallShowFailed(IronSourceError error) {
    // TODO: implement onOfferwallShowFailed
  }

  @override
  void onRewardedVideoAdClicked(Placement placement) {
    // TODO: implement onRewardedVideoAdClicked
  }

  @override
  void onRewardedVideoAdClosed() {
    // TODO: implement onRewardedVideoAdClosed
  }

  @override
  void onRewardedVideoAdEnded() {
    // TODO: implement onRewardedVideoAdEnded
  }

  @override
  void onRewardedVideoAdOpened() {
    // TODO: implement onRewardedVideoAdOpened
  }

  @override
  void onRewardedVideoAdShowFailed(IronSourceError error) {
    // TODO: implement onRewardedVideoAdShowFailed
  }

  @override
  void onRewardedVideoAdStarted() {
    // TODO: implement onRewardedVideoAdStarted
  }

  @override
  void onRewardedVideoAvailabilityChanged(bool available) {
    // TODO: implement onRewardedVideoAvailabilityChanged
  }
}