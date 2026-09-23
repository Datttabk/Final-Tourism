import 'package:flutter/material.dart';

import '../../../../core/localization/l10n_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Compact preview section for Discover categories on the Home screen.
class HomeDiscoverPreview extends StatelessWidget {
  final VoidCallback onDiscoverMoreTap;

  const HomeDiscoverPreview({super.key, required this.onDiscoverMoreTap});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final categories = [
      _DiscoverCategoryItem(
        title: l10n.hotelsAndStay,
        subtitle: '37 verified stays',
        icon: Icons.hotel_rounded,
      ),
      _DiscoverCategoryItem(
        title: l10n.localCuisine,
        subtitle: '6 culinary hubs',
        icon: Icons.restaurant_rounded,
      ),
      _DiscoverCategoryItem(
        title: l10n.bazaarsAndCraft,
        subtitle: '8 markets & 5 crafts',
        icon: Icons.storefront_rounded,
      ),
      _DiscoverCategoryItem(
        title: l10n.touristGuides,
        subtitle: '7 certified guides',
        icon: Icons.person_pin_rounded,
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
                    Text(l10n.homeDiscoverLocal, style: AppTextStyles.title),
                    const SizedBox(height: 2),
                    Text(
                      l10n.homeDiscoverSubtitle,
                      style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: onDiscoverMoreTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.homeDiscoverMore,
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

        // 2x2 Grid of compact category cards
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildCategoryTile(categories[0]),
                    const SizedBox(height: 10),
                    _buildCategoryTile(categories[2]),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    _buildCategoryTile(categories[1]),
                    const SizedBox(height: 10),
                    _buildCategoryTile(categories[3]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTile(_DiscoverCategoryItem item) {
    return InkWell(
      onTap: onDiscoverMoreTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(item.icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: AppTextStyles.label.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    style: AppTextStyles.bodySecondary.copyWith(fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

class _DiscoverCategoryItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const _DiscoverCategoryItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
