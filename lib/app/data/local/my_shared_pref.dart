// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/translations/localization_service.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static late SharedPreferences _sharedPreferences;

  // STORING KEYS
  static const String _fcmTokenKey = 'fcm_token';
  static const String _loginUIDKey = 'uid';
  static const String _keyUserEmail = 'email';
  static const String _currentLocalKey = 'current_local';
  static const String _lightThemeKey = 'is_theme_light';

  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  ///UID
  static Future setUID(String uid) async =>
      await _sharedPreferences.setString(_loginUIDKey, uid);
  static Future<String?> getUID() async =>
      _sharedPreferences.getString(_loginUIDKey);
  static Future<bool> removeUID() async =>
      await _sharedPreferences.remove(_loginUIDKey);

  //Email
  static setEmail(String email) =>
      _sharedPreferences.setString(_keyUserEmail, email);
  static getEmail() => _sharedPreferences.getString(_keyUserEmail);
  static removeEmail() => _sharedPreferences.remove(_keyUserEmail);

  /// set theme current type as light theme
  static void setThemeIsLight(bool lightTheme) =>
      _sharedPreferences.setBool(_lightThemeKey, lightTheme);

  /// get if the current theme type is light
  static bool getThemeIsLight() =>
      _sharedPreferences.getBool(_lightThemeKey) ?? true;

  /// save current locale
  static void setCurrentLanguage(String languageCode) =>
      _sharedPreferences.setString(_currentLocalKey, languageCode);

  /// get current locale
  static Locale getCurrentLocal() {
    String? langCode = _sharedPreferences.getString(_currentLocalKey);
    // default language is english
    if (langCode == null) {
      return LocalizationService.defaultLanguage;
    }
    return LocalizationService.supportedLanguages[langCode]!;
  }

  /// save generated fcm token
  static void setFcmToken(String token) =>
      _sharedPreferences.setString(_fcmTokenKey, token);

  /// get generated fcm token
  static String? getFcmToken() => _sharedPreferences.getString(_fcmTokenKey);
}
