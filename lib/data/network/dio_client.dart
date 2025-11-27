import 'dart:convert';
import 'dart:ui';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get/get_core/src/get_main.dart' as nav;

import '../../colors/app_colors.dart';
import '../../common/app_loading.dart';
import '../../common/constants.dart';
import '../../common/firebase_notification/main dart configration.txt.dart' as PreferenceHelper;
import '../../common/global_widget.dart';
import '../../common/perfrance.dart';
import '../../models/response.dart';
import '../../routes/app_pages.dart';
import 'package:http/http.dart' as http;

bool isNavigated = false;
bool isRefreshing = false;

class DioClient {
  static final DioClient instance = DioClient._internal();

  final Dio _dio = Dio();

  final BaseOptions options = BaseOptions(
    baseUrl: AppConstant.baseUrl,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  );

  factory DioClient() {
    return instance;
  }

  DioClient._internal() {
    _dio.options = options;

    _dio.interceptors.add(ChuckerDioInterceptor());

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print("onRequest============> ${options.data}");
          print("onRequest============> ${options.headers.toString()}");
          print("onRequest============> ${options.extra.toString()}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("onResponse============> ${response.data}");
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 422) {
            print("Error-Response : ${error.response?.data}");
            Map<String, dynamic> errorResponse = error.response?.data ?? {};
            //  Map<String, dynamic> errorResponse = {'ErrorMessage' : 'Please reset your password to continue with the app.'};
            //  Map<String, dynamic> errorResponse = {'ErrorMessage' : 'Please reset your password to continue with the app.'};

            String errorMessage = errorResponse["result"]['ErrorMessage']??"Something went Wrong";
            errorSnack(errorMessage);
            //showResetPasswordSnackBar(errorResponse['ErrorMessage']??"Something went Wrong ");
            hideLoading();
            throw DioError(
              response: Response<String>(
                data: json.encode(errorResponse),
                statusCode: 422,
                requestOptions: error.requestOptions,
              ),
              error: errorMessage,
              requestOptions: error.requestOptions,
            );
          }

          else if (error.response?.statusCode == 404) {
            print("Error-Response : ${error.response?.data}");
            Map<String, dynamic> errorResponse = error.response?.data ?? {};
            String errorMessage = errorResponse["result"]['ErrorMessage']??"Something went Wrong 1 ";
            errorSnack(errorMessage);
            hideLoading();
            throw DioError(
              response: Response<String>(
                data: json.encode(errorResponse),
                statusCode: 422,
                requestOptions: error.requestOptions,
              ),
              error: errorMessage,
              requestOptions: error.requestOptions,
            );
          }

          else if (error.response?.statusCode == 401) {
            if (!isRefreshing) {
              isRefreshing = true;

              final requestOptions = error.requestOptions;
              final token = await _refreshToken();
              if (token == null) {
                //if still access token is null means

                Map<String, dynamic> map = {};
                try {
                  map = error.response?.data ?? {};
                } catch (e) {
                  map["result"] = {"ErrorMessage": error.response?.data};
                }
                print("before logout===> $map");
                // await _performLogout(map);

                isNavigated = true;
                await PreferenceHelper.instance.setData(Pref.token, "");
                nav.Get.offAllNamed(Routes.LOGIN);
                errorSnack(map["result"]['ErrorMessage']??"Something went Wrong 2");
                hideLoading();
                return handler.reject(error);
              } else {
                final opts = Options(
                  extra: error.requestOptions.extra,
                  method: requestOptions.method,
                );
                _dio.options.headers['Authorization'] = 'Bearer $token';
                _dio.options.headers['Content-Type'] = 'application/json';

                // setting retry count to 1 to prevent further concurrent calls
                // dio.options.headers[kRetryCount] = 1;
                final response = await _dio.request<dynamic>(
                  requestOptions.path,
                  options: opts,
                  cancelToken: requestOptions.cancelToken,
                  onReceiveProgress: requestOptions.onReceiveProgress,
                  data: requestOptions.data,
                  queryParameters: requestOptions.queryParameters,
                );
                await PreferenceHelper.instance.setData(Pref.token, token);
                if (response.statusCode != 401) {
                  // removing retry count after successful request
                  // dio.options.headers.remove(kRetryCount);
                  return handler.resolve(response);
                } else {
                  return handler.reject(error);
                }
              }
            } else {
              return handler.next(error);
            }
          }
          else if(error.response?.statusCode == 400){
            if (error.requestOptions.uri.path.contains("/user/send-profile-update-request")) {
              print(error.response?.data ?? {});
              return handler.next(error);
            } else {
              Map<String, dynamic> errorResponse = error.response?.data ?? {};
              String msg = errorResponse["result"]['ErrorMessage'] ?? "Something went Wrong 400";
              hideLoading();
              if (msg.toLowerCase().contains("email") && msg.toLowerCase().contains("not") && msg.toLowerCase().contains("verified")) {
                print(msg);
                showVerifyDialogWithIcon(Icons.notifications_none_outlined, "", msg, AppColors.appSecondaryBackgroundColor, () {
                  nav.Get.to(() => ResendEmailVerify());
                });
              } else {
                errorSnack(msg);
              }
            }
          }
          else {
            if (error.requestOptions.uri.path.contains("/user/updateprofile")) {
              hideLoading();
              return handler.next(error);
            } else if (error.requestOptions.uri.path.contains("/user/send-profile-update-request")) {
              hideLoading();
              return handler.next(error);
            } else {
              try {
                print("Stacking123 Error Code Sakib: ${error.response?.statusCode}");
                print("Stacking123 Error-Response : ${error.response?.data}");

                Map<String, dynamic> errorResponse = error.response?.data ?? {};
                errorSnack(errorResponse["result"]['ErrorMessage'] ?? "Something went Wrong 3");
              } catch (e) {
                print(e);
                dynamic errorResponse = error.response?.data ?? "";
                errorSnack(errorResponse.toString());
              }
              // String errorResponse = error.response?.data ?? "";
              // errorSnack(errorResponse);
              hideLoading();
              print("Error-Message :${error.message}");
            }
          }
        },
      ),
    );
  }

  final iv = enc.IV.fromLength(8);
  final encrypt = enc.Encrypter(enc.Salsa20(enc.Key.fromLength(32)));

