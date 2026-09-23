import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vijayapura_tourism/core/localization/app_language.dart';
import 'package:vijayapura_tourism/core/localization/konkani_material_localizations.dart';
import 'package:vijayapura_tourism/core/localization/locale_controller.dart';
import 'package:vijayapura_tourism/core/services/map_navigation_service.dart';
import 'package:vijayapura_tourism/core/widgets/main_shell_screen.dart';
import 'package:vijayapura_tourism/features/explore/data/repositories/local_places_repository.dart';
import 'package:vijayapura_tourism/features/explore/domain/models/place.dart';
import 'package:vijayapura_tourism/features/explore/domain/models/place_localizations.dart';
import 'package:vijayapura_tourism/features/home/presentation/widgets/home_header.dart';
import 'package:vijayapura_tourism/features/home/presentation/widgets/home_language_section.dart';
import 'package:vijayapura_tourism/l10n/generated/app_localizations.dart';

Widget _buildLocalizedApp({required Widget child, Locale? locale}) {
  return ListenableBuilder(
    listenable: LocaleController.instance,
    builder: (context, _) {
      return MaterialApp(
        locale: locale ?? LocaleController.instance.locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          KonkaniMaterialLocalizationsDelegate(),
          KonkaniCupertinoLocalizationsDelegate(),
        ],
        home: Scaffold(body: child),
      );
    },
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await LocaleController.instance.initialize();
  });

  group('Vijayapura Tourism Multilingual Localization System', () {
    test('1. English loads by default', () async {
      expect(LocaleController.instance.locale.languageCode, equals('en'));
      expect(
        LocaleController.instance.currentLanguage,
        equals(AppLanguage.english),
      );
    });

    test('2. All 8 languages are defined with native and English scripts', () {
      expect(AppLanguage.values.length, equals(8));
      final codes = AppLanguage.values.map((l) => l.code).toList();
      expect(codes, equals(['en', 'kn', 'hi', 'mr', 'te', 'ta', 'ml', 'kok']));

      expect(AppLanguage.kannada.nativeName, equals('ಕನ್ನಡ'));
      expect(AppLanguage.hindi.nativeName, equals('हिन्दी'));
      expect(AppLanguage.marathi.nativeName, equals('मराठी'));
      expect(AppLanguage.telugu.nativeName, equals('తెలుగు'));
      expect(AppLanguage.tamil.nativeName, equals('தமிழ்'));
      expect(AppLanguage.malayalam.nativeName, equals('മലയാളം'));
      expect(AppLanguage.konkani.nativeName, equals('कोंकणी'));
    });

    test(
      '3-8. Locale switching works across all 8 languages without restart',
      () async {
        for (final lang in AppLanguage.values) {
          await LocaleController.instance.setLanguage(lang);
          expect(
            LocaleController.instance.locale.languageCode,
            equals(lang.code),
          );
          expect(LocaleController.instance.currentLanguage, equals(lang));
        }
      },
    );

    test('9. Locale persists in storage and restores on initialize', () async {
      SharedPreferences.setMockInitialValues({});
      await LocaleController.instance.initialize();
      await LocaleController.instance.setLanguage(AppLanguage.marathi);
      expect(LocaleController.instance.locale.languageCode, equals('mr'));

      // Simulate app relaunch
      final reloadedController = LocaleController();
      await reloadedController.initialize();
      expect(reloadedController.locale.languageCode, equals('mr'));
      expect(reloadedController.currentLanguage, equals(AppLanguage.marathi));
    });

    test('10. Missing localized content falls back safely to English', () {
      const place = Place(
        id: 'untranslated_place_id',
        name: 'Custom Monument',
        category: 'Monuments',
        shortDescription: 'English original description',
        historicalOverview: 'English historical overview',
        imageUrl: 'https://example.com/image.jpg',
        galleryUrls: [],
        locationName: 'Vijayapura',
        coordinates: GeoCoordinates(latitude: 16.83, longitude: 75.71),
        openingTime: '06:00 AM',
        closingTime: '06:00 PM',
        ticketPriceInfo: 'Free Entry',
        suggestedDuration: '30 min',
      );

      // Testing with a locale that has no custom translation for this ID
      final localized = place.localized(const Locale('mr'));
      expect(
        localized.shortDescription,
        equals('English original description'),
      );
      expect(
        localized.historicalOverview,
        equals('English historical overview'),
      );
    });

    test(
      '11. Dynamic user greeting preserves user name across languages',
      () async {
        final locEn = await AppLocalizations.delegate.load(const Locale('en'));
        expect(locEn.homeGreeting('Darshan'), equals('Namaskara, Darshan'));

        final locKn = await AppLocalizations.delegate.load(const Locale('kn'));
        expect(locKn.homeGreeting('Darshan'), equals('ನಮಸ್ಕಾರ, Darshan'));

        final locHi = await AppLocalizations.delegate.load(const Locale('hi'));
        expect(locHi.homeGreeting('Darshan'), equals('नमस्कार, Darshan'));

        final locMr = await AppLocalizations.delegate.load(const Locale('mr'));
        expect(locMr.homeGreeting('Darshan'), equals('नमस्कार, Darshan'));

        final locTe = await AppLocalizations.delegate.load(const Locale('te'));
        expect(locTe.homeGreeting('Darshan'), equals('నమస్కారం, Darshan'));

        final locTa = await AppLocalizations.delegate.load(const Locale('ta'));
        expect(locTa.homeGreeting('Darshan'), equals('வணக்கம், Darshan'));

        final locMl = await AppLocalizations.delegate.load(const Locale('ml'));
        expect(locMl.homeGreeting('Darshan'), equals('നമസ്കാരം, Darshan'));

        final locKok = await AppLocalizations.delegate.load(
          const Locale('kok'),
        );
        expect(locKok.homeGreeting('Darshan'), equals('नमस्कार, Darshan'));
      },
    );

    test(
      '12. Four featured monuments have complete 8-language localized content',
      () async {
        final repo = LocalPlacesRepository();
        const monumentIds = [
          'gol_gumbaz',
          'ibrahim_rauza',
          'bara_kaman',
          'basavanagudi',
        ];

        for (final id in monumentIds) {
          final place = await repo.getPlaceById(id);
          expect(place, isNotNull, reason: 'Monument $id must exist');

          for (final lang in AppLanguage.values) {
            final localized = place!.localized(lang.locale);
            expect(localized.shortDescription, isNotEmpty);
            expect(localized.historicalOverview, isNotEmpty);
            expect(localized.ticketPriceInfo, isNotEmpty);
          }
        }
      },
    );

    testWidgets('13. Navigation bar remains 5 tabs with localized labels', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1000, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await LocaleController.instance.setLanguage(AppLanguage.english);

      await tester.pumpWidget(
        _buildLocalizedApp(child: const MainShellScreen()),
      );
      await tester.pumpAndSettle();

      Finder navLabel(String label) => find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text(label),
      );

      // In English
      expect(navLabel('Home'), findsOneWidget);
      expect(navLabel('Explore'), findsOneWidget);
      expect(navLabel('Plans'), findsOneWidget);
      expect(navLabel('Discover'), findsOneWidget);
      expect(navLabel('Safety'), findsOneWidget);

      // Switch to Kannada
      await LocaleController.instance.setLanguage(AppLanguage.kannada);
      await tester.pumpAndSettle();

      expect(navLabel('ಮುಖಪುಟ'), findsOneWidget);
      expect(navLabel('ಅನ್ವೇಷಿಸಿ'), findsOneWidget);
      expect(navLabel('ಯೋಜನೆಗಳು'), findsOneWidget);
      expect(navLabel('ವಿಶೇಷತೆಗಳು'), findsOneWidget);
      expect(navLabel('ಸುರಕ್ಷತೆ'), findsOneWidget);
    });

    testWidgets(
      '14. Home Language Section and Header use the same single LocaleController state',
      (WidgetTester tester) async {
        await LocaleController.instance.setLanguage(AppLanguage.english);

        await tester.pumpWidget(
          _buildLocalizedApp(
            child: Column(
              children: [
                HomeHeader(displayName: 'Darshan', onProfileTap: () {}),
                const HomeLanguageSection(),
              ],
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Check English initially rendered
        expect(find.text('Namaskara, Darshan'), findsOneWidget);
        expect(find.text('Choose Your Language'), findsOneWidget);

        // Switch language globally
        await LocaleController.instance.setLanguage(AppLanguage.marathi);
        await tester.pumpAndSettle();

        // Both Header and HomeLanguageSection must now show Marathi
        expect(find.text('नमस्कार, Darshan'), findsOneWidget);
        expect(find.text('मराठी'), findsWidgets);
        expect(find.text('आपली भाषा निवडा'), findsOneWidget);
      },
    );

    testWidgets(
      '15. Tapping HomeLanguageSection opens language selection modal with 8 languages',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1000, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await LocaleController.instance.setLanguage(AppLanguage.english);

        await tester.pumpWidget(
          _buildLocalizedApp(child: const HomeLanguageSection()),
        );
        await tester.pumpAndSettle();

        // Tap Change Language
        await tester.tap(find.text('Change Language'));
        await tester.pumpAndSettle();

        // Modal bottom sheet should display all 8 native languages
        expect(find.text('Select Preferred Language'), findsOneWidget);
        expect(find.text('English'), findsWidgets);
        expect(find.text('ಕನ್ನಡ'), findsOneWidget);
        expect(find.text('हिन्दी'), findsOneWidget);
        expect(find.text('मराठी'), findsOneWidget);
        expect(find.text('తెలుగు'), findsOneWidget);
        expect(find.text('தமிழ்'), findsOneWidget);
        expect(find.text('മലയാളം'), findsOneWidget);
        expect(find.text('कोंकणी'), findsOneWidget);
      },
    );
  });
}
