import '../../../../core/services/map_navigation_service.dart';
import '../../../explore/domain/models/place.dart';

enum VerificationStatus { verified, pendingVerification }

class PlanStop {
  final int stopOrder;
  final String placeId;
  final Place place;
  final String recommendedTimeSlot;
  final String stopNotes;
  final String? visitDuration;
  final RouteLegInfo? legFromPreviousStop;
  final String? navigationUrl;
  final bool isVerified;
  final String? verificationNotes;

  const PlanStop({
    required this.stopOrder,
    required this.placeId,
    required this.place,
    required this.recommendedTimeSlot,
    required this.stopNotes,
    this.visitDuration,
    this.legFromPreviousStop,
    this.navigationUrl,
    this.isVerified = true,
    this.verificationNotes,
  });

  String get formattedVisitDuration => visitDuration ?? 'Pending verification';
}

class PlanDay {
  final int dayNumber;
  final String dayTitle;
  final String? kannadaTitle;
  final String summary;
  final List<PlanStop> stops;

  const PlanDay({
    required this.dayNumber,
    required this.dayTitle,
    this.kannadaTitle,
    required this.summary,
    required this.stops,
  });
}

class TravelPlan {
  final String id;
  final String title;
  final String tagline;
  final String? kannadaTitle;
  final int durationDays;
  final String variant;
  final String variantLabel;
  final double? totalDistanceKm;
  final String? estimatedDuration;
  final String recommendedStartHour;
  final String routeReferenceAsset;
  final String? qrNavigationUrl;
  final List<PlanDay> days;
  final List<String> highlights;
  final bool isRouteVerified;

  const TravelPlan({
    required this.id,
    required this.title,
    required this.tagline,
    this.kannadaTitle,
    required this.durationDays,
    required this.variant,
    required this.variantLabel,
    this.totalDistanceKm,
    this.estimatedDuration,
    required this.recommendedStartHour,
    required this.routeReferenceAsset,
    this.qrNavigationUrl,
    required this.days,
    required this.highlights,
    this.isRouteVerified = true,
  });

  String get formattedTotalDistance => totalDistanceKm != null
      ? '${totalDistanceKm!.toStringAsFixed(1)} km'
      : 'Pending verification';

  String get formattedDuration =>
      estimatedDuration ??
      '$durationDays ${durationDays == 1 ? "Day" : "Days"}';

  int get totalStopsCount =>
      days.fold(0, (count, day) => count + day.stops.length);
}
