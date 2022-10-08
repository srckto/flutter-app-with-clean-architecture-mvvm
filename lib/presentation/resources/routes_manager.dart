import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/di.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/login/view/login_view.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/main/main_view.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/onboarding/view/onboarding_view.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/register/view/register_view.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/splash/splash_view.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/store_details/view/store_details_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onboardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());

      case Routes.onboardingRoute:
        return MaterialPageRoute(builder: (_) => OnboardingView());

      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => LoginView());

      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => RegisterView());

      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());

      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => MainView());

      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => StoreDetailsView());

      default:
        return _undefinedRoute();
    }
  }

  static MaterialPageRoute _undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text(
            AppStrings.noRouteFound,
          ),
        ),
      ),
    );
  }
}
