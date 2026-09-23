import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_language.dart';

/// Central source of truth for managing and persisting the application locale.
class LocaleController extends ChangeNotifier {
  static const String _prefKey = 'selected_app_locale_code';

  static final LocaleController _instance = LocaleController._internal();
  factory LocaleController() => _instance;
  static LocaleController get instance => _instance;

  LocaleController._internal();

  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  AppLanguage get currentLanguage => AppLanguage.fromLocale(_locale);

  /// Initializes locale from persistent local storage.
  /// Defaults to English ('en') if no language preference has been saved yet.
  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedCode = prefs.getString(_prefKey);
      if (savedCode != null && savedCode.isNotEmpty) {
        final matched = AppLanguage.fromCode(savedCode);
        _locale = matched.locale;
      } else {
        _locale = const Locale('en');
      }
    } catch (_) {
      _locale = const Locale('en');
    }
    notifyListeners();
  }

  /// Sets and persists a new locale across the application.
  Future<void> setLocale(Locale newLocale) async {
    if (_locale.languageCode == newLocale.languageCode) return;
    _locale = newLocale;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, newLocale.languageCode);
    } catch (_) {
      // Gracefully continue in-memory if storage is constrained
    }
  }

  /// Sets and persists a new language.
  Future<void> setLanguage(AppLanguage language) async {
    await setLocale(language.locale);
  }
}
