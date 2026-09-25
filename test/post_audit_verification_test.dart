import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vijayapura_tourism/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:vijayapura_tourism/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:vijayapura_tourism/features/auth/presentation/widgets/auth_header_logos.dart';
import 'package:vijayapura_tourism/features/discover/data/repositories/local_discover_repository.dart';
import 'package:vijayapura_tourism/features/profile/presentation/screens/about_vijayapura_screen.dart';
import 'package:vijayapura_tourism/l10n/generated/app_localizations.dart';

Widget _buildTestApp(Widget child) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: child,
  );
}

void main() {
  group('Post-Audit Verification Tests', () {
    testWidgets('1. About Vijayapura Supporters & Team Verification', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1000, 3000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_buildTestApp(const AboutVijayapuraScreen()));
      await tester.pumpAndSettle();

      // Verify all 4 supporters
      expect(find.text('Dr. Anandh K'), findsOneWidget);
      expect(find.text('Shri. Aravind Hugar'), findsOneWidget);
      expect(find.text('Dr. Sumangala Biradar'), findsOneWidget);
      expect(find.text('Dr. Manjunatha P'), findsOneWidget);

      // Verify Dr. Manjunatha P designation
      expect(
        find.text(
          "Principal, BLDEA's Vachana Pitamaha Dr. P. G. Halakatti College of Engineering and Technology",
        ),
        findsOneWidget,
      );

      // Verify Content Supporter
      expect(find.text('Content Supporter'), findsOneWidget);
      expect(find.text('Mr. Anilkumar Banajiger'), findsOneWidget);

      // Verify Development Team
      expect(find.text('Development Team'), findsOneWidget);
      expect(find.text('Datta Kambagi'), findsOneWidget);
      expect(find.text('Yaris Nadaf'), findsOneWidget);
      expect(find.text('Ishwar Shatagar'), findsOneWidget);
      expect(find.text('Darshan Wali'), findsOneWidget);
      expect(find.text('LinkedIn'), findsNWidgets(4));

      // Verify Connect With Us / Social media links
      expect(find.text('Connect With Us'), findsOneWidget);
      expect(find.text('Instagram'), findsOneWidget);
      expect(find.text('Facebook'), findsOneWidget);
      expect(find.text('YouTube'), findsOneWidget);
    });

    testWidgets('2. AuthHeaderLogos renders in SignIn and SignUp', (
      WidgetTester tester,
    ) async {
      // SignInScreen has AuthHeaderLogos
      await tester.pumpWidget(_buildTestApp(const SignInScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(AuthHeaderLogos), findsOneWidget);

      // SignUpScreen has AuthHeaderLogos
      await tester.pumpWidget(_buildTestApp(const SignUpScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(AuthHeaderLogos), findsOneWidget);
    });

    test('3. Verify 61 Hotels and 5 Specific Hotel Maps URLs', () async {
      final repo = LocalDiscoverRepository();
      final hotels = await repo.getHotels();
      expect(hotels.length, equals(61));

      // 1. Spoorti Resort & Clubhouse
      final spoorti = hotels.firstWhere((h) => h.name.contains('Spoorti'));
      expect(spoorti.hasValidMapsUrl, isTrue);
      expect(
        spoorti.mapsUrl,
        equals(
          'https://www.google.com/maps/place/?q=place_id:ChIJIamuXsf_xjsRYRTsjguGCmU',
        ),
      );

      // 2. Hotel Le Grande
      final leGrande = hotels.firstWhere((h) => h.name.contains('Le Grande'));
      expect(leGrande.hasValidMapsUrl, isTrue);
      expect(
        leGrande.mapsUrl,
        equals(
          'https://www.google.com/maps/place/?q=place_id:ChIJayC0iqj_xjsRlM4BiTZ8iQA',
        ),
      );

      // 3. Hotel Town Palace
      final townPalace = hotels.firstWhere(
        (h) => h.name.contains('Town Palace'),
      );
      expect(townPalace.hasValidMapsUrl, isTrue);
      expect(
        townPalace.mapsUrl,
        equals(
          'https://www.google.com/maps/place/?q=place_id:ChIJV6piAKf_xjsR3aMM_WRugiE',
        ),
      );

      // 4. Hotel Kyriad
      final kyriad = hotels.firstWhere((h) => h.name.contains('Kyriad'));
      expect(kyriad.hasValidMapsUrl, isTrue);
      expect(
        kyriad.mapsUrl,
        equals(
          'https://www.google.com/maps/place/?q=place_id:ChIJI1zj-wBVxjsRZmfeqpt6vzc',
        ),
      );

      // 5. Hotel Mayura Adil Shahi
      final mayura = hotels.firstWhere(
        (h) => h.name.contains('Mayura Adil Shahi'),
      );
      expect(mayura.hasValidMapsUrl, isTrue);
      expect(
        mayura.mapsUrl,
        equals(
          'https://www.google.com/maps/place/?q=place_id:ChIJK58CJXlVxjsRsfZk7YccLFc',
        ),
      );
    });
  });
}
