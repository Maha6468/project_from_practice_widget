
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../models/DeleteAccountModel.dart';
import '../../models/RewardsWithdrawModel.dart';
import '../../models/all_team_model.dart';
import '../../models/check_app_status_model.dart';
import '../../models/dashboard_refresh_model.dart';
import '../../models/deshbord_model.dart';
import '../../models/error_response_model.dart';
import '../../models/join_referal_model.dart';
import '../../models/login_model.dart';
import '../../models/logout_responce_model.dart';
import '../../models/my_offers_model.dart';
import '../../models/offers_history_model.dart';
import '../../models/ping_all_members.dart';
import '../../models/profile_model.dart';
import '../../models/quiz_model.dart';
import '../../models/register_model.dart';
import '../../models/register_token_model.dart';
import '../../models/reset_password_model.dart';
import '../../models/solve_question.dart';
import '../../models/stack_history_model.dart';
import '../../models/start_mining_model.dart';
import '../../models/support_responce_model.dart';
import '../../models/team_model.dart';
import '../../models/transferCoinModel.dart';
import '../../models/updateNotificationModel.dart';
import '../../models/update_profile_model.dart';
import '../../models/wallet_model.dart';
import '../../models/wallet_token_model.dart';
import '../../models/withDrawShaib.dart';
import 'dio_client.dart';

class DataProvider {
  DataProvider({required DioClient dioClient}) : _dioClient = dioClient;
  final DioClient _dioClient;

//==============================================================================
// **   API call for Login user **
//==============================================================================

  Future<Either<String, LoginResponceModel>> userLogin(
      {required Map<String, dynamic> data}) async {
    var response = await _dioClient.postApi(url: 'http://193.203.163.177:8080/api/auth/login', body: data);
    return response.fold(
          (l) => Left(l),
          (r) => Right(loginResponceModelFromJson(r)),
    );
  }

  //==============================================================================
// **   API call for withdrawShib  **
//==============================================================================

  Future<Either<ErrorResponseModel, WithDrawShib>> withdrawShib(
      {required Map<String, dynamic> data}) async {
    var response = await _dioClient.postApi(url: 'http://193.203.163.177:8080/api/user/withdrawshib', body: data);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(withDrawShibFromJson(r)),
    );
  }

  //==============================================================================
// **   API call for transferCoin  **
//==============================================================================

  Future<Either<ErrorResponseModel, TransferCoinModel>> transferCoin(
      {required Map<String, dynamic> data}) async {
    var response = await _dioClient.postApi(url: 'http://193.203.163.177:8080/api/user/transferCoins', body: data);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(transferCoinModelFromJson(r)),
    );
  }

//==============================================================================
// **   API call for register FCM **
//==============================================================================

  Future<Either<ErrorResponseModel, RegisterTokenModel>> RegisterFCM(
      {required  String fcmToken}) async {
    var response = await _dioClient.postApi(url: 'http://193.203.163.177:8080/api/user/register/fcm/token?token=${fcmToken}');
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(registerTokenModelFromJson(r)),
    );
  }
//==============================================================================
// **   API call for reset password **
//==============================================================================

  Future<Either<ErrorResponseModel, ResetPasswordModel>> resetPassword(
      {required Map<String, dynamic> data}) async {
    var response = await _dioClient.postApi(url: 'http://193.203.163.177:8080/api/auth/resetpassword', body: data);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(resetPAsswordModelFromJson(r)),
    );
  }

// ==============================================================================
// **   API call for Register user **
// ==============================================================================

  Future<Either<ErrorResponseModel, SupportResponceModel>> sendSupportRequest(
      {required Map<String, dynamic> data}) async {
    var response = await _dioClient.postApi(url: 'http://193.203.163.177:8080/api/user/supportticket', body: data);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(supportResponceModelFromJson(r)),
    );
  }

  // ==============================================================================
