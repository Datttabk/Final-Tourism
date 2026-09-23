import 'package:flutter_test/flutter_test.dart';
import 'package:vijayapura_tourism/features/discover/data/repositories/local_discover_repository.dart';

void main() {
  group('Accommodation Dataset (61 Records) Tests', () {
    late LocalDiscoverRepository repository;

    setUp(() {
      repository = LocalDiscoverRepository();
    });

    test('Loads exactly 61 master accommodation records', () async {
      final hotels = await repository.getHotels();
      expect(hotels.length, equals(61));
    });

    test('All 61 records have slNo 1 through 61 and unique canonical IDs hotel_1..hotel_61', () async {
      final hotels = await repository.getHotels();
      expect(hotels.length, equals(61));
      final ids = hotels.map((h) => h.id).toSet();
      expect(ids.length, equals(61), reason: 'Zero duplicate canonical IDs');
      for (int i = 0; i < 61; i++) {
        expect(hotels[i].id, equals('hotel_${i + 1}'));
        expect(hotels[i].slNo, equals(i + 1));
      }
    });

    test('All 61 accommodation names match supplied spreadsheet dataset', () async {
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
    });

    test(
      'Accommodation addresses do not contain latitude or longitude coordinates',
      () async {
        final hotels = await repository.getHotels();
        for (final hotel in hotels) {
          expect(hotel.address, isNot(contains(hotel.latitude.toString())));
          expect(hotel.address, isNot(contains(hotel.longitude.toString())));
          expect(hotel.latitude, isNot(0.0));
          expect(hotel.longitude, isNot(0.0));
        }
      },
    );

    test(
      'Non-URL Maps records preserve source text and have null mapsUrl',
      () async {
        final hotels = await repository.getHotels();
        final leGrande = hotels.firstWhere((h) => h.name.contains('Le Grande'));
        expect(leGrande.mapsUrl, isNull);
        expect(leGrande.mapsSourceValue, equals('Le Grande – Unpretentiously Luxurious'));

        final kyriad = hotels.firstWhere((h) => h.name == 'Hotel Kyriad');
        expect(kyriad.mapsUrl, isNull);
        expect(kyriad.mapsSourceValue, equals('kyriad hotel bijapur - Search (bing.com)'));

        final mayura = hotels.firstWhere((h) => h.name == 'Hotel Mayura Adil Shahi');
        expect(mayura.mapsUrl, isNull);
        expect(mayura.mapsSourceValue, equals('KSTDC - Official website of Karnataka State Tourism Development Corporation'));
      },
    );

    test('58 accommodations have valid launchable URLs', () async {
      final hotels = await repository.getHotels();
      final withMaps = hotels.where((h) => h.hasValidMapsUrl).toList();
      expect(withMaps.length, equals(58));
    });

    test('Accommodation search by name, address, taluka, and destination works', () async {
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
    });
  });
}
