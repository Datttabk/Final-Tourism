/// Domain model representing an accommodation/hotel in Vijayapura.
///
/// Follows strict location and content preservation rules:
/// - Coordinates ([latitude], [longitude]) represent internal backend data and must NEVER be concatenated into [address].
/// - [address] holds the complete authoritative address from the district spreadsheet.
/// - [mapsSourceValue] preserves the exact value from the spreadsheet (URL or raw text).
/// - [mapsUrl] holds the launchable URL if the source value is an HTTP/HTTPS link.
class Hotel {
  final String id;
  final int? slNo;
  final String name;
  final String type;
  final String address;
  final String taluka;
  final String district;
  final String mapsSourceValue;
  final String? mapsUrl;
  final String numberOfGuestRooms;
  final String amenities;
  final String contactPerson;
  final String phoneNumber;
  final String email;
  final String nearestTouristDestination;
  final double latitude;
  final double longitude;
  final bool isApproximateLocation;
  final int? featuredPriority;
  final List<String> images;

  const Hotel({
    required this.id,
    this.slNo,
    required this.name,
    required this.address,
    this.type = 'Hotel',
    this.taluka = 'Vijayapur',
    this.district = 'Vijayapur',
    this.mapsSourceValue = '',
    this.mapsUrl,
    this.numberOfGuestRooms = '',
    this.amenities = '',
    this.contactPerson = '',
    this.phoneNumber = '',
    this.email = '',
    this.nearestTouristDestination = '',
    this.latitude = 16.8302,
    this.longitude = 75.7100,
    this.isApproximateLocation = false,
    this.featuredPriority,
    this.images = const [],
  });

  /// Formatted coordinates representation for navigation/routing services only.
  String get coordinatesString => '$latitude, $longitude';

  /// Whether this accommodation has a valid, launchable Google Maps URL.
  bool get hasValidMapsUrl =>
      mapsUrl != null &&
      (mapsUrl!.startsWith('http://') || mapsUrl!.startsWith('https://'));

  /// Whether contact phone numbers are available.
  bool get hasPhoneNumber =>
      phoneNumber.isNotEmpty &&
      phoneNumber.trim() != '-' &&
      phoneNumber.trim() != 'Nil';

  /// Whether email is available.
  bool get hasEmail =>
      email.isNotEmpty && email.trim() != '-' && email.trim() != 'Nil';
}
