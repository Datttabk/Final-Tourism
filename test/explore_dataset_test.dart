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

    test('Canonical repository contains 48 total destinations', () async {
      final places = await repository.getCuratedPlaces();
      expect(places.length, 48);
    });

    test('Preserves all 22 existing canonical destinations and removes Navraspur Mosque', () async {
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
      expect(
        ids.contains('navraspur_ainapur_mosque'),
        isFalse,
        reason: 'Navraspur / Ainapur Mosque must be completely removed from Explore',
      );
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
      expect(
        place.mapsUrl,
        'https://maps.google.com/?cid=15664829629228524966&utm_source=gemini&authuser=1',
      );
    });

    test('Ibrahim Rauza updated with exact source timings, fee, GPS and supplied Google Maps link', () async {
      final place = await repository.getPlaceById('ibrahim_rauza');
      expect(place, isNotNull);
      expect(place!.openingTime, '06:00 AM');
      expect(place.closingTime, '05:40 PM');
      expect(place.ticketPriceInfo, contains('₹20'));
      expect(place.bookingUrl, 'https://asi.paygov.org.in');
      expect(place.coordinates.latitude, closeTo(16.827218, 0.0001));
      expect(place.coordinates.longitude, closeTo(75.702108, 0.0001));
      expect(
        place.mapsUrl,
        'https://maps.google.com/?cid=765027159616443248&utm_source=gemini&authuser=1',
      );
    });

    test('Chattaraki is the FIRST newly introduced destination after historical highlights', () async {
      final places = await repository.getCuratedPlaces();
      // Index 22 is the 23rd place (right after the 22 preserved historical places)
      expect(places[22].id, 'shri_dattatreya_temple_chattaraki');
      expect(places[22].name, contains('Chattaraki'));
      expect(places[22].coordinates.latitude, closeTo(16.940651, 0.0001));
      expect(places[22].coordinates.longitude, closeTo(76.063489, 0.0001));
      expect(
        places[22].mapsUrl,
        'https://maps.google.com/?cid=14984040426479515462&utm_source=gemini&authuser=1',
      );
    });

    test('Savalasanga (Saversangi) updated with exact name, local image, and verified Google Maps link', () async {
      final place = await repository.getPlaceById('saversangi_destination');
      expect(place, isNotNull);
      expect(
        place!.name,
        'Jnyanayogi Shree Siddeshwar Swamiji Tree Park Savalasanga',
      );
      expect(
        place.imageUrl,
        'assets/images/explore/siddeshwar_tree_park_savalasanga.png',
      );
      expect(place.mapsUrl, 'https://maps.app.goo.gl/EearL3ax9KfCQuxc6');
    });

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
        final navraspurMatches = await repository.searchPlaces('Navraspur');
        expect(
          navraspurMatches.any((p) => p.id == 'navraspur_ainapur_mosque'),
          isFalse,
          reason:
              'Navraspur / Ainapur Mosque must not appear in search results',
        );
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
      'PlaceDetailScreen does NOT display Tourist Footfall in Explore UI',
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
        expect(find.text('Tourist Footfall'), findsNothing);
        expect(find.text('Open in Maps'), findsOneWidget);
      },
    );

    testWidgets(
      'PlaceDetailScreen displays updated name and details for Savalasanga',
      (tester) async {
        final place = await repository.getPlaceById('saversangi_destination');
        expect(place, isNotNull);

        await tester.pumpWidget(
          MaterialApp(home: PlaceDetailScreen(place: place!)),
        );
        await tester.pumpAndSettle();

        expect(
          find.text(
            'Jnyanayogi Shree Siddeshwar Swamiji Tree Park Savalasanga',
          ),
          findsWidgets,
        );
        expect(find.text('Open in Maps'), findsOneWidget);
      },
    );

    test('All 15 coordinate-only destinations now have verified destination place links', () async {
      final baraKaman = await repository.getPlaceById('bara_kaman');
      expect(
        baraKaman!.mapsUrl,
        contains('place_id:ChIJw7ZYPX9VxjsRFkxnoKxJgrg'),
      );

      final malik = await repository.getPlaceById('malik_e_maidan');
      expect(malik!.mapsUrl, contains('place_id:ChIJc6Xr4oH_xjsRX1lbdWb_-Rw'));

      final jama = await repository.getPlaceById('jama_masjid');
      expect(jama!.mapsUrl, contains('place_id:ChIJ1fq10HFVxjsR_hnpELBdgAw'));

      final taj = await repository.getPlaceById('taj_bawdi');
      expect(taj!.mapsUrl, contains('place_id:ChIJ3SZ87Yb_xjsRGSNZknjCaGc'));

      final asar = await repository.getPlaceById('asar_mahal');
      expect(asar!.mapsUrl, contains('place_id:ChIJtYi0zHtVxjsROAN8Goqqd8o'));

      final gagan = await repository.getPlaceById('gagan_mahal');
      expect(gagan!.mapsUrl, contains('place_id:ChIJEWTaIXxVxjsReMUX8ZX3IYA'));

      final jal = await repository.getPlaceById('jal_mahal');
      expect(jal!.mapsUrl, contains('place_id:ChIJh705OnxVxjsR28cyP3dvW4E'));

      final narasimha = await repository.getPlaceById('narasimha_temple');
      expect(
        narasimha!.mapsUrl,
        contains('place_id:ChIJZ88kt4H_xjsRBvP5K8l0Juc'),
      );
      expect(narasimha.imageUrl, 'assets/images/explore/narasimha_temple.png');

      final jod = await repository.getPlaceById('jod_gumbaz');
      expect(jod!.mapsUrl, contains('place_id:ChIJTWzfPof_xjsRoHLGyNDAqEE'));
      expect(jod.imageUrl, 'assets/images/explore/jod_gumbaz.png');

      final upli = await repository.getPlaceById('upli_burj');
      expect(upli!.mapsUrl, contains('place_id:ChIJr--Xj3__xjsRoJgLu5WR9pw'));

      final mehtar = await repository.getPlaceById('mehtar_mahal');
      expect(mehtar!.mapsUrl, contains('place_id:ChIJyaMZGXtVxjsRhq01fpXVdnM'));

      final museum = await repository.getPlaceById('archaeological_museum');
      expect(museum!.mapsUrl, contains('place_id:ChIJtwDZvHRVxjsR5LmwCkZlSXk'));

      final navraspur = await repository.getPlaceById(
        'navraspur_ainapur_mosque',
      );
      expect(navraspur, isNull);

      final ainapur = await repository.getPlaceById('ainapur_tomb');
      expect(
        ainapur!.mapsUrl,
        contains('place_id:ChIJr5PYWRFVxjsRP6nj9JTnnyw'),
      );
      expect(ainapur.imageUrl, equals('assets/images/explore/ainapur_tomb.png'));

      final jahan = await repository.getPlaceById('jahan_begum_tomb');
      expect(jahan!.mapsUrl, contains('place_id:ChIJk6jIqvFUxjsREtR2c0XyzaQ'));
      expect(jahan.imageUrl, equals('assets/images/explore/jahan_begum_tomb.png'));
    });
  });
}
