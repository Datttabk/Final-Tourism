import 'package:flutter/material.dart';

import '../../../../core/localization/language_selection_modal.dart';
import '../../../../core/localization/l10n_extensions.dart';
import '../../../../core/localization/locale_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Minimal language selection card for the Home screen.
///
/// Replaces the old "Travel Safely" preview card while connecting directly
/// to the single global [LocaleController].
class HomeLanguageSection extends StatelessWidget {
  const HomeLanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final currentLang = LocaleController.instance.currentLanguage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => showLanguageSelectionModal(context),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header Row with Icon & Title
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.translate_rounded,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.homeChooseLanguage,
                          style: AppTextStyles.title.copyWith(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    l10n.homeChooseLanguageSubtitle,
                    style: AppTextStyles.bodySecondary.copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 16),

                  // Currently Selected Language Display Box
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          currentLang.nativeName,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${currentLang.displayName})',
                          style: AppTextStyles.bodySecondary.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.primary,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Change Language Link CTA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        l10n.homeChangeLanguage,
                        style: AppTextStyles.label.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
