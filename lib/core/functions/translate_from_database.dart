import 'package:test/core/services/storage%20services/store_language_service.dart';
import 'package:flutter/material.dart';

String translateFromDatabase(String arabicWord, String englishWord) {
  if (StoreLanguageService().getLocale() == const Locale('en')) {
    // just for testing
    return arabicWord;
  } else {
    return arabicWord;
  }
}
