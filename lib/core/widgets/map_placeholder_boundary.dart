import 'package:flutter/material.dart';

import '../services/map_navigation_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Clean boundary component for future Map provider integration.
/// Displays coordinates, route leg overview, and external navigation handoff.
class MapPlaceholderBoundary extends StatelessWidget {
  final String locationTitle;
  final GeoCoordinates coordinates;
  final String? distanceText;
  final String? travelTimeText;
  final VoidCallback? onNavigatePressed;
  final double height;

  const MapPlaceholderBoundary({
    super.key,
    required this.locationTitle,
    required this.coordinates,
    this.distanceText,
    this.travelTimeText,
    this.onNavigatePressed,
    this.height = 190,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background subtle grid/contour aesthetic
          Positioned.fill(child: CustomPaint(painter: _MapGridPainter())),

          // Central badge indicating integration boundary
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    '${coordinates.latitude.toStringAsFixed(4)}° N, ${coordinates.longitude.toStringAsFixed(4)}° E',
                    style: AppTextStyles.label.copyWith(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Top overlay info badges
          if (distanceText != null || travelTimeText != null)
            Positioned(
              top: 12,
              left: 12,
              child: Row(
                children: [
                  if (distanceText != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.straighten,
                            size: 13,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            distanceText!,
                            style: AppTextStyles.label.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  if (travelTimeText != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.schedule,
                            size: 13,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            travelTimeText!,
                            style: AppTextStyles.label.copyWith(fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

          // Bottom Action bar
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      locationTitle,
                      style: AppTextStyles.label.copyWith(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed:
                      onNavigatePressed ??
                      () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Directions to $locationTitle'),
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () {},
                            ),
                          ),
                        );
                      },
                  icon: const Icon(Icons.directions, size: 16),
                  label: const Text(
                    'Directions',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.35)
      ..strokeWidth = 1;

    const step = 32.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
