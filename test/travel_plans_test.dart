import 'package:flutter_test/flutter_test.dart';
import 'package:vijayapura_tourism/features/travel_plans/data/repositories/local_travel_plans_repository.dart';
import 'package:vijayapura_tourism/features/explore/data/repositories/local_places_repository.dart';

void main() {
  group('Travel Plans Repository & Domain Tests', () {
    late LocalTravelPlansRepository repository;
    late LocalPlacesRepository placesRepo;

    setUp(() {
      repository = LocalTravelPlansRepository();
      placesRepo = LocalPlacesRepository();
    });

    test('Loads exactly 4 distinct curated travel plans', () async {
      final plans = await repository.getPlans();
      expect(plans.length, 4);

      final ids = plans.map((p) => p.id).toList();
      expect(ids, [
        'plan_1_day',
        'plan_2_days_plan_1',
        'plan_2_days_plan_2',
        'plan_3_days',
      ]);
    });

    test('Both 2-Day plans are preserved and separate', () async {
      final plan1 = await repository.getPlanById('plan_2_days_plan_1');
      final plan2 = await repository.getPlanById('plan_2_days_plan_2');

      expect(plan1, isNotNull);
      expect(plan2, isNotNull);
      expect(plan1!.variant, '2_days_plan_1');
      expect(plan2!.variant, '2_days_plan_2');
      expect(plan1.variantLabel, '2 Days I');
      expect(plan2.variantLabel, '2 Days II');
      expect(plan1.totalStopsCount, 13);
      expect(plan2.totalStopsCount, 12);
    });

    test(
      '1-Day plan matches reference stop ordering and count (6 stops)',
      () async {
        final plan = await repository.getPlanById('plan_1_day');
        expect(plan, isNotNull);
        expect(plan!.durationDays, 1);
        expect(plan.days.length, 1);

        final stops = plan.days.first.stops;
        expect(stops.length, 6);

        final stopPlaceIds = stops.map((s) => s.place.id).toList();
        expect(stopPlaceIds, [
          'gol_gumbaz',
          'shivgiri',
          'jama_masjid',
          'asar_mahal',
          'bara_kaman',
          'ibrahim_rauza',
        ]);
      },
    );

    test(
      '2-Day Plan I matches reference stop ordering and day grouping',
      () async {
        final plan = await repository.getPlanById('plan_2_days_plan_1');
        expect(plan, isNotNull);
        expect(plan!.days.length, 2);

        // Day 1 (8 stops)
        final day1Stops = plan.days[0].stops.map((s) => s.place.id).toList();
        expect(day1Stops, [
          'gol_gumbaz',
          'shivgiri',
          'jama_masjid',
          'asar_mahal',
          'gagan_mahal',
          'bara_kaman',
          'jal_mahal',
          'narasimha_temple',
        ]);

        // Day 2 (5 stops)
        final day2Stops = plan.days[1].stops.map((s) => s.place.id).toList();
        expect(day2Stops, [
          'jod_gumbaz',
          'taj_bawdi',
          'ibrahim_rauza',
          'sangeet_mahal',
          'torvi_narasimha_temple',
        ]);
      },
    );

    test(
      '2-Day Plan II matches reference stop ordering and day grouping',
      () async {
        final plan = await repository.getPlanById('plan_2_days_plan_2');
        expect(plan, isNotNull);
        expect(plan!.days.length, 2);

        // Day 1 (7 stops)
        final day1Stops = plan.days[0].stops.map((s) => s.place.id).toList();
        expect(day1Stops, [
          'gol_gumbaz',
          'shivgiri',
          'jama_masjid',
          'asar_mahal',
          'gagan_mahal',
          'bara_kaman',
          'upli_burj',
        ]);

        // Day 2 (5 stops)
        final day2Stops = plan.days[1].stops.map((s) => s.place.id).toList();
        expect(day2Stops, [
          'malik_e_maidan',
          'taj_bawdi',
          'ibrahim_rauza',
          'sangeet_mahal',
          'torvi_narasimha_temple',
        ]);
      },
    );

    test(
      '3-Day plan matches reference stop ordering and day grouping (16 stops)',
      () async {
        final plan = await repository.getPlanById('plan_3_days');
        expect(plan, isNotNull);
        expect(plan!.days.length, 3);
        expect(plan.totalStopsCount, 16);

        // Day 1 (6 stops)
        final day1Stops = plan.days[0].stops.map((s) => s.place.id).toList();
        expect(day1Stops, [
          'gol_gumbaz',
          'shivgiri',
          'jama_masjid',
          'asar_mahal',
          'gagan_mahal',
          'bara_kaman',
        ]);

        // Day 2 (6 stops)
        final day2Stops = plan.days[1].stops.map((s) => s.place.id).toList();
        expect(day2Stops, [
          'upli_burj',
          'malik_e_maidan',
          'taj_bawdi',
          'ibrahim_rauza',
          'sangeet_mahal',
          'torvi_narasimha_temple',
        ]);

        // Day 3 (4 stops)
        final day3Stops = plan.days[2].stops.map((s) => s.place.id).toList();
        expect(day3Stops, [
          'navraspur_ainapur_mosque',
          'ainapur_tomb',
          'jahan_begum_tomb',
          'kumatagi',
        ]);

        // Kumatagi stop verified distance from reference
        final kumatagiStop = plan.days[2].stops.last;
        expect(kumatagiStop.legFromPreviousStop?.distanceKm, 18.0);
        expect(kumatagiStop.legFromPreviousStop?.isVerified, isTrue);
      },
    );

    test(
      'All QR navigation URLs are verified authentic Google Maps URLs',
      () async {
        final plans = await repository.getPlans();
        for (final plan in plans) {
          expect(plan.qrNavigationUrl, isNotNull);
          expect(
            plan.qrNavigationUrl!.startsWith('https://maps.app.goo.gl/'),
            isTrue,
          );
        }
      },
    );

    test('Canonical Place resolution: every stop matches canonical Place in LocalPlacesRepository', () async {
      final plans = await repository.getPlans();
      final allPlaces = await placesRepo.getPlaces();
      final canonicalPlaceMap = {for (final p in allPlaces) p.id: p};

      for (final plan in plans) {
        for (final day in plan.days) {
          for (final stop in day.stops) {
            if (stop.placeId == 'navraspur_ainapur_mosque') {
              // Navraspur Mosque was removed from canonical Explore repository per spec
              expect(stop.place.id, stop.placeId);
              expect(stop.place.name, isNotEmpty);
              expect(stop.place.coordinates.latitude, isNotNull);
              expect(stop.place.coordinates.longitude, isNotNull);
              continue;
            }
            expect(
              canonicalPlaceMap.containsKey(stop.placeId),
              isTrue,
              reason: 'Place ${stop.placeId} not found in canonical repository',
            );
            expect(stop.place.id, stop.placeId);
            expect(stop.place.name, isNotEmpty);
            expect(stop.place.coordinates.latitude, isNotNull);
            expect(stop.place.coordinates.longitude, isNotNull);
          }
        }
      }
    });
  });
}