//==============================================================================
// ** Header Function  **
//==============================================================================

  Future<Options> _headers({bool isFormData = false}) async {
    String? token = await getToken() ?? "";

    if (token == emptyString) {
      return Future.value(Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    }  else {
      return Options(
          method: isFormData ? 'POST' : null,
          headers: {
            'Content-Type': isFormData ? 'multipart/form-data' : 'application/json',
            'Authorization': {"Bearer $token"}
          });
    }
  }

  Future<Options> _headersWithoutToken({bool isFormData = false}) async {
    return Future.value(Options(
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  }

  Future<Map<String, String>> _headerForMultipartData() async {
    String? token = await getToken() ?? "";
    if(token.isEmpty){
      return {'Content-Type': 'application/json'};
    }
    return {'Authorization': 'Bearer $token'};
  }



//==============================================================================
// ** Get Auth Token Function  **
//==============================================================================

  Future<String> getToken() async {
    String? token = await PreferenceHelper.instance.getData(Pref.token);

    print("Get token:$token");

    try {
      token = token ?? emptyString;
    } catch (e) {
      return Future.value(token);
    }
    return Future.value(token);
  }

//==============================================================================
// ** Get call Function  **
//==============================================================================

  Future<Either<String, String>> getApi({required String url}) async {
    try {
      var res = await _dio.get(
        url,
        options: await _headers(),
      );
      ResponseObject response = setResponseObject(
          res.statusCode ?? StatusCodeConstants.statusOkCode,
          json.encode(res.data));

      if (response.type == StatusCodeConstants.success) {
        return Right(response.body!);
      } else {
        print("error 1==========> ${response.errorBody!}");
        return Left(response.errorBody!);
      }
    } on DioException catch (dioError) {
      print("error 2==========> ${dioError.message ?? "undefined"}");
      return Left(dioError.response?.data.toString() ?? "");
    } catch (e) {
      print("error 3==========> ${e.toString()}");
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> getApiWithoutToken({required String url}) async {
    try {
      var res = await _dio.get(
        url,
        options: await _headersWithoutToken(),
      );
      ResponseObject response = setResponseObject(
          res.statusCode ?? StatusCodeConstants.statusOkCode,
          json.encode(res.data));

      if (response.type == StatusCodeConstants.success) {
        return Right(response.body!);
      } else {
        print("error 1==========> ${response.errorBody!}");
        return Left(response.errorBody!);
      }
    } on DioException catch (dioError) {
      print("error 2==========> ${dioError.message ?? "undefined"}");
      return Left(dioError.response?.data.toString() ?? "");
    } catch (e) {
      print("error 3==========> ${e.toString()}");
      return Left(e.toString());
    }
  }

//==============================================================================
// ** Post call Function  **
//==============================================================================


  Future<Either<String, String>> postApi({
    required String url,
    dynamic body,
  }) async {
    try {
      var options = await _headers();
      print("options =========> ${options.headers.toString()}");
      var res = await _dio.post(url, data: body, options: options);
      ResponseObject response = setResponseObject(
        res.statusCode ?? StatusCodeConstants.statusOkCode,
        json.encode(res.data),
      );
      if (response.type == StatusCodeConstants.success) {
        return Right(response.body!);
      } else {
        return Left(response.errorBody!);
      }
    } on DioException catch (dioError) {
      print(dioError.response);
      return Left(dioError.response?.data.toString() ?? "");
    } catch (e) {
      print('Caught an exception: $e');
      return Left(e.toString());
    }
  }


  Future<Either<String, String>> postMultipartApi({
    required String url,
    dynamic body,
  }) async {
    try {
      var options = await _headers(isFormData: body is FormData);
      print("options =========> ${options.headers.toString()}");
      var res = await _dio.request(url, data: body, options: options);
      ResponseObject response = setResponseObject(
        res.statusCode ?? StatusCodeConstants.statusOkCode,
        json.encode(res.data),
      );
      if (response.type == StatusCodeConstants.success) {
        return Right(response.body!);
      } else {
        return Left(response.errorBody!);
      }
    } on DioException catch (dioError) {
      print(dioError.response);
      return Left(dioError.response?.data.toString() ?? "");
    } catch (e) {
      print('Caught an exception: $e');
      return Left(e.toString());
    }
  }


  Future<Either<String, String>> getApiWithBody({
    required String url,
    dynamic body,
  }) async {
    try {
      var res = await _dio.get(url, data: body, options: await _headers());
      ResponseObject response = setResponseObject(
        res.statusCode ?? StatusCodeConstants.statusOkCode,
        json.encode(res.data),
      );
      print("Stacking123: response.type: ${response.type}");
      print("Stacking123: response.statusCode: ${response.statusCode}");
      if (response.type == StatusCodeConstants.success) {
        print("Stacking123: Success: ${response.body}");
        return Right(response.body!);
      } else {
        print("Stacking123: Failed: ${response.errorBody}");
        return Left(response.errorBody!);
      }
    } on DioException catch (dioError) {
      print("Stacking123: dioError: ${dioError.response}");
      return Left(dioError.response?.data.toString() ?? "");
    } catch (e) {
      print('Stacking123: Caught an exception: $e');
      return Left(e.toString());
    }
  }


  Future<Either<String, String>> patchApi({
    required String url,
    dynamic body,
  }) async {
    try {
      var res = await _dio.patch(url, data: body, options: await _headers());
      print("res");
      print(res);
      ResponseObject response = setResponseObject(
        res.statusCode ?? StatusCodeConstants.statusOkCode,
        json.encode(res.data),
      );
      if (response.type == StatusCodeConstants.success) {
        return Right(response.body!);
      } else {
        return Left(response.errorBody!);
      }
    } on DioError catch (dioError) {
      print(dioError.response);
      return Left(dioError.response?.data.toString() ?? "");
    } catch (e) {
      print('Caught an exception: $e');
      return Left(e.toString());
    }
  }


  Future<Either<dynamic, dynamic>> getFromData({
    required http.MultipartFile file,
    required Map<String, String> dataMap
  }) async {
    try {
      var req = http.MultipartRequest('POST', Uri.parse("https://app.orbaic.com/api/user/send-profile-update-request"));
      req.fields.addAll(dataMap);
      req.headers.addAll(await _headerForMultipartData());
      req.files.add(file);

      var res = await req.send();
      final responseStr = await res.stream.bytesToString();
      print(responseStr);

      final responseJson = jsonDecode(responseStr) as Map<String, dynamic>;
      if (responseJson['statusCode'] == 200) {
        return Right(responseJson);
      } else {
        return Left(responseJson);
      }
    } catch (e) {
      return throw e.toString();
    }
  }



//==============================================================================
// ** Put call Function  **
//==============================================================================

  Future<Either<String, String>> putApi(
      {required String url, dynamic body}) async {
    try {
      var res = await _dio.put(url,data: body, options: await _headers());

      ResponseObject response = setResponseObject(
        res.statusCode ?? StatusCodeConstants.statusOkCode,
        json.encode(res.data),
      );
      if (response.type == StatusCodeConstants.success) {
        return Right(response.body!);
      } else {
        return Left(response.errorBody!);
      }
    } on DioError catch (dioError) {
      print(dioError.response);
      return Left(dioError.response?.data.toString() ?? "");
    } catch (e) {
      print('Caught an exception: $e');
      return Left(e.toString());
    }
  }

//==============================================================================
// ** Delete call Function  **
//==============================================================================

  Future<Either<String, String>> deleteApi({required String url, dynamic body}) async {
    try {
      var res = await _dio.delete(url,data: body, options: await _headers());

      ResponseObject response = setResponseObject(
        res.statusCode ?? StatusCodeConstants.statusOkCode,
        json.encode(res.data),
      );
      if (response.type == StatusCodeConstants.success) {
        return Right(response.body!);
      } else {
        return Left(response.errorBody!);
      }
    } on DioError catch (dioError) {
      print(dioError.response);
      return Left(dioError.response?.data.toString() ?? "");
    } catch (e) {
      print('Caught an exception: $e');
      return Left(e.toString());
    }

  }

//==============================================================================
// ** Manage Response call Function  **
//==============================================================================

  ResponseObject setResponseObject(
      int statusCode,
      String body,
      ) {
    try {
      if (StatusCodeConstants.badRequestCodes.contains(statusCode)) {
        return ResponseObject(
            type: StatusCodeConstants.badRequest,
            statusCode: statusCode,
            body: emptyString,
            errorBody: body);
      } else if (StatusCodeConstants.authorityCodes.contains((statusCode))) {
        return ResponseObject(
            type: StatusCodeConstants.authority,
            statusCode: statusCode,
            body: emptyString,
            errorBody: body);
      } else if (StatusCodeConstants.errorCodes.contains(statusCode)) {
        return ResponseObject(
            type: StatusCodeConstants.error,
            statusCode: statusCode,
            body: emptyString,
            errorBody: body);
      } else if (StatusCodeConstants.notFoundCode.contains(statusCode)) {
        return ResponseObject(
            type: StatusCodeConstants.notFound,
            statusCode: statusCode,
            body: emptyString,
            errorBody: body);
      } else if (StatusCodeConstants.successCodes.contains(statusCode)) {
        return ResponseObject(
          type: StatusCodeConstants.success,
          statusCode: statusCode,
          errorBody: emptyString,
          body: body,
        );
      }
    } catch (e) {
      return ResponseObject(
          statusCode: statusCode,
          body: emptyString,
          type: StatusCodeConstants.none,
          errorBody: body);
    }

    return ResponseObject(
        type: StatusCodeConstants.statusOk,
        statusCode: StatusCodeConstants.statusOkCode,
        body: emptyString,
        errorBody: emptyString);
  }

  _performLogout(Map<String, dynamic> errorResponse) async {
    hideLoading();

    if (isNavigated == false) {
      var token = await PreferenceHelper.instance.getData(Pref.token) ?? "";
      if (token != "") {
        nav.Get.dialog(
            barrierDismissible: false,
            barrierColor: Colors.white.withOpacity(0.5),
            WillPopScope(
              onWillPop: () async {
                print("jgdehjhjadfs");
                return false;
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Center(
                  child: SizedBox(
                    height:
                    160, // Increased height to accommodate the button
                    child: Column(
                      // alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: 325,
                          height: 150,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x19000000),
                                blurRadius: 14,
                                offset: Offset(0, 5),
                                spreadRadius: 0,
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Login session is expired. Please, Login again.",
                                // style: poppins.get16.w600
                                //     .textColor(AppColors.xffB1021C),
                              ),
                              ElevatedButton(
                                  child: Text("ok"),
                                  onPressed: () async {
                                    isNavigated = true;
                                    await PreferenceHelper.instance.setData(Pref.token, "");
                                    nav.Get.offAllNamed(Routes.LOGIN);
                                  }),
                            ],
                          ),
                        ),
                        // Close button

                        // Positioned the button at the bottom center
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }
    }
    errorSnack(errorResponse["result"]['ErrorMessage']??"Something went Wrong 2");
    hideLoading();
  }

  Future<String?> _refreshToken() async {
    // var token = await UserRepo.getInstance().refreshToken();
    // return token.fold((l) => (null, false), (r) => (r.result?.accessToken, r.result?.isValidOldToken ?? false));

    String? token = await PreferenceHelper.instance.getData(Pref.token);
    final response = await http.get(Uri.parse('http://193.203.163.177:8080/api/auth/token-refresh?token=$token'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var newAccessToken = data['result']['accessToken'];
      await PreferenceHelper.instance.setData(Pref.token, newAccessToken);
      return newAccessToken;
    } else {
      return null;
    }
  }
}

