import 'package:flutter_app_with_clean_architecture_mvvm/app/app_storage.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/data_source/remote_data_source.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/app_api.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/dio_factory.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/network/network_info.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/data/repository/repository_impl.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/repository/repository.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/forgot_usecase.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/home_usecase.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/login_usecase.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/register_usecase.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/store_details_usecase.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/forgot_password/viewmodel/forgot_password_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/store_details/viewmodel/store_details_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> initAppModule() async {
  //! External
  await GetStorage.init();
  sl.registerLazySingleton<GetStorage>(() => GetStorage());
  sl.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());

  //! Services
  sl.registerLazySingleton(() => AppStorage(getStorage: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(internetConnectionChecker: sl()));

  sl.registerLazySingleton<DioFactory>(() => DioFactory(appStorage: sl()));

  sl.registerLazySingleton<AppServiceClient>(
      () => AppServiceClientImpl(dio: sl<DioFactory>().getDio()));

  //! Data Sources
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(appServiceClient: sl()));

  //! Repository
  sl.registerLazySingleton<Repository>(
      () => RepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));
}

void initLoginModule() async {
  if (!sl.isRegistered<LoginUseCase>()) {
    sl.registerFactory<LoginUseCase>(() => LoginUseCase(repository: sl()));
    sl.registerFactory<LoginViewModel>(() => LoginViewModel(loginUseCase: sl()));
  }
}

void initForgotPasswordModule() {
  if (!sl.isRegistered<ForgotPasswordUseCase>()) {
    sl.registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(repository: sl()));
    sl.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(forgotPasswordUseCase: sl()));
  }
}

void initRegisterModule() {
  if (!sl.isRegistered<RegisterUseCase>()) {
    sl.registerFactory<RegisterUseCase>(() => RegisterUseCase(repository: sl()));
    sl.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(registerUseCase: sl(), appStorage: sl()));
  }
}

void initHomeModule() {
  if (!sl.isRegistered<HomeUseCase>()) {
    sl.registerFactory<HomeUseCase>(() => HomeUseCase(repository: sl()));
    sl.registerFactory<HomeViewModel>(() => HomeViewModel(homeUseCase: sl()));
  }
}

void initStoreDetailsModule() {
  if (!sl.isRegistered<StoreDetailsViewModel>()) {
    sl.registerFactory<StoreDetailsUseCase>(() => StoreDetailsUseCase(repository: sl()));
    sl.registerFactory<StoreDetailsViewModel>(() => StoreDetailsViewModel(storeDetailsUseCase: sl()));
  }
}
