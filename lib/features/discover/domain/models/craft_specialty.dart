/// Domain entity representing a traditional craft, textile, or regional specialty in Vijayapura.
class CraftSpecialty {
  final String id;
  final String name;
  final String description;
  final String productionRetailClusters;
  final String source;

  const CraftSpecialty({
    required this.id,
    required this.name,
    required this.description,
    required this.productionRetailClusters,
    this.source = 'Product owner supplied Vijayapura tourism dataset',
  });
}
