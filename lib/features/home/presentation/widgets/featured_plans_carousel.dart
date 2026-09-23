import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class FeaturedPlanSummary {
  final int planIndex;
  final String title;
  final String days;
  final String stopsCount;
  final String distance;
  final String description;

  const FeaturedPlanSummary({
    required this.planIndex,
    required this.title,
    required this.days,
    required this.stopsCount,
    required this.distance,
    required this.description,
  });
}

class FeaturedPlansCarousel extends StatelessWidget {
  final ValueChanged<int> onPlanSelected;

  const FeaturedPlansCarousel({super.key, required this.onPlanSelected});

  static const List<FeaturedPlanSummary> plans = [
    FeaturedPlanSummary(
      planIndex: 0,
      title: '1-Day Heritage Essentials',
      days: '1 Day',
      stopsCount: '4 Stops',
      distance: '7.2 km',
      description: 'Gol Gumbaz, Bara Kaman, Ibrahim Rauza, Taj Bawdi',
    ),
    FeaturedPlanSummary(
      planIndex: 1,
      title: '2-Day Adil Shahi Tour',
      days: '2 Days',
      stopsCount: '6 Stops',
      distance: '12.8 km',
      description: 'Imperial tombs, Jama Masjid, citadel bastions & cannons',
    ),
    FeaturedPlanSummary(
      planIndex: 2,
      title: '3-Day Complete Expedition',
      days: '3 Days',
      stopsCount: '6 Stops',
      distance: '18.5 km',
      description:
          'All monuments, ancient stepwells, local cuisine & handloom bazaars',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: plans.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final plan = plans[index];
          return InkWell(
            onTap: () => onPlanSelected(plan.planIndex),
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: 260,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          plan.days,
                          style: AppTextStyles.label.copyWith(
                            fontSize: 11,
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•  ${plan.stopsCount}',
                        style: AppTextStyles.bodySecondary.copyWith(
                          fontSize: 11,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        plan.distance,
                        style: AppTextStyles.label.copyWith(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    plan.title,
                    style: AppTextStyles.title.copyWith(fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    plan.description,
                    style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: const [
                      Text(
                        'View Route Itinerary',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        size: 13,
                        color: AppColors.primaryDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
