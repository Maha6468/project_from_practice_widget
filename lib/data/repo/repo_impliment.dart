// ignore_for_file: override_on_non_overriding_member

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:miner/common/prefrance.dart';
import 'package:miner/data/repo/repo.dart';
import 'package:miner/models/DeleteAccountModel.dart';
import 'package:miner/models/RewardsWithdrawModel.dart';
import 'package:miner/models/all_team_model.dart';
import 'package:miner/models/dashboard_refresh_model.dart';
import 'package:miner/models/deshbord_model.dart';
import 'package:miner/models/error_response_model.dart';
import 'package:miner/models/login_model.dart';
import 'package:miner/models/my_offers_model.dart';
import 'package:miner/models/offers_history_model.dart';
import 'package:miner/models/ping_all_members.dart';
import 'package:miner/models/profile_model.dart';
import 'package:miner/models/quiz_model.dart';
import 'package:miner/models/register_model.dart';
import 'package:miner/models/register_token_model.dart';
import 'package:miner/models/reset_password_model.dart';
import 'package:miner/models/solve_question.dart';
import 'package:miner/models/start_mining_model.dart';
import 'package:miner/models/transferCoinModel.dart';
import 'package:miner/models/updateNotificationModel.dart';
import 'package:miner/models/withDrawShib.dart';


import '../../models/check_app_status_model.dart';
import '../../models/join_referal_model.dart';
import '../../models/logout_responce_model.dart';
import '../../models/stack_history_model.dart';
import '../../models/support_responce_model.dart';
import '../../models/team_model.dart';
import '../../models/update_profile_model.dart';
import '../../models/wallet_model.dart';
import '../../models/wallet_token_model.dart';
import '../network/data_provider.dart';

class UserRepoImpl extends UserRepository {
  UserRepoImpl({required DataProvider dataProvider})
      : _dataProvider = dataProvider;

  final DataProvider _dataProvider;

  @override
  Future<Either<String, LoginResponceModel>> userLogin(
      {required Map<String, dynamic> data}) {
    return _dataProvider.userLogin(data: data);
  }


  @override
  Future<Either<ErrorResponseModel, WithDrawShib>> withdrawShib(
      {required Map<String, dynamic> data}) {
    return _dataProvider.withdrawShib(data: data);
  }

  @override
  Future<Either<ErrorResponseModel, TransferCoinModel>> transferCoin(
      {required Map<String, dynamic> data}) {
    return _dataProvider.transferCoin(data: data);
  }

  @override
  Future<Either<ErrorResponseModel, RegisterTokenModel>> RegisterFCM(
      {required String  fcmToken}) {
    return _dataProvider.RegisterFCM(fcmToken: fcmToken);
  }

  @override
  Future<Either<ErrorResponseModel, ResetPasswordModel>> resetPassword(
      {required Map<String, dynamic> data}) {
    return _dataProvider.resetPassword(data: data);
  }

  @override
  Future<Either<ErrorResponseModel, RegisterModel>> userRegister(
      {required Map<String, dynamic> data}) {
    return _dataProvider.userRegister(data: data);
  }

  @override
  Future<Either<ErrorResponseModel, UpdateProfileModel>> updateProfile(
      {required Map<String, dynamic> data}) {
    return _dataProvider.updateProfile(data: data);
  }

  @override
  Future<Either<dynamic, dynamic>> updateProfileRequest(
      {required FormData data}) {
    return _dataProvider.updateProfileRequest(data: data);
  }

  @override
  Future<Either<ErrorResponseModel, SupportResponceModel>> sendSupportRequest(
      {required Map<String, dynamic> data}) {
    return _dataProvider.sendSupportRequest(data: data);
  }


  @override
  Future<Either<ErrorResponseModel, DeshbordModel>> GetDeshbordData() {
    return _dataProvider.GetDeshbordData();
  }

  @override
  Future<Either<ErrorResponseModel, QuizModel>> startQuiz() {
    return _dataProvider.startQuiz();
  }

  @override
  Future<Either<ErrorResponseModel, SolveQuestion>> solveQuestion(
      {required Map<String, dynamic> data}
      ) {
    return _dataProvider.solveQuestion(data: data);
  }

  @override
  Future<Either<ErrorResponseModel, WalletResponseModel>> GetWalletModelData() {
    return _dataProvider.GetWalletModelData();
  }

  @override
  Future<Either<ErrorResponseModel, TeamModel>> GetTeamModelData() {
    return _dataProvider.GetTeamModelData();
  }

  @override
  Future<Either<ErrorResponseModel, AllTeamModel>> GetALLTeamModelData() {
    return _dataProvider.GetALLTeamModelData();
  }

  @override
  Future<Either<ErrorResponseModel, JoinReferalModel>> joinReferral(String refCode) {
    return _dataProvider.joinReferral(refCode);
  }

  @override
  Future<Either<ErrorResponseModel, PingAllUsers>> pingInActiveUsers() {
    return _dataProvider.pingInActiveUsers();
  }

  @override
  Future<Either<ErrorResponseModel, ProfileModel>> GetProfileModelData() {
    return _dataProvider.GetProfileModelData();
  }


  @override
  Future<Either<ErrorResponseModel, UpdateNotificationModel>> updateNotification([bool? update]) {
    return _dataProvider.updateNotification(update);
  }


  @override
  Future<Either<ErrorResponseModel, StartminingModel>> startMining() {
    return _dataProvider.startMining();
  }
  @override
  Future<Either<ErrorResponseModel, LogoutResponceModel>> logout() {
    return _dataProvider.logout();
  }
  @override
  Future<Either<ErrorResponseModel, DeleteAccountModel>> deleteAccount({required String data}) {
    return _dataProvider.deleteAccount(data: data);
  }

  @override
  Future<Either<ErrorResponseModel, DashboardRefreshModel>> refreshDashboard() {
    return _dataProvider.refreshDashboard();
  }

  @override
  Future<Either<ErrorResponseModel, CheckAppStatusResponseModel>> checkAppStatus() {
    return _dataProvider.checkAppStatus();
  }

  @override
  Future<Either<String, LoginResponceModel>> googleSignIn({required Map<String, dynamic> data}){
    return _dataProvider.googleSignIn(data: data);
  }

  @override
  Future<Either<String, Map<String, dynamic>>> doStacking({required Map<String, dynamic> data}) async{
    return _dataProvider.doStacking(data: data);
  }

  @override
  Future<Either<ErrorResponseModel, List<StackHistoryModel>>> stackHistory() async {
    return _dataProvider.stackHistory();
  }

  @override
  Future<Either<ErrorResponseModel, WalletTokenModel>> getWallet(){
    return _dataProvider.getWallet();
  }

  @override
  Future<Either<ErrorResponseModel, OffersHistoryModel>> getMerchantHistory(int page, int size){
    return _dataProvider.getMerchantHistory(page, size);
  }

  @override
  Future<Either<ErrorResponseModel, MyOffersModel>> getMerchantOffers(int page, int size){
    return _dataProvider.getMerchantOffers(page, size);
  }

  @override
  Future<Either<ErrorResponseModel, Rewardswithdrawmodel>> getWithdrawHistory(){
    return _dataProvider.getWithdrawHistory();
  }

  @override
  Future<Either<ErrorResponseModel, String>> claimOffer(String offerId){
    return _dataProvider.claimOffer(offerId);
  }

}