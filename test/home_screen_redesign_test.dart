import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vijayapura_tourism/core/localization/app_language.dart';
import 'package:vijayapura_tourism/core/localization/konkani_material_localizations.dart';
import 'package:vijayapura_tourism/core/localization/locale_controller.dart';
import 'package:vijayapura_tourism/core/theme/app_theme.dart';
import 'package:vijayapura_tourism/features/explore/data/repositories/local_places_repository.dart';
import 'package:vijayapura_tourism/features/explore/domain/models/place.dart';
import 'package:vijayapura_tourism/features/home/presentation/widgets/featured_monument_carousel.dart';
import 'package:vijayapura_tourism/features/home/presentation/widgets/home_discover_preview.dart';
import 'package:vijayapura_tourism/features/home/presentation/widgets/home_header.dart';
import 'package:vijayapura_tourism/features/home/presentation/widgets/home_language_section.dart';
import 'package:vijayapura_tourism/features/home/presentation/widgets/home_plans_preview.dart';
import 'package:vijayapura_tourism/features/home/presentation/widgets/quick_explore_gateway.dart';
import 'package:vijayapura_tourism/l10n/generated/app_localizations.dart';

Widget _wrapWithLocalization(Widget child, {Locale? locale}) {
  return MaterialApp(
    theme: AppTheme.light(),
    locale: locale ?? const Locale('en'),
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
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await LocaleController.instance.initialize();
  });

  group('Home Page Redesign Domain & Repository Tests', () {
    late LocalPlacesRepository placesRepo;

    setUp(() {
      placesRepo = LocalPlacesRepository();
    });

    test('Basavana Bagewadi exists as canonical Place with verified neutral description', () async {
      final basavanaBagewadi = await placesRepo.getPlaceById(
        'basavana_bagewadi',
      );
      expect(basavanaBagewadi, isNotNull);
      expect(basavanaBagewadi!.name, equals('Basavana Bagewadi'));
      expect(basavanaBagewadi.category, equals('Temples & Shrines'));
      expect(basavanaBagewadi.shortDescription, isNotEmpty);
      expect(basavanaBagewadi.historicalOverview, isNotEmpty);
      expect(basavanaBagewadi.coordinates.latitude, isNonZero);
      expect(basavanaBagewadi.coordinates.longitude, isNonZero);

      final legacyAlias = await placesRepo.getPlaceById('basavanagudi');
      expect(legacyAlias, isNotNull);
      expect(legacyAlias!.name, equals('Basavana Bagewadi'));
    });

    test(
      'All four featured carousel monuments exist in LocalPlacesRepository',
      () async {
        const ids = [
          'gol_gumbaz',
          'ibrahim_rauza',
          'bara_kaman',
          'basavanagudi',
        ];
        for (final id in ids) {
          final place = await placesRepo.getPlaceById(id);
          expect(place, isNotNull, reason: 'Place $id should exist');
        }
      },
    );

    test('AppLanguage includes all 8 supported languages', () {
      expect(AppLanguage.values.length, equals(8));
      final names = AppLanguage.values.map((l) => l.displayName).toList();
      expect(
        names,
        containsAll([
          'English',
          'Kannada',
          'Hindi',
          'Marathi',
          'Konkani',
          'Telugu',
          'Tamil',
          'Malayalam',
        ]),
      );
    });
  });

  group('Home Page Widget Tests', () {
    testWidgets('HomeHeader displays personalized greeting from displayName', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrapWithLocalization(
          HomeHeader(displayName: 'Darshan', onProfileTap: () {}),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Namaskara, Darshan'), findsOneWidget);
      expect(find.text('Discover the heritage of Vijayapura'), findsOneWidget);
    });

    testWidgets('HomeHeader falls back to Traveller when displayName is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        _wrapWithLocalization(
          HomeHeader(displayName: null, onProfileTap: () {}),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Namaskara, Traveller'), findsOneWidget);
    });

    testWidgets(
      'Language selector displays all 8 languages and switches to Kannada',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1000, 1600);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await LocaleController.instance.setLanguage(AppLanguage.english);

        await tester.pumpWidget(
          ListenableBuilder(
            listenable: LocaleController.instance,
            builder: (context, _) {
              return MaterialApp(
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
                home: Scaffold(
                  body: HomeHeader(displayName: 'Datta', onProfileTap: () {}),
                ),
              );
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('English'), findsOneWidget);

        // Tap language selector
        await tester.tap(find.text('English'));
        await tester.pumpAndSettle();

        // Verify modal opened with all 8 languages
        expect(find.text('Select Preferred Language'), findsOneWidget);
        expect(find.text('ಕನ್ನಡ'), findsOneWidget);
        expect(find.text('हिन्दी'), findsOneWidget);
        expect(find.text('मराठी'), findsOneWidget);
        expect(find.text('कोंकणी'), findsOneWidget);
        expect(find.text('తెలుగు'), findsOneWidget);
        expect(find.text('தமிழ்'), findsOneWidget);
        expect(find.text('മലയാളം'), findsOneWidget);

        // Select Kannada
        await tester.tap(find.text('ಕನ್ನಡ'));
        await tester.pumpAndSettle();

        // Check that Kannada greeting is now visible
        expect(find.text('ನಮಸ್ಕಾರ, Datta'), findsOneWidget);
      },
    );

    testWidgets(
      'FeaturedMonumentCarousel renders exactly 4 monuments with Explore Details CTA',
      (WidgetTester tester) async {
        final placesRepo = LocalPlacesRepository();
        final places = [
          (await placesRepo.getPlaceById('gol_gumbaz'))!,
          (await placesRepo.getPlaceById('ibrahim_rauza'))!,
          (await placesRepo.getPlaceById('bara_kaman'))!,
          (await placesRepo.getPlaceById('basavanagudi'))!,
        ];

        Place? tappedPlace;

        await tester.pumpWidget(
          _wrapWithLocalization(
            FeaturedMonumentCarousel(
              featuredPlaces: places,
              onExploreDetails: (p) => tappedPlace = p,
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Gol Gumbaz'), findsOneWidget);
        expect(find.text('Explore Details'), findsWidgets);

        // Tap Explore Details
        await tester.tap(find.text('Explore Details').first);
        expect(tappedPlace, isNotNull);
        expect(tappedPlace!.name, equals('Gol Gumbaz'));
      },
    );

    testWidgets('QuickExploreGateway renders single Explore CTA', (
      WidgetTester tester,
    ) async {
      bool explored = false;

      await tester.pumpWidget(
        _wrapWithLocalization(
          QuickExploreGateway(onExploreTap: () => explored = true),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Explore Vijayapura'), findsOneWidget);
      await tester.tap(find.text('Explore'));
      expect(explored, isTrue);
    });

    testWidgets('HomePlansPreview renders plan cards and View All Plans CTA', (
      WidgetTester tester,
    ) async {
      bool viewedPlans = false;

      await tester.pumpWidget(
        _wrapWithLocalization(
          HomePlansPreview(onViewAllTap: () => viewedPlans = true),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Plan Your Visit'), findsOneWidget);
      expect(find.text('View All Plans'), findsOneWidget);
      expect(find.text('One Day in Vijayapur'), findsOneWidget);

      await tester.tap(find.text('View All Plans'));
      expect(viewedPlans, isTrue);
    });

    testWidgets(
      'HomeDiscoverPreview renders 4 categories and Discover More CTA',
      (WidgetTester tester) async {
        bool discovered = false;

        await tester.pumpWidget(
          _wrapWithLocalization(
            HomeDiscoverPreview(onDiscoverMoreTap: () => discovered = true),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('Discover Local'), findsOneWidget);
        expect(find.text('Discover More'), findsOneWidget);
        expect(find.text('Hotels & Stay'), findsOneWidget);
        expect(find.text('Local Cuisine'), findsOneWidget);
        expect(find.text('Bazaars & Craft'), findsOneWidget);
        expect(find.text('Tourist Guides'), findsOneWidget);

        await tester.tap(find.text('Discover More'));
        expect(discovered, isTrue);
      },
    );

    testWidgets(
      'HomeLanguageSection renders language card and allows opening selector',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          _wrapWithLocalization(const HomeLanguageSection()),
        );
        await tester.pumpAndSettle();

        expect(find.text('Choose Your Language'), findsOneWidget);
        expect(find.text('Change Language'), findsOneWidget);
        expect(find.text('English'), findsWidgets);

        await tester.tap(find.text('Change Language'));
        await tester.pumpAndSettle();

        expect(find.text('Select Preferred Language'), findsOneWidget);
      },
    );
  });
}
