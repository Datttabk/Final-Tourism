import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/localization/konkani_material_localizations.dart';
import 'core/localization/locale_controller.dart';
import 'core/routing/app_router.dart';
import 'core/services/user_activity_controller.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/web_plugins.dart';
import 'firebase_options.dart';
import 'l10n/generated/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize web plugins (Firebase Web, SharedPreferences)
  initWebPlugins();

  // Initialize persistent locale preference before app renders
  await LocaleController.instance.initialize();

  // Initialize persistent user bookmarks, saved plans, and recently viewed
  await UserActivityController.instance.initialize();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization: $e');
  }

  runApp(const VijayapuraTourismApp());
}

class VijayapuraTourismApp extends StatelessWidget {
  const VijayapuraTourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vijayapura Tourism',
          theme: AppTheme.light(),
          locale: LocaleController.instance.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            KonkaniMaterialLocalizationsDelegate(),
            KonkaniCupertinoLocalizationsDelegate(),
          ],
          initialRoute: '/',
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