// **   API call for update profile   **
// ==============================================================================



  Future<Either<ErrorResponseModel, UpdateProfileModel>> updateProfile({
    required Map<String, dynamic> data,
  }) async {
    var response = await _dioClient.patchApi(
      url: 'http://193.203.163.177:8080/api/user/updateprofile',
      body: data,
    );
    print("response");
    print(response);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(updateProfileModelFromJson(r)),
    );
  }

  Future<Either<dynamic, dynamic>> updateProfileRequest({
    required FormData data,
  }) async {
    print(data.fields.toString());
    print(data.files.toString());
    var response = await _dioClient.postMultipartApi(
      url: 'http://193.203.163.177:8080/api/user/send-profile-update-request',
      body: data,
    );
    print("response");
    print(response);
    return response.fold(
          (l) => Left(l),
          (r) => Right(r),
    );
  }

// ==============================================================================
// **   API call for Register user **
// ==============================================================================

  Future<Either<ErrorResponseModel, RegisterModel>> userRegister(
      {required Map<String, dynamic> data}) async {
    var response = await _dioClient.postApi(url: 'http://193.203.163.177:8080/api/auth/register', body: data);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(registerModelFromJson(r)),
    );
  }

  // ==============================================================================
// **   API call for get the deshbordData **
// ==============================================================================

  Future<Either<ErrorResponseModel, DeshbordModel>> GetDeshbordData() async {
    var response = await

    _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/v1/dashboard');
    print("Sakib checking dashboard: ${response.toString()}");

    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(deshbordModelFromJson(r)),
    );
  }




  // ==============================================================================
// **   API call for get the refreshDashboard **
// ==============================================================================

  Future<Either<ErrorResponseModel, DashboardRefreshModel>> refreshDashboard() async {
    var response = await

    _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/dashboardrefresh');
    print("Sakib checking refresh dashboard: ${response.toString()}");
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(dashboardRefreshModelFromJson(r)),
    );
  }




  // ==============================================================================
// **   API call for get the startQuiz **
// ==============================================================================

  Future<Either<ErrorResponseModel, QuizModel>> startQuiz() async {
    var response = await

    _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/startquiz');
    print("response");
    print(response);

    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(quizModelFromJson(r)),
    );
  }
// ==============================================================================
// **   API call for get the solveQuestion **
// ==============================================================================

  Future<Either<ErrorResponseModel, SolveQuestion>> solveQuestion({required Map<String, dynamic> data}) async {
    var response = await
    // _dioClient.putApi(url: 'http://193.203.163.177:8080/api/user/quiz/solve/question', body: data);
    _dioClient.putApi(url: 'http://193.203.163.177:8080/api/user/quiz/solve/question-v1', body: data);
    print("response");
    print(response);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(solveQuestionFromJson(r)),
    );
  }

  Future<Either<ErrorResponseModel, WalletResponseModel>> GetWalletModelData() async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/walletPage');
    print('response');
    print(response);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(walletResponseModelFromJson(r)),
    );
  }


  Future<Either<ErrorResponseModel, WalletTokenModel>> getWallet() async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/wallet');
    print(response);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(walletTokenResponseModelFromJson(r)),
    );
  }

  Future<Either<ErrorResponseModel, TeamModel>> GetTeamModelData() async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/teamPage');
    print('response');
    print(response);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(teamModelFromJson(r)),
    );
  }


  Future<Either<ErrorResponseModel, AllTeamModel>> GetALLTeamModelData() async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/getreferralteam');
    print('response');
    print(response);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(allTeamModelFromJson(r)),
    );
  }



  Future<Either<ErrorResponseModel, PingAllUsers>> pingInActiveUsers() async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/mine/ping');
    print(response);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(pingAllUsersFromJson(r)),
    );
  }



  Future<Either<ErrorResponseModel, JoinReferalModel>> joinReferral(String refCode) async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/joinreferral?referralCode=${refCode}');
    print('response');
    print(response);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(joinReferalModelFromJson(r)),
    );
  }

  Future<Either<ErrorResponseModel, ProfileModel>> GetProfileModelData() async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/');
    print('response');
    print(response);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(profileModelFromJson(r)),
    );
  }

  Future<Either<ErrorResponseModel, UpdateNotificationModel>> updateNotification([bool? update]) async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/canNotify?notify=$update');
    print('response');
    print(response);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(updateNotificationModelFromJson(r)),
    );
  }

  Future<Either<ErrorResponseModel, StartminingModel>> startMining() async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/startmining');

    print("Sakib Checking startMining: ${response.toString()}");
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(startminingModelFromJson(r)),
    );
  }



  Future<Either<ErrorResponseModel, LogoutResponceModel>> logout() async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/logout');
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(logoutResponceModelFromJson(r)),
    );
  }

  Future<Either<ErrorResponseModel, DeleteAccountModel>> deleteAccount({required String data}) async {
    var response = await _dioClient.deleteApi(url: 'http://193.203.163.177:8080/api/user/deleteAccount', body: data);
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(deleteAccountModelFromJson(r)),
    );
  }



  // ==============================================================================
