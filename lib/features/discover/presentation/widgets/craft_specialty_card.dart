import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/models/craft_specialty.dart';

/// Card widget presenting a traditional craft, textile, or regional specialty in Vijayapura.
///
/// Strictly displays:
/// - Craft/specialty name
/// - Description
/// - Key production / retail clusters
///
/// Contains no fabricated shops, addresses, phone numbers, prices, or e-commerce actions.
class CraftSpecialtyCard extends StatelessWidget {
  final CraftSpecialty craft;

  const CraftSpecialtyCard({super.key, required this.craft});

  @override
  Widget build(BuildContext context) {
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
            // Header: Icon + Specialty Title
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.accentGold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.accentGold.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Icon(
                    Icons.palette_outlined,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    craft.name,
                    style: AppTextStyles.title.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              craft.description,
              style: AppTextStyles.body.copyWith(
                fontSize: 13,
                height: 1.45,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 14),

            // Key Production / Retail Clusters
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
                        Icons.hub_outlined,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Key Production & Retail Clusters',
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
                    craft.productionRetailClusters,
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
