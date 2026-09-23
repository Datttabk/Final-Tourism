import 'package:flutter/material.dart';

import '../../../../core/localization/l10n_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Compact preview section for Curated Travel Plans on the Home screen.
class HomePlansPreview extends StatelessWidget {
  final VoidCallback onViewAllTap;

  const HomePlansPreview({super.key, required this.onViewAllTap});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final plans = [
      _PlanPreviewItem(
        title: 'One Day in Vijayapur',
        subtitle: '6 essential heritage stops',
        badge: l10n.oneDayPlan,
        icon: Icons.looks_one_rounded,
      ),
      _PlanPreviewItem(
        title: 'Two Days Trip (Plan I)',
        subtitle: 'Citadel, palaces & mosques',
        badge: l10n.twoDayPlan1,
        icon: Icons.looks_two_rounded,
      ),
      _PlanPreviewItem(
        title: 'Two Days Trip (Plan II)',
        subtitle: 'Fort bastions & water architecture',
        badge: l10n.twoDayPlan2,
        icon: Icons.looks_two_outlined,
      ),
      _PlanPreviewItem(
        title: 'Three Days Itinerary',
        subtitle: 'Comprehensive 16-stop tour',
        badge: l10n.threeDayPlan,
        icon: Icons.looks_3_rounded,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.homePlanYourVisit, style: AppTextStyles.title),
                    const SizedBox(height: 2),
                    Text(
                      l10n.homePlanSubtitle,
                      style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: onViewAllTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.homeViewAllPlans,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 11,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Horizontally scrollable preview cards
        SizedBox(
          height: 105,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: plans.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final plan = plans[index];
              return InkWell(
                onTap: onViewAllTap,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceVariant,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Text(
                                plan.badge,
                                style: AppTextStyles.label.copyWith(
                                  fontSize: 10,
                                  color: AppColors.primaryDark,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(plan.icon, size: 18, color: AppColors.primary),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.title,
                            style: AppTextStyles.label.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            plan.subtitle,
                            style: AppTextStyles.bodySecondary.copyWith(
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PlanPreviewItem {
  final String title;
  final String subtitle;
  final String badge;
  final IconData icon;

  const _PlanPreviewItem({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.icon,
  });
}
