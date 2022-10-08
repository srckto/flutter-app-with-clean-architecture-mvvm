
import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/app_storage.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/di.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/constants_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  AppStorage _appStorage = sl<AppStorage>();

  void _delayAndGoNext() async {
    await Future.delayed(Duration(seconds: AppConstants.splashDelay));

    // TODO : REMOVE THIS LINE OR COMMENT
    // await _appStorage.erase();
    
    if (!_appStorage.isOnboardingViewed()) {
      Navigator.pushReplacementNamed(context, Routes.onboardingRoute);
      return;
    }
    if (!_appStorage.isLoggedIn()) {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
      return;
    }
    Navigator.pushReplacementNamed(context, Routes.mainRoute);
  }

  @override
  void initState() {
    _delayAndGoNext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image.asset(ImageAssets.splashLogo),
      ),
    );
  }
}
