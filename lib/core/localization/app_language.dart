import 'package:flutter/material.dart';

/// The 8 supported regional and national languages for Vijayapura Tourism.
enum AppLanguage {
  english(
    code: 'en',
    displayName: 'English',
    nativeName: 'English',
    locale: Locale('en'),
  ),
  kannada(
    code: 'kn',
    displayName: 'Kannada',
    nativeName: 'ಕನ್ನಡ',
    locale: Locale('kn'),
  ),
  hindi(
    code: 'hi',
    displayName: 'Hindi',
    nativeName: 'हिन्दी',
    locale: Locale('hi'),
  ),
  marathi(
    code: 'mr',
    displayName: 'Marathi',
    nativeName: 'मराठी',
    locale: Locale('mr'),
  ),
  telugu(
    code: 'te',
    displayName: 'Telugu',
    nativeName: 'తెలుగు',
    locale: Locale('te'),
  ),
  tamil(
    code: 'ta',
    displayName: 'Tamil',
    nativeName: 'தமிழ்',
    locale: Locale('ta'),
  ),
  malayalam(
    code: 'ml',
    displayName: 'Malayalam',
    nativeName: 'മലയാളം',
    locale: Locale('ml'),
  ),
  konkani(
    code: 'kok',
    displayName: 'Konkani',
    nativeName: 'कोंकणी',
    locale: Locale('kok'),
  );

  final String code;
  final String displayName;
  final String nativeName;
  final Locale locale;

  const AppLanguage({
    required this.code,
    required this.displayName,
    required this.nativeName,
    required this.locale,
  });

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => AppLanguage.english,
    );
  }

  static AppLanguage fromLocale(Locale locale) {
    return AppLanguage.values.firstWhere(
      (lang) => lang.locale.languageCode == locale.languageCode,
      orElse: () => AppLanguage.english,
    );
  }
}
