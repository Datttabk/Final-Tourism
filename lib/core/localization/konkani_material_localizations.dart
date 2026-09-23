import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Fallback localizations delegate ensuring Material widgets operate
/// without missing-delegate exceptions under Konkani ('kok').
class KonkaniMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const KonkaniMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'kok';

  @override
  Future<MaterialLocalizations> load(Locale locale) {
    return DefaultMaterialLocalizations.load(locale);
  }

  @override
  bool shouldReload(KonkaniMaterialLocalizationsDelegate old) => false;
}

/// Fallback localizations delegate ensuring Cupertino widgets operate
/// without missing-delegate exceptions under Konkani ('kok').
class KonkaniCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const KonkaniCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'kok';

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return DefaultCupertinoLocalizations.load(locale);
  }

  @override
  bool shouldReload(KonkaniCupertinoLocalizationsDelegate old) => false;
}
