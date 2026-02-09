import 'package:flutter/material.dart';

class LanguageController extends ValueNotifier<Locale> {
  LanguageController._() : super(const Locale('en'));

  static final LanguageController instance = LanguageController._();

  void setLanguage(String languageCode) {
    value = Locale(languageCode);
  }
}
