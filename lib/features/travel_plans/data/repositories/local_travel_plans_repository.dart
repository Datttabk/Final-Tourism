import '../../../../core/services/map_navigation_service.dart';
import '../../../explore/data/repositories/local_places_repository.dart';
import '../../../explore/domain/models/place.dart';
import '../../domain/models/travel_plan.dart';
import '../../domain/repositories/travel_plans_repository.dart';

class LocalTravelPlansRepository implements TravelPlansRepository {
  final LocalPlacesRepository _placesRepo = LocalPlacesRepository();

  @override
  Future<List<TravelPlan>> getPlans() async {
    final places = await _placesRepo.getPlaces();
    final placeMap = <String, Place>{};
    for (final p in places) {
      placeMap[p.id] = p;
      if (p.id == 'shivgiri') placeMap['shivagiri'] = p;
      if (p.id == 'shivagiri') placeMap['shivgiri'] = p;
      if (p.id == 'bara_kaman') placeMap['bara_kamaan'] = p;
      if (p.id == 'bara_kamaan') placeMap['bara_kaman'] = p;
      if (p.id == 'upli_burj') placeMap['upli_buruz'] = p;
      if (p.id == 'upli_buruz') placeMap['upli_burj'] = p;
    }

    return [
      _buildOneDayPlan(placeMap),
      _buildTwoDayPlan1(placeMap),
      _buildTwoDayPlan2(placeMap),
      _buildThreeDayPlan(placeMap),
    ];
  }

