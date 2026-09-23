import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'app_language.dart';
import 'l10n_extensions.dart';
import 'locale_controller.dart';

/// Clean, responsive modal bottom sheet for switching between all 8 supported languages.
///
/// Modifies [LocaleController.instance], driving MaterialApp.locale rebuilds across the whole app.
void showLanguageSelectionModal(BuildContext context) {
  final l10n = context.l10n;
  final currentLang = LocaleController.instance.currentLanguage;

  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.surface,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top drag indicator
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Title & Subtitle
              Text(
                l10n.selectPreferredLanguage,
                style: AppTextStyles.title.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.selectLanguageSubtitle,
                style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 16),

              // List of all 8 supported languages
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: AppLanguage.values.length,
                  separatorBuilder: (_, _) => const Divider(
                    height: 1,
                    thickness: 0.5,
                    color: AppColors.border,
                  ),
                  itemBuilder: (_, index) {
                    final lang = AppLanguage.values[index];
                    final isSelected = lang == currentLang;

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      leading: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.surfaceVariant,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            lang.code.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.primaryDark,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        lang.nativeName,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 16,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isSelected
                              ? AppColors.primaryDark
                              : AppColors.textPrimary,
                        ),
                      ),
                      subtitle: Text(
                        lang.displayName,
                        style: AppTextStyles.bodySecondary.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.primary,
                              size: 22,
                            )
                          : const Icon(
                              Icons.radio_button_unchecked_rounded,
                              color: AppColors.border,
                              size: 20,
                            ),
                      onTap: () async {
                        Navigator.of(ctx).pop();
                        await LocaleController.instance.setLanguage(lang);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
