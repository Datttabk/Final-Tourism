import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vijayapura_tourism/features/explore/data/repositories/local_places_repository.dart';
import 'package:vijayapura_tourism/features/explore/presentation/screens/place_detail_screen.dart';

void main() {
  group('Vijayapura Tourism - Explore Destination Dataset Reconciliation', () {
    late LocalPlacesRepository repository;

    setUp(() {
      repository = LocalPlacesRepository();
    });

    test('Canonical repository contains 49 total destinations', () async {
      final places = await repository.getCuratedPlaces();
      expect(places.length, 49);
    });

    test('Preserves all 23 existing canonical destinations', () async {
      final places = await repository.getCuratedPlaces();
      final ids = places.map((p) => p.id).toSet();
      final requiredExistingIds = [
        'gol_gumbaz',
        'ibrahim_rauza',
        'bara_kaman',
        'basavana_bagewadi',
        'malik_e_maidan',
        'jama_masjid',
        'taj_bawdi',
        'shivgiri',
        'asar_mahal',
        'gagan_mahal',
        'jal_mahal',
        'narasimha_temple',
        'jod_gumbaz',
        'sangeet_mahal',
        'torvi_narasimha_temple',
        'upli_burj',
        'mehtar_mahal',
        'almatti_dam',
        'archaeological_museum',
        'navraspur_ainapur_mosque',
        'ainapur_tomb',
        'jahan_begum_tomb',
        'kumatagi',
      ];
      for (final id in requiredExistingIds) {
        expect(
          ids.contains(id),
          isTrue,
          reason: 'Missing existing destination: $id',
        );
      }
    });

    test('Shivagiri exists only once in the dataset (No Duplicates)', () async {
      final places = await repository.getCuratedPlaces();
      final shivagiriMatches = places.where(
        (p) =>
            p.id == 'shivgiri' ||
            p.name.toLowerCase().contains('shivagiri') ||
            p.name.toLowerCase().contains('shivgiri'),
      );
      expect(shivagiriMatches.length, 1);
    });

    test('Gol Gumbaz updated with exact source timings, fee, GPS and online booking URL', () async {
      final place = await repository.getPlaceById('gol_gumbaz');
      expect(place, isNotNull);
      expect(place!.openingTime, '06:00 AM');
      expect(place.closingTime, '05:40 PM');
      expect(place.ticketPriceInfo, contains('₹25'));
      expect(place.bookingUrl, 'https://asi.paygov.org.in');
      expect(place.coordinates.latitude, closeTo(16.830199, 0.0001));
      expect(place.coordinates.longitude, closeTo(75.735789, 0.0001));
      expect(place.mapsUrl, contains('16.83019944264078,75.73578986420485'));
    });

    test(
      'Ibrahim Rauza updated with exact source timings, fee and GPS',
      () async {
        final place = await repository.getPlaceById('ibrahim_rauza');
        expect(place, isNotNull);
        expect(place!.openingTime, '06:00 AM');
        expect(place.closingTime, '05:40 PM');
        expect(place.ticketPriceInfo, contains('₹20'));
        expect(place.coordinates.latitude, closeTo(16.827218, 0.0001));
        expect(place.coordinates.longitude, closeTo(75.702108, 0.0001));
        expect(place.mapsUrl, contains('16.827218927870497,75.70210842852073'));
      },
    );

    test('Chattaraki is the FIRST newly introduced destination after historical highlights', () async {
      final places = await repository.getCuratedPlaces();
      // Index 23 is the 24th place (right after the 23 preserved places)
      expect(places[23].id, 'shri_dattatreya_temple_chattaraki');
      expect(places[23].name, contains('Chattaraki'));
      expect(places[23].coordinates.latitude, closeTo(16.940651, 0.0001));
      expect(places[23].coordinates.longitude, closeTo(76.063489, 0.0001));
      expect(
        places[23].mapsUrl,
        contains('16.940651580018084,76.06348921930643'),
      );
    });

    test(
      'Saversangi destination handled via pending verification mechanism',
      () async {
        final place = await repository.getPlaceById('saversangi_destination');
        expect(place, isNotNull);
        expect(place!.name, 'Saversangi');
        expect(place.openingTime, 'Pending Verification');
        expect(place.ticketPriceInfo, 'Information Unavailable');
        expect(place.mapsUrl, isNull);
      },
    );

    test(
      'Search returns matches by name, village, town, taluka, and category',
      () async {
        expect(
          (await repository.searchPlaces('Chattaraki')).isNotEmpty,
          isTrue,
        );
        expect(
          (await repository.searchPlaces('Dattatreya')).isNotEmpty,
          isTrue,
        );
        expect((await repository.searchPlaces('Lakshmi')).isNotEmpty, isTrue);
        expect((await repository.searchPlaces('Kanamadi')).isNotEmpty, isTrue);
        expect(
          (await repository.searchPlaces('Amoghsiddeshwar')).isNotEmpty,
          isTrue,
        );
        expect((await repository.searchPlaces('Dyaberi')).isNotEmpty, isTrue);
        expect(
          (await repository.searchPlaces('Uppaladinni')).isNotEmpty,
          isTrue,
        );
        expect(
          (await repository.searchPlaces('Shegunashi')).isNotEmpty,
          isTrue,
        );
        expect(
          (await repository.searchPlaces('Hazimastan')).isNotEmpty,
          isTrue,
        );
        expect(
          (await repository.searchPlaces('Ingaleshwar')).isNotEmpty,
          isTrue,
        );
        expect((await repository.searchPlaces('Yalaguru')).isNotEmpty, isTrue);
        expect((await repository.searchPlaces('Tangadagi')).isNotEmpty, isTrue);
        expect((await repository.searchPlaces('Koluru')).isNotEmpty, isTrue);
        expect((await repository.searchPlaces('Horti')).isNotEmpty, isTrue);
        expect((await repository.searchPlaces('Hireroogi')).isNotEmpty, isTrue);
        expect((await repository.searchPlaces('Salotagi')).isNotEmpty, isTrue);
        expect((await repository.searchPlaces('Halasangi')).isNotEmpty, isTrue);
        expect((await repository.searchPlaces('Yankanchi')).isNotEmpty, isTrue);
        expect((await repository.searchPlaces('Kadlewad')).isNotEmpty, isTrue);
        expect((await repository.searchPlaces('Someshwar')).isNotEmpty, isTrue);
        expect((await repository.searchPlaces('Madival')).isNotEmpty, isTrue);
        expect(
          (await repository.searchPlaces('Devar Hipparagi')).isNotEmpty,
          isTrue,
        );
        expect((await repository.searchPlaces('Sariputra')).isNotEmpty, isTrue);
        expect(
          (await repository.searchPlaces('Katakanahalli')).isNotEmpty,
          isTrue,
        );
        expect((await repository.searchPlaces('Lachyan')).isNotEmpty, isTrue);
        expect((await repository.searchPlaces('Dulkhed')).isNotEmpty, isTrue);
        expect(
          (await repository.searchPlaces('Saversangi')).isNotEmpty,
          isTrue,
        );
        expect(
          (await repository.searchPlaces('Gol Gumbaz')).isNotEmpty,
          isTrue,
        );
      },
    );

    testWidgets(
      'PlaceDetailScreen displays Book Online button and details for Gol Gumbaz',
      (tester) async {
        final place = await repository.getPlaceById('gol_gumbaz');
        expect(place, isNotNull);

        await tester.pumpWidget(
          MaterialApp(home: PlaceDetailScreen(place: place!)),
        );
        await tester.pumpAndSettle();

        expect(find.text('Gol Gumbaz'), findsWidgets);
        expect(find.text('Book Online'), findsOneWidget);
        expect(find.text('Open in Maps'), findsOneWidget);
        expect(find.textContaining('₹25'), findsAtLeastNWidgets(1));
      },
    );

    testWidgets(
      'PlaceDetailScreen displays Tourist Footfall and location info for Chattaraki',
      (tester) async {
        final place = await repository.getPlaceById(
          'shri_dattatreya_temple_chattaraki',
        );
        expect(place, isNotNull);

        await tester.pumpWidget(
          MaterialApp(home: PlaceDetailScreen(place: place!)),
        );
        await tester.pumpAndSettle();

        expect(find.textContaining('Chattaraki'), findsWidgets);
        expect(find.text('Tourist Footfall'), findsOneWidget);
        expect(find.textContaining('25,000 to 50,000'), findsOneWidget);
        expect(find.text('Open in Maps'), findsOneWidget);
      },
    );

    testWidgets(
      'PlaceDetailScreen handles Saversangi pending verification gracefully',
      (tester) async {
        final place = await repository.getPlaceById('saversangi_destination');
        expect(place, isNotNull);

        await tester.pumpWidget(
          MaterialApp(home: PlaceDetailScreen(place: place!)),
        );
        await tester.pumpAndSettle();

        expect(find.text('Saversangi'), findsWidgets);
        expect(find.text('Pending Verification'), findsWidgets);
        expect(find.text('Information Unavailable'), findsWidgets);
      },
    );
  });
}
