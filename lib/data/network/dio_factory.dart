import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:flutter_app_with_clean_architecture_mvvm/app/app_storage.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/constants.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/end_points.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  final AppStorage appStorage;
  DioFactory({
    required this.appStorage,
  });
  Dio getDio()  {
    Dio dio = Dio();
    Map<String, dynamic> _headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: appStorage.getApplicationLanguage(),
    };
    dio.options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      sendTimeout: Constants.apiTimeOut,
      receiveTimeout: Constants.apiTimeOut,
      headers: _headers,
    );

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
