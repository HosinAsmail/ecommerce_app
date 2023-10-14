import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/core/services/storage%20services/store_step_service.dart';

const String LANGUAGE_CODE = 'languageCode';
const String english = 'en';
const String arabic = 'ar';

class StoreLanguageService {
  SharedPreferences sharedPreferences=StoreStepService().sharedPreferences;
  Future<Locale> setLocale(String languageCode) async {
    await sharedPreferences.setString(LANGUAGE_CODE, languageCode);
    return locale(languageCode);
  }

  Locale? getLocale()  {
    String? languageCode = sharedPreferences.getString(LANGUAGE_CODE);
    if (languageCode != null) {
      return locale(languageCode);
    } else {
      return null;
    }
  }

  Locale locale(String languageCode) {
    switch (languageCode) {
      case english:
        return const Locale(english, '');
      case arabic:
        return const Locale(arabic, "");
      default:
        return const Locale(english, '');
    }
  }
}
