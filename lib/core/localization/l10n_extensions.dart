import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../l10n/generated/app_localizations_en.dart';

export '../../l10n/generated/app_localizations.dart';

/// Extension providing safe access to [AppLocalizations] with automatic
/// fallback to English ([AppLocalizationsEn]) when localizations delegates
/// are not present in the widget tree (e.g., bare test harnesses).
extension LocalizedBuildContext on BuildContext {
  AppLocalizations get l10n {
    return Localizations.of<AppLocalizations>(this, AppLocalizations) ??
        AppLocalizationsEn();
  }
}

/// Standalone safe getter for [AppLocalizations].
AppLocalizations appL10n(BuildContext context) {
  return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
      AppLocalizationsEn();
}
