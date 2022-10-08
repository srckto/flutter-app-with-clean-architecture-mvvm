import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app_with_clean_architecture_mvvm/data/data_source/remote_data_source.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/mapper/mapper.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/error_handler.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/failure.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/network_info.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/requests.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.login(loginRequest);

        if ((response.base?.status ?? ApiInternalStatus.FAILURE) == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              code: response.base?.status ?? ApiInternalStatus.FAILURE,
              message: response.base?.message ?? ResponseMessage.DEFAULT,
            ),
          );
        }
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, BaseResponseObject>> forgot(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.forgot(email);

        if ((response.status ?? ApiInternalStatus.FAILURE) == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              code: response.status ?? ApiInternalStatus.FAILURE,
              message: response.message ?? ResponseMessage.DEFAULT,
            ),
          );
        }
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.register(registerRequest);
        if ((response.base?.status ?? ApiInternalStatus.FAILURE) == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              code: response.base?.status ?? ApiInternalStatus.FAILURE,
              message: response.base?.message ?? ResponseMessage.DEFAULT,
            ),
          );
        }
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getHomeData();

        if ((response.base?.status ?? ApiInternalStatus.FAILURE) == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              code: response.base?.status ?? ApiInternalStatus.FAILURE,
              message: response.base?.message ?? ResponseMessage.DEFAULT,
            ),
          );
        }
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, StoreDetailsObject>> getStoreDetails(int id)  async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getStoreDetails(id);

        if ((response.baseResponse?.status ?? ApiInternalStatus.FAILURE) == ApiInternalStatus.SUCCESS) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(
              code: response.baseResponse?.status ?? ApiInternalStatus.FAILURE,
              message: response.baseResponse?.message ?? ResponseMessage.DEFAULT,
            ),
          );
        }
      } catch (error) {
        debugPrint(error.toString());
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
