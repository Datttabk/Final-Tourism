/// Domain model representing a verified Tanga Ride service provider in Vijayapura.
///
/// Contains strictly verified public fields:
/// - [nameEn] (English transliteration)
/// - [nameKn] (Kannada name)
/// - [contactNumber] (Official 10-digit mobile contact number)
class TangaRide {
  final String id;
  final String nameEn;
  final String nameKn;
  final String contactNumber;

  const TangaRide({
    required this.id,
    required this.nameEn,
    required this.nameKn,
    required this.contactNumber,
  });

  /// Returns the localized name based on language code ('kn' for Kannada, default English).
  String getLocalizedName(String languageCode) {
    if (languageCode == 'kn') {
      return nameKn;
    }
    return nameEn;
  }
}
