import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/app_storage.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/di.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_app_with_clean_architecture_mvvm/domain/model/models.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/onboarding/view_model/onboarding_viewmodel.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/constants_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/values_manager.dart';

class OnboardingView extends StatefulWidget {
  OnboardingView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  final OnboardingViewModel onboardingViewModel = OnboardingViewModel();
  AppStorage _appStorage = sl<AppStorage>();

  @override
  void initState() {
    onboardingViewModel.start();
    _appStorage.setOnboardingViewed();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    onboardingViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<List<SliderObject>>(
          stream: onboardingViewModel.outputSliderViewObject,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container();
            }
            if (snapshot.hasError) {
              return Container();
            }
            return Scaffold(
              body: PageView.builder(
                controller: _pageController,
                itemCount: snapshot.data?.length,
                onPageChanged: (index) {
                  onboardingViewModel.onPageChanged(index);
                },
                itemBuilder: (context, index) {
                  return _BuildOnboardingPage(
                    sliderObject: snapshot.data![index],
                  );
                },
              ),
              bottomSheet: _BuildBottomSheet(
                onboardingViewModel: onboardingViewModel,
                pageController: _pageController,
                slidersObject: snapshot.data!,
              ),
            );
          }),
    );
  }
}

class _BuildOnboardingPage extends StatelessWidget {
  final SliderObject sliderObject;
  const _BuildOnboardingPage({
    Key? key,
    required this.sliderObject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: AppSize.s80),
        Text(
          sliderObject.title.tr(),
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            sliderObject.subTitle.tr(),
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: AppSize.s60),
        SvgPicture.asset(sliderObject.image),
      ],
    );
  }
}

class _BuildBottomSheet extends StatelessWidget {
  final PageController pageController;
  final OnboardingViewModel onboardingViewModel;
  final List<SliderObject> slidersObject;
  const _BuildBottomSheet({
    Key? key,
    required this.pageController,
    required this.onboardingViewModel,
    required this.slidersObject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.loginRoute);
              },
              child: Text(
                AppStrings.skip.tr(),
              ),
            ),
          ),
          Container(
            color: ColorManager.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    pageController.animateToPage(
                      onboardingViewModel.goPreviousSlide(),
                      duration: Duration(milliseconds: AppConstants.sliderAnimationTime),
                      curve: Curves.linear,
                    );
                  },
                  icon: SvgPicture.asset(
                    ImageAssets.leftIcon,
                  ),
                ),
                Row(
                  children: [
                    for (int index = 0; index < slidersObject.length; index++)
                      Padding(
                        padding: const EdgeInsets.all(AppSize.s4),
                        child: SvgPicture.asset(
                          index == onboardingViewModel.currentIndex
                              ? ImageAssets.hollowCircleIcon
                              : ImageAssets.solidCircleIcon,
                        ),
                      )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    pageController.animateToPage(
                      onboardingViewModel.goNextSlide(),
                      duration: Duration(milliseconds: AppConstants.sliderAnimationTime),
                      curve: Curves.linear,
                    );
                  },
                  icon: SvgPicture.asset(
                    ImageAssets.rightIcon,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
