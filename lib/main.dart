import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/app.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/di.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/language_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    EasyLocalization(
      path: ASSETS_PATH_LOCALIZATION,
      supportedLocales: [ARABIC_LOCAL, ENGLISH_LOCAL],
      child: Phoenix(child: MyApp()),
    ),
  );
}
