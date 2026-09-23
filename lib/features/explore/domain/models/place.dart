import '../../../../core/services/map_navigation_service.dart';

class HowToReach {
  final String? byAir;
  final String? byTrain;
  final String? byRoad;
  final String? byBus;

  const HowToReach({this.byAir, this.byTrain, this.byRoad, this.byBus});

  bool get isNotEmpty =>
      (byAir != null && byAir!.isNotEmpty) ||
      (byTrain != null && byTrain!.isNotEmpty) ||
      (byRoad != null && byRoad!.isNotEmpty) ||
      (byBus != null && byBus!.isNotEmpty);
}

class Place {
  final String id;
  final String name;
  final String category;
  final String shortDescription;
  final String historicalOverview;
  final String imageUrl;
  final List<String> galleryUrls;
  final String locationName;
  final GeoCoordinates coordinates;
  final String openingTime;
  final String closingTime;
  final String? gateClosingTime;
  final String ticketPriceInfo;
  final String suggestedDuration;
  final bool isBookmarked;
  final List<String> nearbyAttractionNames;
  final List<String> nearbyFoodRecommendations;
  final List<String> nearbyAccommodationRecommendations;
  final String? visitingTimings;
  final HowToReach? howToReach;
  final String? mapsUrl;
  final Map<String, String> imageCaptions;
  final String? bookingUrl;
  final String? touristFootfall;
  final String? village;
  final String? taluka;
  final String? district;

  String get description => historicalOverview;

  const Place({
    required this.id,
    required this.name,
    required this.category,
    required this.shortDescription,
    required this.historicalOverview,
    required this.imageUrl,
    required this.galleryUrls,
    required this.locationName,
    required this.coordinates,
    required this.openingTime,
    required this.closingTime,
    this.gateClosingTime,
    required this.ticketPriceInfo,
    required this.suggestedDuration,
    this.isBookmarked = false,
    this.nearbyAttractionNames = const [],
    this.nearbyFoodRecommendations = const [],
    this.nearbyAccommodationRecommendations = const [],
    this.visitingTimings,
    this.howToReach,
    this.mapsUrl,
    this.imageCaptions = const {},
    this.bookingUrl,
    this.touristFootfall,
    this.village,
    this.taluka,
    this.district,
  });

  Place copyWith({
    String? id,
    String? name,
    String? category,
    String? shortDescription,
    String? historicalOverview,
    String? imageUrl,
    List<String>? galleryUrls,
    String? locationName,
    GeoCoordinates? coordinates,
    String? openingTime,
    String? closingTime,
    String? gateClosingTime,
    String? ticketPriceInfo,
    String? suggestedDuration,
    bool? isBookmarked,
    List<String>? nearbyAttractionNames,
    List<String>? nearbyFoodRecommendations,
    List<String>? nearbyAccommodationRecommendations,
    String? visitingTimings,
    HowToReach? howToReach,
    String? mapsUrl,
    Map<String, String>? imageCaptions,
    String? bookingUrl,
    String? touristFootfall,
    String? village,
    String? taluka,
    String? district,
  }) {
    return Place(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      shortDescription: shortDescription ?? this.shortDescription,
      historicalOverview: historicalOverview ?? this.historicalOverview,
      imageUrl: imageUrl ?? this.imageUrl,
      galleryUrls: galleryUrls ?? this.galleryUrls,
      locationName: locationName ?? this.locationName,
      coordinates: coordinates ?? this.coordinates,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      gateClosingTime: gateClosingTime ?? this.gateClosingTime,
      ticketPriceInfo: ticketPriceInfo ?? this.ticketPriceInfo,
      suggestedDuration: suggestedDuration ?? this.suggestedDuration,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      nearbyAttractionNames:
          nearbyAttractionNames ?? this.nearbyAttractionNames,
      nearbyFoodRecommendations:
          nearbyFoodRecommendations ?? this.nearbyFoodRecommendations,
      nearbyAccommodationRecommendations:
          nearbyAccommodationRecommendations ??
          this.nearbyAccommodationRecommendations,
      visitingTimings: visitingTimings ?? this.visitingTimings,
      howToReach: howToReach ?? this.howToReach,
      mapsUrl: mapsUrl ?? this.mapsUrl,
      imageCaptions: imageCaptions ?? this.imageCaptions,
      bookingUrl: bookingUrl ?? this.bookingUrl,
      touristFootfall: touristFootfall ?? this.touristFootfall,
      village: village ?? this.village,
      taluka: taluka ?? this.taluka,
      district: district ?? this.district,
    );
  }
}
