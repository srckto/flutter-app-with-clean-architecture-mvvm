import 'dart:async';

import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/domain/usecase/home_usecase.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/base/base_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';


class HomeViewModel extends BaseViewModel with HomeViewModelInput, HomeViewModelOutput {
  final HomeUseCase homeUseCase;

  final StreamController<List<BannerAd>> _bannersStreamController =
      BehaviorSubject<List<BannerAd>>();

  final StreamController<List<Service>> _servicesStreamController =
      BehaviorSubject<List<Service>>();

  final StreamController<List<Store>> _storesStreamController =
      BehaviorSubject<List<Store>>();

  HomeViewModel({
    required this.homeUseCase,
  });

  @override
  void start() {
    getHomeData();
  }

  @override
  void dispose() {
    _bannersStreamController.close();
    _servicesStreamController.close();
    _storesStreamController.close();
    super.dispose();
  }

  @override
  Future<void> getHomeData() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));

    final response = await homeUseCase.execute(null);
    response.fold((failure) {
      inputState.add(
        ErrorState(
          stateRendererType: StateRendererType.FULL_SCREEN_ERROR_STATE,
          message: failure.message,
        ),
      );
    }, (homeObject) {
      inputBanners.add(homeObject.data?.banners ?? []);
      inputServices.add(homeObject.data?.services ?? []);
      inputStores.add(homeObject.data?.stores ?? []);
      inputState.add(ContentState());
    });
  }

  @override
  Sink<List<BannerAd>> get inputBanners => _bannersStreamController.sink;

  @override
  Sink<List<Service>> get inputServices => _servicesStreamController.sink;

  @override
  Sink<List<Store>> get inputStores => _storesStreamController.sink;

  @override
  Stream<List<BannerAd>> get outputBanners => _bannersStreamController.stream;

  @override
  Stream<List<Service>> get outputServices => _servicesStreamController.stream;

  @override
  Stream<List<Store>> get outputStores => _storesStreamController.stream;
}

abstract class HomeViewModelInput {
  Sink<List<BannerAd>> get inputBanners;
  Sink<List<Store>> get inputStores;
  Sink<List<Service>> get inputServices;
  Future<void> getHomeData();
}

abstract class HomeViewModelOutput {
  Stream<List<BannerAd>> get outputBanners;
  Stream<List<Store>> get outputStores;
  Stream<List<Service>> get outputServices;
}
