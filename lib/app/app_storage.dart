import 'package:flutter/material.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/app/constants.dart';
import 'package:flutter_app_with_clean_architecture_mvvm/presentation/resources/language_manager.dart';
import 'package:get_storage/get_storage.dart';

class AppStorage {
  final GetStorage getStorage;
  AppStorage({
    required this.getStorage,
  });

  //! ERASE STORAGE
  Future<void> erase() async {
    return await getStorage.erase();
  }

  //! APPLICATION LANGUAGE
  String getApplicationLanguage() {
    return getStorage.read(Constants.storageLanguageKey) ?? LanguageType.ENGLISH.getLanguageCode();
  }

  Future<void> setApplicationLanguage(String langCode) async {
    getStorage.write(Constants.storageLanguageKey, langCode);
  }

  Future<void> changeApplicationLanguage() async {
    String lang = getApplicationLanguage();
    if (lang == LanguageType.ENGLISH.getLanguageCode()) {
      await setApplicationLanguage(LanguageType.ARABIC.getLanguageCode());
    } else {
      await setApplicationLanguage(LanguageType.ENGLISH.getLanguageCode());
    }
  }

  Future<Locale> getLocale() async {
    String lang = getApplicationLanguage();
    if (lang == LanguageType.ENGLISH.getLanguageCode()) {
      return ENGLISH_LOCAL;
    } else {
      return ARABIC_LOCAL;
    }
  }

  //! ON_BOARDING
  Future<void> setOnboardingViewed() async {
    return await getStorage.write(Constants.storageOnboardingKey, true);
  }

  bool isOnboardingViewed() {
    return getStorage.read(Constants.storageOnboardingKey) ?? false;
  }

  //! LOGIN
  Future<void> setIsUserLoggedIn() async {
    return await getStorage.write(Constants.storageLoginKey, true);
  }

  bool isLoggedIn() {
    return getStorage.read(Constants.storageLoginKey) ?? false;
  }
}
