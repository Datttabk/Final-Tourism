import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vijayapura_tourism/features/explore/data/repositories/local_places_repository.dart';
import 'package:vijayapura_tourism/features/explore/domain/models/place_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Explore Module Classified Images & Gallery Tests', () {
    late LocalPlacesRepository repository;

    setUp(() {
      repository = LocalPlacesRepository();
    });

    test('All local asset paths in LocalPlacesRepository exist on disk', () async {
      final places = await repository.getPlaces();
      expect(places, isNotEmpty);

      for (final place in places) {
        if (place.imageUrl.startsWith('assets/')) {
          final file = File(place.imageUrl);
          expect(
            file.existsSync(),
            isTrue,
            reason: 'Place ${place.id} primary imageUrl ${place.imageUrl} must exist on disk',
          );
        }

        for (final galleryUrl in place.galleryUrls) {
          if (galleryUrl.startsWith('assets/')) {
            final file = File(galleryUrl);
            expect(
              file.existsSync(),
              isTrue,
              reason: 'Place ${place.id} gallery image $galleryUrl must exist on disk',
            );
          }
        }
      }
    });

    test('Classified places have multiple local extra images populated in galleryUrls', () async {
      final multiImagePlaces = [
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
        'kumatagi',
        'mehtar_mahal',
        'almatti_dam',
        'archaeological_museum',
      ];

      for (final id in multiImagePlaces) {
        final place = await repository.getPlaceById(id);
        expect(place, isNotNull, reason: 'Place $id should exist');
        expect(
          place!.imageUrl.startsWith('assets/images/'),
          isTrue,
          reason: 'Place $id should use local classified asset, got ${place.imageUrl}',
        );
        expect(
          place.galleryUrls.length,
          greaterThanOrEqualTo(2),
          reason: 'Place $id should have multiple extra images in galleryUrls',
        );
        for (final gUrl in place.galleryUrls) {
          expect(
            gUrl.startsWith('assets/images/'),
            isTrue,
            reason: 'Place $id galleryUrl should be local classified asset, got $gUrl',
          );
        }
      }
    });

    test('New classified places (Mehtar Mahal, Almatti Dam, Museum) can be retrieved by ID', () async {
      final mehtar = await repository.getPlaceById('mehtar_mahal');
      expect(mehtar, isNotNull);
      expect(mehtar!.name, 'Mehtar Mahal');
      expect(mehtar.galleryUrls.length, 2);

      final almatti = await repository.getPlaceById('almatti_dam');
      expect(almatti, isNotNull);
      expect(almatti!.name, 'Almatti Dam');
      expect(almatti.galleryUrls.length, 8);

      final museum = await repository.getPlaceById('archaeological_museum');
      expect(museum, isNotNull);
      expect(museum!.name, 'Archaeological Museum');
      expect(museum.galleryUrls.length, 3);
    });

    test('Eight supplied tourist places have HowToReach, mapsUrl, and exact content', () async {
      final suppliedIds = [
        'gol_gumbaz',
        'ibrahim_rauza',
        'shivagiri',
        'bara_kamaan',
        'upli_buruz',
        'asar_mahal',
        'gagan_mahal',
        'almatti_dam',
      ];

      for (final id in suppliedIds) {
        final place = await repository.getPlaceById(id);
        expect(place, isNotNull, reason: 'Place $id should be retrievable');
        expect(place!.mapsUrl, isNotNull, reason: 'Place $id should have mapsUrl');
        expect(place.mapsUrl, contains('google.com/maps'));
        expect(place.howToReach, isNotNull, reason: 'Place $id should have howToReach');
        expect(place.howToReach!.byAir, isNotNull);
        expect(place.howToReach!.byTrain, isNotNull);
        expect(place.howToReach!.byRoad, isNotNull);
        expect(place.description, isNotEmpty);
      }

      // Verify Ibrahim Rauza specific visiting timings
      final ibrahim = await repository.getPlaceById('ibrahim_rauza');
      expect(ibrahim!.visitingTimings, 'Morning 6 AM IST to Evening 6 PM IST');

      // Verify aliases for backwards compatibility
      expect(await repository.getPlaceById('shivgiri'), isNotNull);
      expect(await repository.getPlaceById('bara_kaman'), isNotNull);
      expect(await repository.getPlaceById('upli_burj'), isNotNull);
    });

    test('PlaceLocalizations correctly localizes new places in English and Kannada', () async {
      final almatti = await repository.getPlaceById('almatti_dam');
      expect(almatti, isNotNull);

      final knPlace = almatti!.localized(const Locale('kn'));
      expect(knPlace.shortDescription, contains('ಆಣೆಕಟ್ಟು'));

      final enPlace = almatti.localized(const Locale('en'));
      expect(enPlace.shortDescription, contains('Krishna River'));
    });
  });
}
