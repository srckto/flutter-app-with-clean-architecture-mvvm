import 'package:dartz/dartz.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/failure.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/requests.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, BaseResponseObject>> forgot(String email);
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest);
  Future<Either<Failure, HomeObject>> getHomeData();
  Future<Either<Failure, StoreDetailsObject>> getStoreDetails(int id);
}
