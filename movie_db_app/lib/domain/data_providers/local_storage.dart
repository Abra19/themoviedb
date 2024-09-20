import 'package:flutter/material.dart';

class LocalStorage {
  String _localeTag = 'ru';
  String get localeTag => _localeTag;

  bool updateLocale(Locale locale) {
    final String localeTag = locale.toLanguageTag();
    if (_localeTag == localeTag) {
      return false;
    }
    _localeTag = localeTag;
    return true;
  }
}
