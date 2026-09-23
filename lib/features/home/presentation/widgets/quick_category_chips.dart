import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class QuickCategoryItem {
  final String label;
  final IconData icon;
  final int targetTabIndex; // 1 for Explore, 3 for Discover

  const QuickCategoryItem({
    required this.label,
    required this.icon,
    required this.targetTabIndex,
  });
}

class QuickCategoryChips extends StatelessWidget {
  final ValueChanged<int> onCategorySelected;

  const QuickCategoryChips({super.key, required this.onCategorySelected});

  static const List<QuickCategoryItem> categories = [
    QuickCategoryItem(
      label: 'Mausoleums',
      icon: Icons.account_balance_outlined,
      targetTabIndex: 1,
    ),
    QuickCategoryItem(
      label: 'Forts & Bastions',
      icon: Icons.shield_outlined,
      targetTabIndex: 1,
    ),
    QuickCategoryItem(
      label: 'Stepwells & Bawdis',
      icon: Icons.water_drop_outlined,
      targetTabIndex: 1,
    ),
    QuickCategoryItem(
      label: 'Bazaars & Stays',
      icon: Icons.storefront_outlined,
      targetTabIndex: 3,
    ),
    QuickCategoryItem(
      label: 'Local Food',
      icon: Icons.restaurant_outlined,
      targetTabIndex: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return InkWell(
            onTap: () => onCategorySelected(cat.targetTabIndex),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 86,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(cat.icon, size: 20, color: AppColors.primary),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cat.label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.label.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
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
