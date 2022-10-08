import 'dart:async';

import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/base/base_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingViewModelInputs, OnboardingViewModelOutputs {
  final StreamController<List<SliderObject>> _streamController =
      StreamController<List<SliderObject>>();

  late final List<SliderObject> _items;
  late int currentIndex;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  Sink<List<SliderObject>> get inputSliderViewObject => _streamController.sink;

  @override
  Stream<List<SliderObject>> get outputSliderViewObject =>
      _streamController.stream.map((event) => event);

  @override
  void start() {
    currentIndex = 0;
    _items = _getSliderData();
    _postDataToView();
  }

  @override
  int goNextSlide() {
    if (currentIndex == _items.length - 1) {
      return 0;
    } else {
      return ++currentIndex;
    }
  }

  @override
  int goPreviousSlide() {
    if (currentIndex == 0) {
      return _items.length - 1;
    } else {
      return --currentIndex;
    }
  }

  @override
  void onPageChanged(int index) {
    currentIndex = index;
    _postDataToView();
  }

  //* Private Functions
  List<SliderObject> _getSliderData() => [
        SliderObject(
          title: AppStrings.onBoardingTitle1,
          subTitle: AppStrings.onBoardingSubTitle1,
          image: ImageAssets.onboardingLogo1,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle2,
          subTitle: AppStrings.onBoardingSubTitle2,
          image: ImageAssets.onboardingLogo2,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle3,
          subTitle: AppStrings.onBoardingSubTitle3,
          image: ImageAssets.onboardingLogo3,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle4,
          subTitle: AppStrings.onBoardingSubTitle4,
          image: ImageAssets.onboardingLogo4,
        ),
      ];

  void _postDataToView() {
    inputSliderViewObject.add(_items);
  }
}

abstract class OnboardingViewModelInputs {
  int goNextSlide();
  int goPreviousSlide();
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class OnboardingViewModelOutputs {
  Stream get outputSliderViewObject;
}
