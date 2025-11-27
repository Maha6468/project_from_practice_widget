import 'package:dartz/dartz.dart';
import 'package:miner/data/repo/repo_impliment.dart';
import 'package:miner/models/dashboard_refresh_model.dart';
import 'package:miner/models/deshbord_model.dart';
import 'package:miner/models/error_response_model.dart';

import '../../models/login_model.dart';
import '../../models/logout_responce_model.dart';
import '../../models/register_model.dart';
import '../network/data_provider.dart';
import '../network/dio_client.dart';

class UserRepo {
  static UserRepoImpl getInstance() {
    return UserRepoImpl(
      dataProvider: DataProvider(dioClient: DioClient.instance),
    );
  }
}

abstract class UserRepository {
  Future<Either<String, LoginResponceModel>> userLogin(
      {required Map<String, dynamic> data});

  Future<Either<ErrorResponseModel, DeshbordModel>> GetDeshbordData();

  Future<Either<ErrorResponseModel, RegisterModel>> userRegister(
      {required Map<String, dynamic> data});

  Future<Either<ErrorResponseModel, LogoutResponceModel>> logout();

  Future<Either<ErrorResponseModel, DashboardRefreshModel>> refreshDashboard();
}
