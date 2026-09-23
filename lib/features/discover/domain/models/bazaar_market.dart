/// Domain entity representing a traditional commercial market or bazaar in Vijayapura.
///
/// Note: No coordinates or Google Maps URLs are supplied for these records;
/// [latitude], [longitude], and [mapsUrl] remain null.
class BazaarMarket {
  final String id;
  final String name;
  final String category;
  final String address;
  final String landmark;
  final String pincode;
  final double? latitude;
  final double? longitude;
  final String? mapsUrl;
  final String source;

  const BazaarMarket({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.landmark,
    required this.pincode,
    this.latitude,
    this.longitude,
    this.mapsUrl,
    this.source = 'Product owner supplied Vijayapura tourism dataset',
  });
}
