enum DiscoverCategory {
  accommodation('Hotels & Stay', 'Hotels & Stay'),
  food('Local Cuisine', 'Local Cuisine'),
  bazaars('Bazaars & Craft', 'Bazaars & Craft'),
  guides('Tourist Guides', 'Tourist Guides'),
  tanga('Tanga Rides', 'Tanga Rides');

  final String title;
  final String shortName;
  const DiscoverCategory(this.title, this.shortName);
}

class DiscoverItem {
  final String id;
  final String title;
  final DiscoverCategory category;
  final String description;
  final String location;
  final String? priceRange;
  final double? rating;
  final int? featuredPriority; // Backend-controlled featured/display priority
  final String imageUrl;
  final String? operatingHours;
  final List<String> tags;

  const DiscoverItem({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.location,
    this.priceRange,
    this.rating,
    this.featuredPriority,
    required this.imageUrl,
    this.operatingHours,
    this.tags = const [],
  });
}
