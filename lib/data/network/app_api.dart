import 'package:dio/dio.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/end_points.dart';

import 'package:flutter_app_with_clean_architecture_mvvm/data/response/responses.dart';

abstract class AppServiceClient {
  Future<HomeResponse> getHomeData();
  Future<AuthenticationResponse> login(String email, String password);
  Future<BaseResponse> forgot(String email);
  Future<AuthenticationResponse> register({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
  });
  Future<StoreDetailsResponse> getStoreDetails(int id);
}

class AppServiceClientImpl implements AppServiceClient {
  final Dio dio;
  AppServiceClientImpl({
    required this.dio,
  });
  @override
  Future<AuthenticationResponse> login(String email, String password) async {
    final response = await dio.post(
      EndPoints.login,
      data: {
        "email": email,
        "password": password,
      },
    );

    return AuthenticationResponse.fromMap(response.data);
  }

  @override
  Future<BaseResponse> forgot(String email) async {
    final response = await dio.post(
      EndPoints.forgot,
      data: {
        "email": email,
      },
    );

    return BaseResponse.fromMap(response.data);
  }

  @override
  Future<AuthenticationResponse> register({
    required String name,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    final response = await dio.post(
      EndPoints.register,
      data: {
        "email": email,
        "password": password,
        "name": name,
        "phone_number": phoneNumber,
      },
    );

    return AuthenticationResponse.fromMap(response.data);
  }

  @override
  Future<HomeResponse> getHomeData() async {
    final response = await dio.get(EndPoints.home);

    return HomeResponse.fromMap(response.data);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails(int id) async {
    final response = await dio.get(EndPoints.storeDetails + "/$id");

    return StoreDetailsResponse.fromMap(response.data);
  }
}
