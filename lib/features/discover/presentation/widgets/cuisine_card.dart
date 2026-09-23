import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/models/cuisine_entry.dart';

/// Card widget presenting a traditional regional dish or culinary experience in Vijayapura.
///
/// Strictly displays:
/// - Dish name
/// - Dish type
/// - Ingredients & description
/// - Common local hubs / Where to explore
///
/// Never displays restaurant listings, fake reviews, or commercial actions.
class CuisineCard extends StatelessWidget {
  final CuisineEntry cuisine;

  const CuisineCard({super.key, required this.cuisine});

  Color _getBadgeColor() {
    final lower = cuisine.dishType.toLowerCase();
    if (lower.contains('non-vegetarian')) {
      return const Color(0xFFB3261E); // Warm crimson
    } else if (lower.contains('vegetarian')) {
      return const Color(0xFF2E7D32); // Deep forest green
    } else if (lower.contains('sweet') || lower.contains('dessert')) {
      return AppColors.accentGold;
    } else if (lower.contains('street') || lower.contains('snack')) {
      return const Color(0xFFE65100); // Amber orange
    } else {
      return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final badgeColor = _getBadgeColor();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Icon + Dish Name + Dish Type Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: badgeColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: badgeColor.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Icon(
                    Icons.restaurant_menu_rounded,
                    color: badgeColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cuisine.name,
                        style: AppTextStyles.title.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: badgeColor.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          cuisine.dishType,
                          style: AppTextStyles.label.copyWith(
                            fontSize: 11,
                            color: badgeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Ingredients & Description
            Text(
              cuisine.description,
              style: AppTextStyles.body.copyWith(
                fontSize: 13,
                height: 1.45,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),

            // Common Local Hubs / Where to explore
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.explore_outlined,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Common Local Hubs & Areas to Explore',
                        style: AppTextStyles.label.copyWith(
                          fontSize: 11,
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cuisine.bestHubs,
                    style: AppTextStyles.bodySecondary.copyWith(
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
