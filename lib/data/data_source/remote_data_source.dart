import 'package:flutter_app_with_clean_architecture_mvvm/data/network/app_api.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/requests.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<BaseResponse> forgot(String email);
  Future<HomeResponse> getHomeData();
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<StoreDetailsResponse> getStoreDetails(int id);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient appServiceClient;
  RemoteDataSourceImpl({
    required this.appServiceClient,
  });

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await appServiceClient.login(loginRequest.email, loginRequest.password);
  }

  @override
  Future<BaseResponse> forgot(String email) async {
    return await appServiceClient.forgot(email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest) async {
    return await appServiceClient.register(
      name: registerRequest.name,
      email: registerRequest.email,
      phoneNumber: registerRequest.phoneNumber,
      password: registerRequest.password,
    );
  }

  @override
  Future<HomeResponse> getHomeData() async {
    return await appServiceClient.getHomeData();
  }
  
  @override
  Future<StoreDetailsResponse> getStoreDetails(int id) async {
    return await appServiceClient.getStoreDetails(id);
  }
}