// **   API call to check app status **
// ==============================================================================

  Future<Either<ErrorResponseModel, CheckAppStatusResponseModel>> checkAppStatus() async {
    var response = await

    _dioClient.getApiWithoutToken(url: 'http://193.203.163.177:8080/api/v1/version');
    print("Check App Status response inside: ${response.toString()}");


    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(checkAppStatusResponseModelFromJson(r)),
    );
  }


  // ==============================================================================
// **   API call for google sign in **
// ==============================================================================

  Future<Either<String, LoginResponceModel>> googleSignIn({required Map<String, dynamic> data}) async {
    var response = await
    _dioClient.getApiWithBody(url: 'http://193.203.163.177:8080/api/auth/google', body: data);
    print("Google Login response inside: ${response.toString()}");
    return response.fold(
          (l) => Left(l),
          (r) => Right(loginResponceModelFromJson(r)),
    );
  }

  Future<Either<String, Map<String, dynamic>>> doStacking({required Map<String, dynamic> data}) async {
    var response = await
    _dioClient.getApiWithBody(url: 'http://193.203.163.177:8080/api/user/stacking', body: data);
    print("Stacking123: Do Stacking response inside: ${response.toString()}");
    return response.fold(
          (l) => Left(l),
          (r) => Right(jsonDecode(r)),
    );
  }

  Future<Either<ErrorResponseModel, List<StackHistoryModel>>> stackHistory() async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/stackHistory');

    print("Sakib Checking startMining: ${response.toString()}");
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(StackHistoryModel.fromList(jsonDecode(r))),
    );
  }

  Future<Either<ErrorResponseModel, OffersHistoryModel>> getMerchantHistory(int page, int size) async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/offer-histories?page=$page&&size=$size');

    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(OffersHistoryModel.fromJson(json.decode(r))),
    );
  }

  Future<Either<ErrorResponseModel, MyOffersModel>> getMerchantOffers(int page, int size) async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/my-offers?page=$page&&size=$size');
    print("Merchant Offer Response: ${response.toString()}");
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) => Right(MyOffersModel.fromJson(json.decode(r))),
    );
  }

  Future<Either<ErrorResponseModel, Rewardswithdrawmodel>> getWithdrawHistory() async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/shib-withdraw-list');
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) {
        try {
          return Right(Rewardswithdrawmodel.fromJson(json.decode(r)));
        } catch (e) {
          return Right(Rewardswithdrawmodel());
        }
      },
    );
  }


  Future<Either<ErrorResponseModel, String>> claimOffer(String offerId) async {
    var response = await _dioClient.getApi(url: 'http://193.203.163.177:8080/api/user/claim-offer?offerId=$offerId');
    print("Merchant Offer Response: ${response.toString()}");
    return response.fold(
          (l) => Left(errorResponseModelFromJson(l)),
          (r) {
        var json = jsonDecode(r);
        return Right(json['result']);
      },
    );
  }


}