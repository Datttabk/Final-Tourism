/// Domain model representing a verified tourist guide in Vijayapura.
///
/// Contains strictly verified public fields:
/// - [name]
/// - [languagesSpoken]
/// - [experience]
/// - [contactNumber]
class TouristGuide {
  final String id;
  final String name;
  final List<String> languagesSpoken;
  final String experience;
  final String contactNumber;

  const TouristGuide({
    required this.id,
    required this.name,
    required this.languagesSpoken,
    required this.experience,
    required this.contactNumber,
  });

  /// Formatted comma-separated languages for search/display.
  String get formattedLanguages => languagesSpoken.join(', ');
}
