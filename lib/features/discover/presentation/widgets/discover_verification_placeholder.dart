import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/models/discover_item.dart';

/// State widget shown when directory listings for a category are pending
/// official verification and structured field validation.
class DiscoverVerificationPlaceholder extends StatelessWidget {
  final DiscoverCategory category;

  const DiscoverVerificationPlaceholder({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isCuisine = category == DiscoverCategory.food;
    final title = isCuisine ? 'Local Cuisine' : 'Bazaars & Craft';
    final statusMessage = isCuisine
        ? 'Local cuisine locations are being verified.'
        : 'Bazaars & craft locations are being verified.';
    final detailedDescription = isCuisine
        ? 'Our tourism catalog team is currently compiling and independently verifying authentic local dining spots, traditional Khanavalis (Jolada Roti meals), and Deccan culinary heritage establishments across Vijayapura.'
        : 'Official surveys are underway to authenticate verified artisan emporiums, certified Ilkal handloom cooperatives, and historic bazaar merchants across Vijayapura to ensure verified listings.';
    final icon = isCuisine
        ? Icons.restaurant_menu_rounded
        : Icons.storefront_rounded;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Heritage Icon Badge
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.border, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: AppColors.primary, size: 34),
            ),
            const SizedBox(height: 20),

            // Category Title
            Text(
              title,
              style: AppTextStyles.headline.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Official Status Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.accentGold.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.pending_actions_rounded,
                    size: 18,
                    color: AppColors.accentGold,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      statusMessage,
                      style: AppTextStyles.label.copyWith(
                        fontSize: 13,
                        color: AppColors.primaryDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Detailed Explanation
            Text(
              detailedDescription,
              style: AppTextStyles.bodySecondary.copyWith(
                fontSize: 13,
                height: 1.55,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Verification in Progress Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.verified_outlined,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Official Directory Verification In Progress',
                    style: AppTextStyles.label.copyWith(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
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
