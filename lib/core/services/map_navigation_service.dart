/// Map and Navigation Service Abstraction.
///
/// Designed to decouple the UI from specific map providers (Google Maps, Mapbox, MapLibre, etc.)
/// until a provider is formally selected and approved.
library;

class GeoCoordinates {
  final double latitude;
  final double longitude;

  const GeoCoordinates({required this.latitude, required this.longitude});

  @override
  String toString() => '$latitude, $longitude';
}

class RouteLegInfo {
  final String originTitle;
  final GeoCoordinates originCoordinates;
  final String destinationTitle;
  final GeoCoordinates destinationCoordinates;
  final double? distanceKm;
  final int? estimatedDurationMinutes;
  final List<GeoCoordinates> polylineGeometry;
  final bool isVerified;

  const RouteLegInfo({
    required this.originTitle,
    required this.originCoordinates,
    required this.destinationTitle,
    required this.destinationCoordinates,
    this.distanceKm,
    this.estimatedDurationMinutes,
    this.polylineGeometry = const [],
    this.isVerified = false,
  });

  String get formattedDistance => distanceKm != null
      ? '${distanceKm!.toStringAsFixed(1)} km'
      : 'Pending verification';
  String get formattedDuration => estimatedDurationMinutes != null
      ? '$estimatedDurationMinutes mins'
      : 'Pending verification';
}

abstract interface class MapNavigationService {
  Future<RouteLegInfo> calculateRoute({
    required GeoCoordinates origin,
    required GeoCoordinates destination,
  });

  Future<void> launchExternalDirections({
    required GeoCoordinates destination,
    required String destinationName,
  });
}
