import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/app_storage.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/di.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();

  static final MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppStorage _appStorage = sl<AppStorage>();

  @override
  void didChangeDependencies() {
    _appStorage.getLocale().then((local) {
      context.setLocale(local);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
      // home: HomeScreen(),
    );
  }
}
