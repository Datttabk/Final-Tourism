import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vijayapura_tourism/core/theme/app_theme.dart';
import 'package:vijayapura_tourism/features/discover/data/repositories/local_discover_repository.dart';
import 'package:vijayapura_tourism/features/discover/presentation/screens/discover_screen.dart';
import 'package:vijayapura_tourism/features/discover/domain/models/discover_item.dart';
import 'package:vijayapura_tourism/features/discover/presentation/widgets/bazaar_market_card.dart';
import 'package:vijayapura_tourism/features/discover/presentation/widgets/craft_specialty_card.dart';
import 'package:vijayapura_tourism/features/discover/presentation/widgets/cuisine_card.dart';
import 'package:vijayapura_tourism/features/discover/presentation/widgets/guide_card.dart';
import 'package:vijayapura_tourism/features/discover/presentation/widgets/hotel_card.dart';
import 'package:vijayapura_tourism/features/discover/presentation/widgets/tanga_ride_card.dart';

void main() {
  group('Discover Module Repository Tests', () {
    late LocalDiscoverRepository repository;

    setUp(() {
      repository = LocalDiscoverRepository();
    });

    // 1. Hotels & Stay (Authoritative 61 spreadsheet records)
    test('Loads exactly 61 master accommodation records', () async {
      final hotels = await repository.getHotels();
      expect(hotels.length, equals(61));
    });

    test(
      'All 61 accommodation names match supplied spreadsheet dataset',
      () async {
        final hotels = await repository.getHotels();
        final expectedNames = [
          'Spoorti Resort & Club                      A Unit Of Siddharth Reality (India) Pvt. Ltd.',
          'Hotel Fern (Hotel Grand Pearl International )',
          'Hotel Le Grande',
          'Hotel Town Palace',
          'Hotel Kyriad',
          'Hotel Mayura Adil Shahi',
          'Hotel Pearl',
          'Hotel Milan INN',
          'Hotel Shubhashree comfort',
          'Hotel Basava residency',
          'Hotel Lalit Mahal',
          'Hotel Ramamangal (Golden Heights)',
          'Hotel Madhuvan International',
          'Hotel Megharaj Lodging and Boarding',
          'Hotel Kanishka International',
          'Hotel Navaratna International',
          'Hotel Heritage International',
          'Hotel Meridian -Sanman',
          'Hotel Royal Residency',
          'Hotel Magi Inn',
          'Hotel Godavari',
          'Hotel Bhavani',
          'Hotel Ratna Palace lodging and Boarding',
          'Hotel Sainath lodging, Bar & Restaurant',
          'Hotel Galaxy',
          'Hotel The clove',
          'Hotel Ashok Residency',
          'Hotel Pleasant Stay',
          'Hotel Bangalore restaurant',
          'Hotel Kohinoor Lodging and restaurant',
          'Hotel VKG Lodging and restaurant',
          'Hotel chaya Lodging and restaurant',
          'Hotel Mysore restaurant',
          'Hindustan Lodge',
          'Hotel Tourist Lodge',
          'Santosh Lodge',
          'Anand Lodge',
          'Hotel Sagar Deluxe Lodging and Boarding',
          'Hotel Atithi Comfort Lodge',
          'Hotel Blue Diamond Lodging',
          'Rajdhani Lodge Deluxe',
          'Shree Lodge',
          'Hotel vanashree',
          'Spicy Bite restaurant',
          'Hotel Indraprasta',
          'Hotel Vimochan international',
          'Hotel Ashoka Boarding & Lodging',
          'Hotel Vaibhav',
          'Hotel Highway',
          'Hotel Jaihind Bar, Lodging and restaurant',
          'Hotel Mayura Talikoti',
          'Hotel Basaveshwara Lodging and restaurant',
          'Hotel BKT Lodging and Boarding',
          'Hotel Shiva wayside amenities',
          'Hotel Arpitha Lodging, Bar & restaurant',
          'Hotel Anand lodging and Boarding',
          'Hotel Prakash Lodging, Boarding and Restaurant',
          'Hotel Sanghavi Lodging and Boarding',
          'Hotel Tourist Lodging and Boarding',
          'Hotel Kanni Lodging and Boarding',
          'Hotel Mayur Krishna Alamatti',
        ];

        expect(hotels.length, equals(expectedNames.length));
        for (int i = 0; i < expectedNames.length; i++) {
          expect(hotels[i].name, equals(expectedNames[i]));
        }
      },
    );

    test('Accommodation addresses do not contain latitude or longitude coordinates', () async {
      final hotels = await repository.getHotels();
      for (final hotel in hotels) {
        expect(hotel.address, isNot(contains(hotel.latitude.toString())));
        expect(hotel.address, isNot(contains(hotel.longitude.toString())));
        expect(hotel.latitude, isNot(0.0));
        expect(hotel.longitude, isNot(0.0));
      }
    });

    test('Updated Maps records have verified Google Maps place URLs', () async {
      final hotels = await repository.getHotels();
      final leGrande = hotels.firstWhere((h) => h.name.contains('Le Grande'));
      expect(
        leGrande.mapsUrl,
        equals(
          'https://www.google.com/maps/place/?q=place_id:ChIJayC0iqj_xjsRlM4BiTZ8iQA',
        ),
      );
      expect(leGrande.isApproximateLocation, isFalse);

      final kyriad = hotels.firstWhere((h) => h.name == 'Hotel Kyriad');
      expect(
        kyriad.mapsUrl,
        equals(
          'https://www.google.com/maps/place/?q=place_id:ChIJI1zj-wBVxjsRZmfeqpt6vzc',
        ),
      );
      expect(kyriad.isApproximateLocation, isFalse);

      final mayura = hotels.firstWhere(
        (h) => h.name == 'Hotel Mayura Adil Shahi',
      );
      expect(
        mayura.mapsUrl,
        equals(
          'https://www.google.com/maps/place/?q=place_id:ChIJK58CJXlVxjsRsfZk7YccLFc',
        ),
      );
      expect(mayura.isApproximateLocation, isFalse);
    });

    test('All 61 accommodations have valid launchable URLs', () async {
      final hotels = await repository.getHotels();
      final withMaps = hotels.where((h) => h.hasValidMapsUrl).toList();
      expect(withMaps.length, equals(61));
    });

    test(
      'Accommodation search by name, address, taluka, and destination works',
      () async {
        final byName = await repository.getHotels(searchQuery: 'Spoorti');
        expect(byName.length, equals(1));
        expect(byName.first.name, contains('Spoorti'));

        final byFern = await repository.getHotels(searchQuery: 'Fern');
        expect(byFern.length, equals(1));
        expect(byFern.first.name, contains('Fern'));

        final byTalikoti = await repository.getHotels(searchQuery: 'Talikoti');
        expect(byTalikoti.length, greaterThanOrEqualTo(1));

        final byAlmatti = await repository.getHotels(searchQuery: 'Alamatti');
        expect(byAlmatti.length, greaterThanOrEqualTo(1));
      },
    );

    // 2. Tourist Guides
    test('Loads exactly 7 master tourist guides', () async {
      final guides = await repository.getTouristGuides();
      expect(guides.length, equals(7));

      final expectedNames = [
        'Rajshekhar Swaminath',
        'Sardar Jadhav',
        'Ramesh Chauhan',
        'Jahangir Kudagi',
        'Abdul Razak',
        'Shridhar Irsur',
        'Srimant Kati',
      ];

      for (int i = 0; i < expectedNames.length; i++) {
        expect(guides[i].name, equals(expectedNames[i]));
        expect(guides[i].contactNumber, isNotEmpty);
        expect(guides[i].experience, isNotEmpty);
        expect(guides[i].languagesSpoken, isNotEmpty);
      }
    });

    test('Tourist guide search by language works', () async {
      final germanGuides = await repository.getTouristGuides(
        searchQuery: 'German',
      );
      expect(germanGuides.length, equals(1));
      expect(germanGuides.first.name, equals('Jahangir Kudagi'));

      final marathiGuides = await repository.getTouristGuides(
        searchQuery: 'Marathi',
      );
      expect(marathiGuides.length, equals(1));
      expect(marathiGuides.first.name, equals('Ramesh Chauhan'));
    });

    // 3. Traditional Bazaars & Commercial Markets
    test('Loads 9 bazaars (Smarnika first + 8 traditional markets) with accurate fields and null coordinates', () async {
      final bazaars = await repository.getBazaars();
      expect(bazaars.length, equals(9));

      // Verify Smarnika is at index 0
      final smarnika = bazaars.first;
      expect(smarnika.id, equals('bazaar_smarnika'));
      expect(smarnika.name, equals('Smarnika'));
      expect(smarnika.description, contains('Gol Gumbaz history'));
      expect(smarnika.address, equals('Within Gol Gumbaz Monument Premises'));
      expect(smarnika.landmark, equals('Gol Gumbaz Tourism Area'));
      expect(smarnika.imageUrl, equals('assets/images/discover/smarnika.png'));
      expect(smarnika.latitude, isNull);
      expect(smarnika.longitude, isNull);
      expect(smarnika.mapsUrl, isNull);

      final expectedNames = [
        'Gandhi Chowk',
        'LBS MARKET VIJAYPURA',
        'Shastri Market',
        'Nehru Market',
        'Jolad Bazar (Jowar / Grain Market)',
        'Meenakshi Chowk Market',
        'Sunday Open Flea Market',
        'APMC Yard Vijayapura',
      ];

      for (int i = 0; i < expectedNames.length; i++) {
        final market = bazaars[i + 1];
        expect(market.name, equals(expectedNames[i]));
        expect(market.category, isNotEmpty);
        expect(market.address, isNotEmpty);
        expect(market.landmark, isNotEmpty);
        expect(market.pincode, equals('586101'));
        // Coordinates and mapsUrl must remain null
        expect(market.latitude, isNull);
        expect(market.longitude, isNull);
        expect(market.mapsUrl, isNull);
      }
    });

    test('Bazaar search by name, category, and landmark works', () async {
      final byGrain = await repository.getBazaars(searchQuery: 'Grain');
      expect(byGrain.length, equals(1));
      expect(byGrain.first.name, equals('Jolad Bazar (Jowar / Grain Market)'));

      final byLandmark = await repository.getBazaars(
        searchQuery: 'Gagan Mahal',
      );
      expect(byLandmark.length, equals(1));
      expect(byLandmark.first.name, equals('Sunday Open Flea Market'));
    });

    // 4. Traditional Crafts, Textiles & Regional Specialties
    test('Loads exactly 5 craft specialties with accurate descriptions and clusters', () async {
      final crafts = await repository.getCrafts();
      expect(crafts.length, equals(5));

      final expectedNames = [
        'Ilkal Sarees with Chikki Paras Border',
        'Lambani / Banjara Needle Embroidery',
        'Bidriware & Cast Metalware',
        'Vijayapura Raisins (Dry Grapes)',
        'Sandalwood & Wood Carvings',
      ];

      for (int i = 0; i < expectedNames.length; i++) {
        expect(crafts[i].name, equals(expectedNames[i]));
        expect(crafts[i].description, isNotEmpty);
        expect(crafts[i].productionRetailClusters, isNotEmpty);
      }
    });

    test('Craft search by name, description, and cluster works', () async {
      final byEmbroidery = await repository.getCrafts(
        searchQuery: 'Embroidery',
      );
      expect(byEmbroidery.length, equals(1));
      expect(
        byEmbroidery.first.name,
        equals('Lambani / Banjara Needle Embroidery'),
      );

      final byCluster = await repository.getCrafts(searchQuery: 'Solapur Road');
      expect(byCluster.length, greaterThanOrEqualTo(2));
    });

    // 5. Local Cuisine Entries
    test('Loads exactly 6 local cuisine entries with dish types, descriptions, and hubs', () async {
      final cuisines = await repository.getCuisines();
      expect(cuisines.length, equals(6));

      final expectedDishes = [
        'Jolada Rotti Oota',
        'Shenga Chutney & Agasi Chutney',
        'Bijapuri Biryani & Mutton Curry',
        'Mirchi Bajji & Girmit',
        'Kolhar Fish Curry & Fry',
        'Belagavi Kunda & Dharwad Peda',
      ];

      for (int i = 0; i < expectedDishes.length; i++) {
        expect(cuisines[i].name, equals(expectedDishes[i]));
        expect(cuisines[i].dishType, isNotEmpty);
        expect(cuisines[i].description, isNotEmpty);
        expect(cuisines[i].bestHubs, isNotEmpty);
      }
    });

    test('Cuisine search by dish name, dish type, and hubs works', () async {
      final byType = await repository.getCuisines(searchQuery: 'Street Food');
      expect(byType.length, equals(1));
      expect(byType.first.name, equals('Mirchi Bajji & Girmit'));

      final byHub = await repository.getCuisines(searchQuery: 'Kolhar Bridge');
      expect(byHub.length, equals(1));
      expect(byHub.first.name, equals('Kolhar Fish Curry & Fry'));
    });

    // 6. Tanga Rides (Authoritative 5 service providers)
    test('DiscoverCategory contains exactly 5 categories', () {
      expect(DiscoverCategory.values.length, equals(5));
      expect(
        DiscoverCategory.values,
        equals([
          DiscoverCategory.accommodation,
          DiscoverCategory.food,
          DiscoverCategory.bazaars,
          DiscoverCategory.guides,
          DiscoverCategory.tanga,
        ]),
      );
      expect(DiscoverCategory.tanga.title, equals('Tanga Rides'));
      expect(DiscoverCategory.tanga.shortName, equals('Tanga Rides'));
    });

    test('Loads exactly 5 master Tanga Ride service providers', () async {
      final tangaRides = await repository.getTangaRides();
      expect(tangaRides.length, equals(5));

      final expectedProviders = [
        {
          'id': 'tanga_1',
          'en': 'Rehmankhan Rasheedkhan Hakim',
          'kn': 'ರಹಿಮಾನಖಾನ ರಶೀದಖಾನ. ಹಕಿಂ',
          'phone': '9731579908',
        },
        {
          'id': 'tanga_2',
          'en': 'Jameel Harunrasheed Jamadar',
          'kn': 'ಜಮೀಲ. ಹಾರುನರಶೀದ ಜಮಾದಾರ',
          'phone': '9611616785',
        },
        {'id': 'tanga_3', 'en': 'Ravi', 'kn': 'ರವಿ.', 'phone': '7760847640'},
        {
          'id': 'tanga_4',
          'en': 'Gujju Danga',
          'kn': 'ಗುಜ್ಜು ಡಾಂಗ',
          'phone': '9945940536',
        },
        {
          'id': 'tanga_5',
          'en': 'Mudakappa',
          'kn': 'ಮುದಕಪ್ಪ',
          'phone': '9845479974',
        },
      ];

      for (int i = 0; i < expectedProviders.length; i++) {
        expect(tangaRides[i].id, equals(expectedProviders[i]['id']));
        expect(tangaRides[i].nameEn, equals(expectedProviders[i]['en']));
        expect(tangaRides[i].nameKn, equals(expectedProviders[i]['kn']));
        expect(
          tangaRides[i].contactNumber,
          equals(expectedProviders[i]['phone']),
        );
      }
    });

    test(
      'Tanga ride search by English name, Kannada name, and phone number works',
      () async {
        final byHakim = await repository.getTangaRides(searchQuery: 'Hakim');
        expect(byHakim.length, equals(1));
        expect(byHakim.first.nameEn, equals('Rehmankhan Rasheedkhan Hakim'));

        final byKn = await repository.getTangaRides(searchQuery: 'ಮುದಕಪ್ಪ');
        expect(byKn.length, equals(1));
        expect(byKn.first.nameEn, equals('Mudakappa'));

        final byPhone = await repository.getTangaRides(
          searchQuery: '7760847640',
        );
        expect(byPhone.length, equals(1));
        expect(byPhone.first.nameEn, equals('Ravi'));
      },
    );
  });

  group('DiscoverScreen Widget Tests', () {
    testWidgets(
      'Renders DiscoverScreen with 5 categories and loads hotels by default',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1000, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MaterialApp(theme: AppTheme.light(), home: const DiscoverScreen()),
        );

        await tester.pumpAndSettle();

        // Verify category chips
        expect(find.text('Hotels & Stay'), findsOneWidget);
        expect(find.text('Local Cuisine'), findsOneWidget);
        expect(find.text('Bazaars & Craft'), findsOneWidget);
        expect(find.text('Tourist Guides'), findsOneWidget);
        expect(find.text('Tanga Rides'), findsOneWidget);

        // Verify Stays count
        expect(find.text('All 61 Stays in Vijayapura'), findsOneWidget);

        // Verify Hotel cards are present
        expect(find.byType(HotelCard), findsWidgets);
        expect(find.text('Hotel Mayura Adil Shahi'), findsOneWidget);
        expect(find.text('Hotel Pearl'), findsOneWidget);
      },
    );

    testWidgets(
      'Switching to Local Cuisine renders all 6 cuisine cards with hubs and dish types',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1000, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MaterialApp(theme: AppTheme.light(), home: const DiscoverScreen()),
        );

        await tester.pumpAndSettle();

        // Tap Local Cuisine
        await tester.tap(find.text('Local Cuisine'));
        await tester.pumpAndSettle();

        expect(
          find.text('All 6 Regional Culinary Specialties'),
          findsOneWidget,
        );
        expect(find.byType(CuisineCard), findsWidgets);
        expect(find.text('Jolada Rotti Oota'), findsOneWidget);
        expect(find.text('Main Course (Vegetarian)'), findsOneWidget);
        expect(find.text('Bijapuri Biryani & Mutton Curry'), findsOneWidget);
        expect(find.text('Main Course (Non-Vegetarian)'), findsOneWidget);
        expect(find.text('Kolhar Fish Curry & Fry'), findsOneWidget);
        expect(find.text('Regional Specialty'), findsOneWidget);
      },
    );

    testWidgets(
      'Switching to Bazaars & Craft renders 9 markets (including Smarnika) and 5 craft specialties',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1000, 3200);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MaterialApp(theme: AppTheme.light(), home: const DiscoverScreen()),
        );

        await tester.pumpAndSettle();

        // Tap Bazaars & Craft
        await tester.tap(find.text('Bazaars & Craft'));
        await tester.pumpAndSettle();

        expect(
          find.text('Showing 9 Traditional Markets & 5 Craft Specialties'),
          findsOneWidget,
        );
        expect(find.byType(BazaarMarketCard), findsWidgets);
        expect(find.byType(CraftSpecialtyCard), findsWidgets);

        // Check markets
        expect(find.text('Gandhi Chowk'), findsOneWidget);
        expect(find.text('LBS MARKET VIJAYPURA'), findsOneWidget);
        expect(find.text('Smarnika'), findsOneWidget);
        expect(find.text('Location navigation coming soon'), findsWidgets);

        // Check crafts
        expect(
          find.text('Ilkal Sarees with Chikki Paras Border'),
          findsOneWidget,
        );
        expect(
          find.text('Lambani / Banjara Needle Embroidery'),
          findsOneWidget,
        );
        expect(find.text('Bidriware & Cast Metalware'), findsOneWidget);
      },
    );

    testWidgets(
      'Switching to Tourist Guides renders 7 verified guides with allowed fields',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1000, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MaterialApp(theme: AppTheme.light(), home: const DiscoverScreen()),
        );

        await tester.pumpAndSettle();

        // Tap Tourist Guides
        await tester.tap(find.text('Tourist Guides'));
        await tester.pumpAndSettle();

        expect(find.text('All 7 Registered Tourist Guides'), findsOneWidget);
        expect(find.byType(GuideCard), findsWidgets);
        expect(find.text('Ramesh Chauhan'), findsOneWidget);
        expect(find.text('+91 9844557378'), findsOneWidget);
        expect(find.text('Experience: 35+ Years'), findsOneWidget);
      },
    );

    testWidgets('Hotel Card opens Google Maps bottom sheet with copy action', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1000, 2000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(theme: AppTheme.light(), home: const DiscoverScreen()),
      );

      await tester.pumpAndSettle();

      final googleMapsButton = find.text('Google Maps').first;
      expect(googleMapsButton, findsOneWidget);

      await tester.tap(googleMapsButton);
      await tester.pumpAndSettle();
    });

    testWidgets(
      'Switching to Tanga Rides renders exactly 5 providers with allowed fields',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1200, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MaterialApp(theme: AppTheme.light(), home: const DiscoverScreen()),
        );

        await tester.pumpAndSettle();

        // Ensure chip is visible in horizontal scroll and tap it
        final tangaChip = find.text('Tanga Rides');
        await tester.ensureVisible(tangaChip);
        await tester.tap(tangaChip);
        await tester.pumpAndSettle();

        expect(
          find.text('All 5 Registered Tanga Ride Providers'),
          findsOneWidget,
        );
        expect(find.byType(TangaRideCard), findsNWidgets(5));
        expect(find.text('Rehmankhan Rasheedkhan Hakim'), findsOneWidget);
        expect(find.text('9731579908'), findsOneWidget);
        expect(find.text('Jameel Harunrasheed Jamadar'), findsOneWidget);
        expect(find.text('9611616785'), findsOneWidget);
        expect(find.text('Ravi'), findsOneWidget);
        expect(find.text('7760847640'), findsOneWidget);
        expect(find.text('Gujju Danga'), findsOneWidget);
        expect(find.text('9945940536'), findsOneWidget);
        expect(find.text('Mudakappa'), findsOneWidget);
        expect(find.text('9845479974'), findsOneWidget);
      },
    );

    testWidgets(
      'Hotel Card details modal shows official phone number and does NOT show owner or contact person private numbers',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1200, 2400);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MaterialApp(theme: AppTheme.light(), home: const DiscoverScreen()),
        );

        await tester.pumpAndSettle();

        // Hotel 1 (Spoorti) has contactPerson: 'Hotel Contact Number-\n GM-8850823196, Runwal owner -9448140055,'
        // and official phoneNumber: '63623 92876, 6362392877, 6362392878'
        final firstDetails = find.text('Details').first;
        expect(firstDetails, findsOneWidget);

        await tester.tap(firstDetails);
        await tester.pumpAndSettle();

        // Verify official phone number is present in public UI
        expect(
          find.text('Phone: 63623 92876, 6362392877, 6362392878'),
          findsOneWidget,
        );

        // Verify owner personal details and private phone numbers are NOT displayed in public UI
        expect(find.textContaining('Runwal'), findsNothing);
        expect(find.textContaining('9448140055'), findsNothing);
        expect(find.textContaining('8850823196'), findsNothing);
      },
    );
  });
}
