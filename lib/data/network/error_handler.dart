import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/constants.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/failure.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleDioError(error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleDioError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioErrorType.other:
      return DataSource.DEFAULT.getFailure();
    case DioErrorType.response:
      if (error.response?.statusCode != null && error.response?.statusMessage != null) {
        return Failure(
          code: error.response?.statusCode ?? ApiInternalStatus.FAILURE,
          message: error.response?.statusMessage ?? Constants.empty,
        );
      } else {
        return DataSource.DEFAULT.getFailure();
      }
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(
          code: ResponseCode.SUCCESS,
          message: ResponseMessage.SUCCESS.tr(),
        );
      case DataSource.NO_CONTENT:
        return Failure(
          code: ResponseCode.NO_CONTENT,
          message: ResponseMessage.NO_CONTENT.tr(),
        );
      case DataSource.BAD_REQUEST:
        return Failure(
          code: ResponseCode.BAD_REQUEST,
          message: ResponseMessage.BAD_REQUEST.tr(),
        );
      case DataSource.FORBIDDEN:
        return Failure(
          code: ResponseCode.FORBIDDEN,
          message: ResponseMessage.FORBIDDEN.tr(),
        );
      case DataSource.UNAUTHORIZED:
        return Failure(
          code: ResponseCode.UNAUTHORIZED,
          message: ResponseMessage.UNAUTHORIZED.tr(),
        );
      case DataSource.NOT_FOUND:
        return Failure(
          code: ResponseCode.NOT_FOUND,
          message: ResponseMessage.NOT_FOUND.tr(),
        );
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(
          code: ResponseCode.INTERNAL_SERVER_ERROR,
          message: ResponseMessage.INTERNAL_SERVER_ERROR.tr(),
        );
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
          code: ResponseCode.CONNECT_TIMEOUT,
          message: ResponseMessage.CONNECT_TIMEOUT.tr(),
        );
      case DataSource.CANCEL:
        return Failure(
          code: ResponseCode.CANCEL,
          message: ResponseMessage.CANCEL.tr(),
        );
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
          code: ResponseCode.RECEIVE_TIMEOUT,
          message: ResponseMessage.RECEIVE_TIMEOUT.tr(),
        );
      case DataSource.SEND_TIMEOUT:
        return Failure(
          code: ResponseCode.SEND_TIMEOUT,
          message: ResponseMessage.SEND_TIMEOUT.tr(),
        );
      case DataSource.CACHE_ERROR:
        return Failure(
          code: ResponseCode.CACHE_ERROR,
          message: ResponseMessage.CACHE_ERROR.tr(),
        );
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(
          code: ResponseCode.NO_INTERNET_CONNECTION,
          message: ResponseMessage.NO_INTERNET_CONNECTION.tr(),
        );
      case DataSource.DEFAULT:
        return Failure(
          code: ResponseCode.DEFAULT,
          message: ResponseMessage.DEFAULT.tr(),
        );
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTHORIZED = 401; // failure, user is not authorized
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int NOT_FOUND = 404; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECEIVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = AppStrings.success; // success with data
  static const String NO_CONTENT = AppStrings.noContent; // success with no data (no content)
  static const String BAD_REQUEST = AppStrings.badRequestError; // failure, API rejected request
  static const String UNAUTHORIZED =
      AppStrings.unauthorizedError; // failure, user is not authorized
  static const String FORBIDDEN = AppStrings.forbiddenError; //  failure, API rejected request
  static const String NOT_FOUND = AppStrings.notFoundError; //  failure, API rejected request
  // static const String INTERNAL_SERVER_ERROR = AppStrings.internalServerError;
  static const String INTERNAL_SERVER_ERROR = AppStrings.internalServerError;

  // local status code
  static const String CONNECT_TIMEOUT = AppStrings.timeoutError;
  static const String CANCEL = AppStrings.defaultError;
  static const String RECEIVE_TIMEOUT = AppStrings.timeoutError;
  static const String SEND_TIMEOUT = AppStrings.timeoutError;
  static const String CACHE_ERROR = AppStrings.cacheError;
  static const String NO_INTERNET_CONNECTION = AppStrings.noInternetError;
  static const String DEFAULT = AppStrings.defaultError;
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