  @override
  Future<TravelPlan?> getPlanById(String id) async {
    final plans = await getPlans();
    try {
      return plans.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  TravelPlan _buildOneDayPlan(Map<String, Place> p) {
    final golGumbaz = p['gol_gumbaz']!;
    final shivgiri = p['shivgiri']!;
    final jamaMasjid = p['jama_masjid']!;
    final asarMahal = p['asar_mahal']!;
    final baraKaman = p['bara_kaman']!;
    final ibrahimRauza = p['ibrahim_rauza']!;

    return TravelPlan(
      id: 'plan_1_day',
      title: 'One Day Trip to Vijayapur',
      tagline: 'Experience the signature monuments of the Adil Shahi sultanate in one focused journey.',
      kannadaTitle: 'ಒಂದು ದಿನದ ಪ್ರವಾಸ',
      durationDays: 1,
      variant: '1_day',
      variantLabel: '1 Day',
      recommendedStartHour: '08:30 AM',
      estimatedDuration: 'Full Day (~9-10 Hours)',
      routeReferenceAsset: 'assets/routes/one_day/one_day_trip_route.png',
      qrNavigationUrl: 'https://maps.app.goo.gl/ADttaJMz2fSZSbH96',
      highlights: [
        'World-renowned acoustic Whispering Gallery at Gol Gumbaz',
        'Towering 85-foot meditative Lord Shiva statue at Shivgiri',
        'Monumental 33-arched congregation prayer hall at Jama Masjid',
        'Lofty teakwood pillars and sacred relic hall at Asar Mahal',
        'Dramatic open-sky arches of Ali Adil Shah II at Bara Kaman',
        'Exquisite stone filigree & twin gardens at Ibrahim Rauza',
      ],
      days: [
        PlanDay(
          dayNumber: 1,
          dayTitle: 'Full Day Itinerary',
          kannadaTitle: 'ಒಂದು ದಿನದ ಪ್ರವಾಸ',
          summary: 'A complete circuit from the eastern dome to the western gardens of Ibrahim Rauza.',
          stops: [
            PlanStop(
              stopOrder: 1,
              placeId: golGumbaz.id,
              place: golGumbaz,
              recommendedTimeSlot: '08:30 AM – 10:45 AM',
              visitDuration: '1.5 – 2 Hours',
              stopNotes: 'Arrive early to witness acoustics in the Whispering Gallery before larger midday crowds.',
            ),
            PlanStop(
              stopOrder: 2,
              placeId: shivgiri.id,
              place: shivgiri,
              recommendedTimeSlot: '11:15 AM – 12:15 PM',
              visitDuration: '45 – 60 Minutes',
              stopNotes: 'View the 85-foot statue and explore the underground sculpture gallery.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: golGumbaz.name,
                originCoordinates: golGumbaz.coordinates,
                destinationTitle: shivgiri.name,
                destinationCoordinates: shivgiri.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 3,
              placeId: jamaMasjid.id,
              place: jamaMasjid,
              recommendedTimeSlot: '02:00 PM – 03:00 PM',
              visitDuration: '45 Minutes',
              stopNotes: 'Admire the 54,000-square-foot courtyard and the gilded Aurangzeb mihrab.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: shivgiri.name,
                originCoordinates: shivgiri.coordinates,
                destinationTitle: jamaMasjid.name,
                destinationCoordinates: jamaMasjid.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 4,
              placeId: asarMahal.id,
              place: asarMahal,
              recommendedTimeSlot: '03:15 PM – 04:00 PM',
              visitDuration: '30 – 45 Minutes',
              stopNotes: 'Observe the massive teakwood pillars and the large square front reflecting pool.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: jamaMasjid.name,
                originCoordinates: jamaMasjid.coordinates,
                destinationTitle: asarMahal.name,
                destinationCoordinates: asarMahal.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 5,
              placeId: baraKaman.id,
              place: baraKaman,
              recommendedTimeSlot: '04:15 PM – 05:00 PM',
              visitDuration: '45 Minutes',
              stopNotes: 'Golden-hour photography through the dramatic soaring unfinished arches.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: asarMahal.name,
                originCoordinates: asarMahal.coordinates,
                destinationTitle: baraKaman.name,
                destinationCoordinates: baraKaman.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 6,
              placeId: ibrahimRauza.id,
              place: ibrahimRauza,
              recommendedTimeSlot: '05:15 PM – 06:15 PM',
              visitDuration: '1 Hour',
              stopNotes: 'Sunset reflection across the serene walled gardens and stone minarets.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: baraKaman.name,
                originCoordinates: baraKaman.coordinates,
                destinationTitle: ibrahimRauza.name,
                destinationCoordinates: ibrahimRauza.coordinates,
                isVerified: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  TravelPlan _buildTwoDayPlan1(Map<String, Place> p) {
    final golGumbaz = p['gol_gumbaz']!;
    final shivgiri = p['shivgiri']!;
    final jamaMasjid = p['jama_masjid']!;
    final asarMahal = p['asar_mahal']!;
    final gaganMahal = p['gagan_mahal']!;
    final baraKaman = p['bara_kaman']!;
    final jalMahal = p['jal_mahal']!;
    final narasimhaTemple = p['narasimha_temple']!;

    final jodGumbaz = p['jod_gumbaz']!;
    final tajBawdi = p['taj_bawdi']!;
    final ibrahimRauza = p['ibrahim_rauza']!;
    final sangeetMahal = p['sangeet_mahal']!;
    final torviNarasimhaTemple = p['torvi_narasimha_temple']!;

    return TravelPlan(
      id: 'plan_2_days_plan_1',
      title: 'Two Days Trip to Vijayapur (Plan I)',
      tagline: 'Citadel palaces, subterranean shrines, royal stepwells, and Navraspur musical heritage.',
      kannadaTitle: 'ಎರಡು ದಿನಗಳ ಪ್ರವಾಸ (I)',
      durationDays: 2,
      variant: '2_days_plan_1',
      variantLabel: '2 Days I',
      recommendedStartHour: '09:00 AM',
      estimatedDuration: '2 Full Days',
      routeReferenceAsset:
          'assets/routes/two_day_plan_1/two_days_trip_plan_1_route.png',
      qrNavigationUrl: 'https://maps.app.goo.gl/C9cfuaJjkjesZTnS9',
      highlights: [
        'Deep exploration of the Citadel: Gagan Mahal, Jal Mahal & Narasimha Temple',
        'Acoustic wonders of Gol Gumbaz & serene gardens of Ibrahim Rauza',
        'Twin-domed mausoleum of Jod Gumbaz & 17th-century Taj Bawdi',
        'Music palace ruins at Navraspur & historical rock shrine of Torvi',
      ],
      days: [
        PlanDay(
          dayNumber: 1,
          dayTitle: 'Day 1: Imperial Monuments & Citadel Palaces',
          kannadaTitle: 'ಮೊದಲ ದಿನ',
          summary: 'From Gol Gumbaz and Shivgiri to the historic palaces and shrines within the citadel enclosure.',
          stops: [
            PlanStop(
              stopOrder: 1,
              placeId: golGumbaz.id,
              place: golGumbaz,
              recommendedTimeSlot: '09:00 AM – 11:15 AM',
              visitDuration: '1.5 – 2 Hours',
              stopNotes: 'Experience the Whispering Gallery and explore the archaeological museum.',
            ),
            PlanStop(
              stopOrder: 2,
              placeId: shivgiri.id,
              place: shivgiri,
              recommendedTimeSlot: '11:45 AM – 12:45 PM',
              visitDuration: '45 – 60 Minutes',
              stopNotes:
                  'Visit the 85-foot Shiva idol and the underground gallery.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: golGumbaz.name,
                originCoordinates: golGumbaz.coordinates,
                destinationTitle: shivgiri.name,
                destinationCoordinates: shivgiri.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 3,
              placeId: jamaMasjid.id,
              place: jamaMasjid,
              recommendedTimeSlot: '02:15 PM – 03:00 PM',
              visitDuration: '45 Minutes',
              stopNotes: 'Marvel at the expansive prayer hall and arches.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: shivgiri.name,
                originCoordinates: shivgiri.coordinates,
                destinationTitle: jamaMasjid.name,
                destinationCoordinates: jamaMasjid.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 4,
              placeId: asarMahal.id,
              place: asarMahal,
              recommendedTimeSlot: '03:15 PM – 03:50 PM',
              visitDuration: '30 – 45 Minutes',
              stopNotes: 'View the palace reflecting pool and historic wooden architecture.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: jamaMasjid.name,
                originCoordinates: jamaMasjid.coordinates,
                destinationTitle: asarMahal.name,
                destinationCoordinates: asarMahal.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 5,
              placeId: gaganMahal.id,
              place: gaganMahal,
              recommendedTimeSlot: '04:05 PM – 04:45 PM',
              visitDuration: '30 – 40 Minutes',
              stopNotes: 'Inspect the 61-foot central arch of the royal assembly palace.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: asarMahal.name,
                originCoordinates: asarMahal.coordinates,
                destinationTitle: gaganMahal.name,
                destinationCoordinates: gaganMahal.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 6,
              placeId: baraKaman.id,
              place: baraKaman,
              recommendedTimeSlot: '05:00 PM – 05:40 PM',
              visitDuration: '40 Minutes',
              stopNotes: 'Walk among the 12 unfinished arches framing the afternoon sky.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: gaganMahal.name,
                originCoordinates: gaganMahal.coordinates,
                destinationTitle: baraKaman.name,
                destinationCoordinates: baraKaman.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 7,
              placeId: jalMahal.id,
              place: jalMahal,
              recommendedTimeSlot: '05:55 PM – 06:30 PM',
              visitDuration: '30 Minutes',
              stopNotes: 'Ancient water pavilion reflecting Adil Shahi hydraulic design.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: baraKaman.name,
                originCoordinates: baraKaman.coordinates,
                destinationTitle: jalMahal.name,
                destinationCoordinates: jalMahal.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 8,
              placeId: narasimhaTemple.id,
              place: narasimhaTemple,
              recommendedTimeSlot: '06:40 PM – 07:15 PM',
              visitDuration: '30 Minutes',
              stopNotes: 'Subterranean stone temple preserved within the citadel perimeter.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: jalMahal.name,
                originCoordinates: jalMahal.coordinates,
                destinationTitle: narasimhaTemple.name,
                destinationCoordinates: narasimhaTemple.coordinates,
                isVerified: false,
              ),
            ),
          ],
        ),
        PlanDay(
          dayNumber: 2,
          dayTitle: 'Day 2: Twin Domes, Royal Stepwells & Navraspur',
          kannadaTitle: 'ಎರಡನೇ ದಿನ',
          summary: 'Venture west toward the twin tombs, the historic Taj Bawdi stepwell, and the royal cultural ruins of Navraspur.',
          stops: [
            PlanStop(
              stopOrder: 9,
              placeId: jodGumbaz.id,
              place: jodGumbaz,
              recommendedTimeSlot: '09:00 AM – 10:00 AM',
              visitDuration: '30 – 45 Minutes',
              stopNotes:
                  'Admire the elevated twin bulbous domes near Mecca Gate.',
            ),
            PlanStop(
              stopOrder: 10,
              placeId: tajBawdi.id,
              place: tajBawdi,
              recommendedTimeSlot: '10:15 AM – 11:15 AM',
              visitDuration: '45 Minutes',
              stopNotes: 'Historic 1620 royal water reservoir with monumental entrance arch.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: jodGumbaz.name,
                originCoordinates: jodGumbaz.coordinates,
                destinationTitle: tajBawdi.name,
                destinationCoordinates: tajBawdi.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 11,
              placeId: ibrahimRauza.id,
              place: ibrahimRauza,
              recommendedTimeSlot: '11:30 AM – 01:00 PM',
              visitDuration: '1 – 1.5 Hours',
              stopNotes: 'The Deccan Taj: intricate stone calligraphy, hanging chains, and mosque.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: tajBawdi.name,
                originCoordinates: tajBawdi.coordinates,
                destinationTitle: ibrahimRauza.name,
                destinationCoordinates: ibrahimRauza.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 12,
              placeId: sangeetMahal.id,
              place: sangeetMahal,
              recommendedTimeSlot: '03:00 PM – 04:30 PM',
              visitDuration: '45 – 60 Minutes',
              stopNotes: 'Ruins of the royal palace of music and literature in Navraspur.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: ibrahimRauza.name,
                originCoordinates: ibrahimRauza.coordinates,
                destinationTitle: sangeetMahal.name,
                destinationCoordinates: sangeetMahal.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 13,
              placeId: torviNarasimhaTemple.id,
              place: torviNarasimhaTemple,
              recommendedTimeSlot: '04:45 PM – 06:00 PM',
              visitDuration: '45 Minutes',
              stopNotes: 'Historic cave temple in Torvi where poet Kumara Valmiki composed Torave Ramayana.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: sangeetMahal.name,
                originCoordinates: sangeetMahal.coordinates,
                destinationTitle: torviNarasimhaTemple.name,
                destinationCoordinates: torviNarasimhaTemple.coordinates,
                isVerified: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  TravelPlan _buildTwoDayPlan2(Map<String, Place> p) {
    final golGumbaz = p['gol_gumbaz']!;
    final shivgiri = p['shivgiri']!;
    final jamaMasjid = p['jama_masjid']!;
    final asarMahal = p['asar_mahal']!;
    final gaganMahal = p['gagan_mahal']!;
    final baraKaman = p['bara_kaman']!;
    final upliBurj = p['upli_burj']!;

    final malikEMaidan = p['malik_e_maidan']!;
    final tajBawdi = p['taj_bawdi']!;
    final ibrahimRauza = p['ibrahim_rauza']!;
    final sangeetMahal = p['sangeet_mahal']!;
    final torviNarasimhaTemple = p['torvi_narasimha_temple']!;

    return TravelPlan(
      id: 'plan_2_days_plan_2',
      title: 'Two Days Trip to Vijayapur (Plan II)',
      tagline: 'Fortress watchtowers, medieval bronze cannons, royal bawdis, and suburban Navraspur.',
      kannadaTitle: 'ಎರಡು ದಿನಗಳ ಪ್ರವಾಸ (II)',
      durationDays: 2,
      variant: '2_days_plan_2',
      variantLabel: '2 Days II',
      recommendedStartHour: '09:00 AM',
      estimatedDuration: '2 Full Days',
      routeReferenceAsset:
          'assets/routes/two_day_plan_2/two_days_trip_plan_2_route.png',
      qrNavigationUrl: 'https://maps.app.goo.gl/EeVT2pufRrybWff68',
      highlights: [
        'Panoramic city lookout from the 80-foot stone watchtower of Upli Burj',
        'Legendary 55-ton bell-metal cannon Malik-e-Maidan on Sherza Burj',
        'The Whispering Gallery of Gol Gumbaz and royal court of Gagan Mahal',
        'Full cultural circuit to Sangeet Mahal and Torvi rock shrine',
      ],
      days: [
        PlanDay(
          dayNumber: 1,
          dayTitle: 'Day 1: Monolithic Marvels & High Bastions',
          kannadaTitle: 'ಮೊದಲ ದಿನ',
          summary: 'Eastern icons leading through the heart of the city up to the panoramic stone tower of Upli Burj.',
          stops: [
            PlanStop(
              stopOrder: 1,
              placeId: golGumbaz.id,
              place: golGumbaz,
              recommendedTimeSlot: '09:00 AM – 11:30 AM',
              visitDuration: '1.5 – 2 Hours',
              stopNotes:
                  'Explore the circular dome and acoustic whispering chamber.',
            ),
            PlanStop(
              stopOrder: 2,
              placeId: shivgiri.id,
              place: shivgiri,
              recommendedTimeSlot: '12:00 PM – 01:15 PM',
              visitDuration: '45 – 60 Minutes',
              stopNotes:
                  'View the monumental Shiva statue and underground galleries.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: golGumbaz.name,
                originCoordinates: golGumbaz.coordinates,
                destinationTitle: shivgiri.name,
                destinationCoordinates: shivgiri.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 3,
              placeId: jamaMasjid.id,
              place: jamaMasjid,
              recommendedTimeSlot: '02:45 PM – 03:30 PM',
              visitDuration: '45 Minutes',
              stopNotes: 'Walk the arcaded aisles and view the gilded sanctuary mihrab.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: shivgiri.name,
                originCoordinates: shivgiri.coordinates,
                destinationTitle: jamaMasjid.name,
                destinationCoordinates: jamaMasjid.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 4,
              placeId: asarMahal.id,
              place: asarMahal,
              recommendedTimeSlot: '03:45 PM – 04:30 PM',
              visitDuration: '30 – 45 Minutes',
              stopNotes: 'Historic relic hall and grand wooden structural architecture.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: jamaMasjid.name,
                originCoordinates: jamaMasjid.coordinates,
                destinationTitle: asarMahal.name,
                destinationCoordinates: asarMahal.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 5,
              placeId: gaganMahal.id,
              place: gaganMahal,
              recommendedTimeSlot: '04:45 PM – 05:15 PM',
              visitDuration: '30 Minutes',
              stopNotes:
                  'Colossal open-front assembly hall of Ali Adil Shah I.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: asarMahal.name,
                originCoordinates: asarMahal.coordinates,
                destinationTitle: gaganMahal.name,
                destinationCoordinates: gaganMahal.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 6,
              placeId: baraKaman.id,
              place: baraKaman,
              recommendedTimeSlot: '05:30 PM – 06:00 PM',
              visitDuration: '30 Minutes',
              stopNotes: 'Unfinished 12-arched royal mausoleum set against the twilight sky.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: gaganMahal.name,
                originCoordinates: gaganMahal.coordinates,
                destinationTitle: baraKaman.name,
                destinationCoordinates: baraKaman.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 7,
              placeId: upliBurj.id,
              place: upliBurj,
              recommendedTimeSlot: '06:15 PM – 06:50 PM',
              visitDuration: '35 Minutes',
              stopNotes: 'Climb the 80-foot spiral stone tower for panoramic sunset vistas.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: baraKaman.name,
                originCoordinates: baraKaman.coordinates,
                destinationTitle: upliBurj.name,
                destinationCoordinates: upliBurj.coordinates,
                isVerified: false,
              ),
            ),
          ],
        ),
        PlanDay(
          dayNumber: 2,
          dayTitle: 'Day 2: Artillery, Royal Stepped Bawdis & Navraspur',
          kannadaTitle: 'ಎರಡನೇ ದಿನ',
          summary: 'Investigate military artillery, hydraulic marvels, and the royal musical center of Navraspur.',
          stops: [
            PlanStop(
              stopOrder: 8,
              placeId: malikEMaidan.id,
              place: malikEMaidan,
              recommendedTimeSlot: '09:30 AM – 10:30 AM',
              visitDuration: '45 Minutes',
              stopNotes: 'Examine the colossal 55-ton lion-mouthed cannon on Sherza Burj.',
            ),
            PlanStop(
              stopOrder: 9,
              placeId: tajBawdi.id,
              place: tajBawdi,
              recommendedTimeSlot: '10:45 AM – 11:45 AM',
              visitDuration: '45 Minutes',
              stopNotes: 'Centuries-old stepped reservoir and octagonal observation towers.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: malikEMaidan.name,
                originCoordinates: malikEMaidan.coordinates,
                destinationTitle: tajBawdi.name,
                destinationCoordinates: tajBawdi.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 10,
              placeId: ibrahimRauza.id,
              place: ibrahimRauza,
              recommendedTimeSlot: '12:00 PM – 01:30 PM',
              visitDuration: '1 – 1.5 Hours',
              stopNotes: 'Masterwork tomb and mosque with hanging stone chains and calligraphy.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: tajBawdi.name,
                originCoordinates: tajBawdi.coordinates,
                destinationTitle: ibrahimRauza.name,
                destinationCoordinates: ibrahimRauza.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 11,
              placeId: sangeetMahal.id,
              place: sangeetMahal,
              recommendedTimeSlot: '03:30 PM – 05:00 PM',
              visitDuration: '1 Hour',
              stopNotes: 'Palace of music and arts ruins in the planned twin capital Navraspur.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: ibrahimRauza.name,
                originCoordinates: ibrahimRauza.coordinates,
                destinationTitle: sangeetMahal.name,
                destinationCoordinates: sangeetMahal.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 12,
              placeId: torviNarasimhaTemple.id,
              place: torviNarasimhaTemple,
              recommendedTimeSlot: '05:15 PM – 06:30 PM',
              visitDuration: '45 Minutes',
              stopNotes:
                  'Sanctum of poet Kumara Valmiki and sacred rock shrine.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: sangeetMahal.name,
                originCoordinates: sangeetMahal.coordinates,
                destinationTitle: torviNarasimhaTemple.name,
                destinationCoordinates: torviNarasimhaTemple.coordinates,
                isVerified: false,
              ),
            ),
          ],
        ),
      ],
    );
  }

  TravelPlan _buildThreeDayPlan(Map<String, Place> p) {
    final golGumbaz = p['gol_gumbaz']!;
    final shivgiri = p['shivgiri']!;
    final jamaMasjid = p['jama_masjid']!;
    final asarMahal = p['asar_mahal']!;
    final gaganMahal = p['gagan_mahal']!;
    final baraKaman = p['bara_kaman']!;

    final upliBurj = p['upli_burj']!;
    final malikEMaidan = p['malik_e_maidan']!;
    final tajBawdi = p['taj_bawdi']!;
    final ibrahimRauza = p['ibrahim_rauza']!;
    final sangeetMahal = p['sangeet_mahal']!;
    final torviNarasimhaTemple = p['torvi_narasimha_temple']!;

    final navraspurMosque = p['navraspur_ainapur_mosque']!;
    final ainapurTomb = p['ainapur_tomb']!;
    final jahanBegumTomb = p['jahan_begum_tomb']!;
    final kumatagi = p['kumatagi']!;

    return TravelPlan(
      id: 'plan_3_days',
      title: 'Three Days Trip to Vijayapur',
      tagline: 'The definitive cultural expedition: Citadel, cannons, Navraspur, and the royal summer lake resort of Kumatagi.',
      kannadaTitle: 'ಮೂರು ದಿನಗಳ ಪ್ರವಾಸ',
      durationDays: 3,
      variant: '3_days',
      variantLabel: '3 Days',
      recommendedStartHour: '09:00 AM',
      estimatedDuration: '3 Full Days',
      routeReferenceAsset: 'assets/routes/three_day/three_days_trip_route.png',
      qrNavigationUrl: 'https://maps.app.goo.gl/jeHeo2p4YnJQ7jQZ6',
      highlights: [
        'Complete chronological journey through Adil Shahi royal architecture',
        'Eastern icons, citadel palaces, and towering fortification bastions',
        'Western arts capital at Navraspur & sacred subterranean cave shrine',
        'Outlying royal pleasure resort at Kumatagi (18 km) with surviving 17th-century frescoes',
      ],
      days: [
        PlanDay(
          dayNumber: 1,
          dayTitle: 'Day 1: Imperial Core & Palace Citadel',
          kannadaTitle: 'ಮೊದಲ ದಿನ',
          summary: 'Gol Gumbaz, Shivgiri, sacred mosques, and the historic citadel assembly halls.',
          stops: [
            PlanStop(
              stopOrder: 1,
              placeId: golGumbaz.id,
              place: golGumbaz,
              recommendedTimeSlot: '09:00 AM – 11:30 AM',
              visitDuration: '1.5 – 2 Hours',
              stopNotes: 'Extensive study of the acoustic whispering dome and gardens.',
            ),
            PlanStop(
              stopOrder: 2,
              placeId: shivgiri.id,
              place: shivgiri,
              recommendedTimeSlot: '12:00 PM – 01:15 PM',
              visitDuration: '45 – 60 Minutes',
              stopNotes: 'Colossal 85-foot statue and underground gallery.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: golGumbaz.name,
                originCoordinates: golGumbaz.coordinates,
                destinationTitle: shivgiri.name,
                destinationCoordinates: shivgiri.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 3,
              placeId: jamaMasjid.id,
              place: jamaMasjid,
              recommendedTimeSlot: '02:45 PM – 03:30 PM',
              visitDuration: '45 Minutes',
              stopNotes:
                  'Deccan congregational prayer hall with gilded inscriptions.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: shivgiri.name,
                originCoordinates: shivgiri.coordinates,
                destinationTitle: jamaMasjid.name,
                destinationCoordinates: jamaMasjid.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 4,
              placeId: asarMahal.id,
              place: asarMahal,
              recommendedTimeSlot: '03:45 PM – 04:30 PM',
              visitDuration: '30 – 45 Minutes',
              stopNotes: 'Relic palace with wooden pillars and sunken pool reflecting hall.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: jamaMasjid.name,
                originCoordinates: jamaMasjid.coordinates,
                destinationTitle: asarMahal.name,
                destinationCoordinates: asarMahal.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 5,
              placeId: gaganMahal.id,
              place: gaganMahal,
              recommendedTimeSlot: '04:45 PM – 05:30 PM',
              visitDuration: '30 – 45 Minutes',
              stopNotes: 'Grand 61-foot assembly arch overlooking the citadel grounds.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: asarMahal.name,
                originCoordinates: asarMahal.coordinates,
                destinationTitle: gaganMahal.name,
                destinationCoordinates: gaganMahal.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 6,
              placeId: baraKaman.id,
              place: baraKaman,
              recommendedTimeSlot: '05:45 PM – 06:30 PM',
              visitDuration: '45 Minutes',
              stopNotes: 'Photograph the soaring concentric arches against the evening sky.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: gaganMahal.name,
                originCoordinates: gaganMahal.coordinates,
                destinationTitle: baraKaman.name,
                destinationCoordinates: baraKaman.coordinates,
                isVerified: false,
              ),
            ),
          ],
        ),
        PlanDay(
          dayNumber: 2,
          dayTitle: 'Day 2: Fortifications, Cannonry & Navraspur Arts',
          kannadaTitle: 'ಎರಡನೇ ದಿನ',
          summary: 'Bastions, artillery, stepped bawdis, Ibrahim Rauza, and the cultural ruins of Navraspur.',
          stops: [
            PlanStop(
              stopOrder: 7,
              placeId: upliBurj.id,
              place: upliBurj,
              recommendedTimeSlot: '09:00 AM – 10:00 AM',
              visitDuration: '45 Minutes',
              stopNotes:
                  'Climb the 80-foot bastion for sweeping morning views.',
            ),
            PlanStop(
              stopOrder: 8,
              placeId: malikEMaidan.id,
              place: malikEMaidan,
              recommendedTimeSlot: '10:15 AM – 11:15 AM',
              visitDuration: '45 Minutes',
              stopNotes: '55-tonne medieval bronze cannon on Lion Bastion.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: upliBurj.name,
                originCoordinates: upliBurj.coordinates,
                destinationTitle: malikEMaidan.name,
                destinationCoordinates: malikEMaidan.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 9,
              placeId: tajBawdi.id,
              place: tajBawdi,
              recommendedTimeSlot: '11:30 AM – 12:30 PM',
              visitDuration: '45 Minutes',
              stopNotes: 'Monumental stepped well built in 1620 for Queen Taj Sultana.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: malikEMaidan.name,
                originCoordinates: malikEMaidan.coordinates,
                destinationTitle: tajBawdi.name,
                destinationCoordinates: tajBawdi.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 10,
              placeId: ibrahimRauza.id,
              place: ibrahimRauza,
              recommendedTimeSlot: '02:00 PM – 03:30 PM',
              visitDuration: '1.5 Hours',
              stopNotes: 'Intricate stone calligraphy and symmetric gardens of the Deccan Taj.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: tajBawdi.name,
                originCoordinates: tajBawdi.coordinates,
                destinationTitle: ibrahimRauza.name,
                destinationCoordinates: ibrahimRauza.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 11,
              placeId: sangeetMahal.id,
              place: sangeetMahal,
              recommendedTimeSlot: '03:45 PM – 05:00 PM',
              visitDuration: '1 Hour',
              stopNotes:
                  'Navraspur palace dedicated to music and performing arts.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: ibrahimRauza.name,
                originCoordinates: ibrahimRauza.coordinates,
                destinationTitle: sangeetMahal.name,
                destinationCoordinates: sangeetMahal.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 12,
              placeId: torviNarasimhaTemple.id,
              place: torviNarasimhaTemple,
              recommendedTimeSlot: '05:15 PM – 06:30 PM',
              visitDuration: '45 Minutes',
              stopNotes: 'Cave shrine of poet Kumara Valmiki and ancient subterranean sanctum.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: sangeetMahal.name,
                originCoordinates: sangeetMahal.coordinates,
                destinationTitle: torviNarasimhaTemple.name,
                destinationCoordinates: torviNarasimhaTemple.coordinates,
                isVerified: false,
              ),
            ),
          ],
        ),
        PlanDay(
          dayNumber: 3,
          dayTitle: 'Day 3: Ainapur Tombs & Kumatagi Summer Lake Resort',
          kannadaTitle: 'ಮೂರನೇ ದಿನ',
          summary: 'Eastern monuments of Ainapur and a pleasant excursion to the Adil Shahi lakeside pleasure pavilions of Kumatagi (18 km).',
          stops: [
            PlanStop(
              stopOrder: 13,
              placeId: navraspurMosque.id,
              place: navraspurMosque,
              recommendedTimeSlot: '09:00 AM – 10:00 AM',
              visitDuration: '30 – 45 Minutes',
              stopNotes:
                  'Historic stone mosque in the Ainapur/Navraspur corridor.',
            ),
            PlanStop(
              stopOrder: 14,
              placeId: ainapurTomb.id,
              place: ainapurTomb,
              recommendedTimeSlot: '10:15 AM – 11:15 AM',
              visitDuration: '45 Minutes',
              stopNotes: 'Substantial domed mausoleum complex of nobleman Ain-ul-Mulk.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: navraspurMosque.name,
                originCoordinates: navraspurMosque.coordinates,
                destinationTitle: ainapurTomb.name,
                destinationCoordinates: ainapurTomb.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 15,
              placeId: jahanBegumTomb.id,
              place: jahanBegumTomb,
              recommendedTimeSlot: '11:30 AM – 12:30 PM',
              visitDuration: '30 – 45 Minutes',
              stopNotes: 'Unfinished monumental tomb of Mohammed Adil Shah’s consort Jahan Begum.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: ainapurTomb.name,
                originCoordinates: ainapurTomb.coordinates,
                destinationTitle: jahanBegumTomb.name,
                destinationCoordinates: jahanBegumTomb.coordinates,
                isVerified: false,
              ),
            ),
            PlanStop(
              stopOrder: 16,
              placeId: kumatagi.id,
              place: kumatagi,
              recommendedTimeSlot: '02:30 PM – 05:30 PM',
              visitDuration: '1.5 – 2 Hours',
              stopNotes: 'Lakeside summer resort (18 km east) with water pavilions, aqueduct siphon system, and Mughal/Persian wall murals.',
              legFromPreviousStop: RouteLegInfo(
                originTitle: jahanBegumTomb.name,
                originCoordinates: jahanBegumTomb.coordinates,
                destinationTitle: kumatagi.name,
                destinationCoordinates: kumatagi.coordinates,
                distanceKm: 18.0,
                isVerified: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
