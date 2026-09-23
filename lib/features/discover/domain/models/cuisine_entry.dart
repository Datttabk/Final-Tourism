/// Domain entity representing a traditional regional dish or culinary experience in Vijayapura.
///
/// Note: These entries represent authentic culinary traditions and exploration hubs,
/// NOT individual restaurant listings.
class CuisineEntry {
  final String id;
  final String name;
  final String dishType;
  final String description;
  final String bestHubs;
  final String source;

  const CuisineEntry({
    required this.id,
    required this.name,
    required this.dishType,
    required this.description,
    required this.bestHubs,
    this.source = 'Product owner supplied Vijayapura tourism dataset',
  });
}
