import 'package:flutter/material.dart';

import '../../../../core/localization/app_language.dart';
import '../../../../core/localization/language_selection_modal.dart';
import '../../../../core/localization/l10n_extensions.dart';
import '../../../../core/localization/locale_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Top header for the Home screen:
/// Displays personalized greeting from Firebase displayName,
/// compact language selector, and profile avatar button.
class HomeHeader extends StatelessWidget {
  final String? displayName;
  final VoidCallback onProfileTap;

  const HomeHeader({
    super.key,
    required this.displayName,
    required this.onProfileTap,
    // Keep optional legacy parameters if any callers pass them
    AppLanguage? currentLanguage,
    ValueChanged<AppLanguage>? onLanguageChanged,
  });

  String _resolveUserName(BuildContext context) {
    if (displayName == null || displayName!.trim().isEmpty) {
      return context.l10n.homeDefaultUser;
    }
    final trimmed = displayName!.trim();
    return trimmed.split(' ').first;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final userName = _resolveUserName(context);
    final greetingText = l10n.homeGreeting(userName);
    final currentLang = LocaleController.instance.currentLanguage;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Official Institutional Header: 3 Logos
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            margin: const EdgeInsets.only(bottom: 14),
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isCompact = constraints.maxWidth < 360;
                final logoHeight = isCompact ? 36.0 : 44.0;

                return SizedBox(
                  height: logoHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // LEFT: Vijayapura Tourism / Discover Vijayapura artwork
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              'assets/images/branding/vijayapura_tourism_logo.jpg',
                              height: logoHeight,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // CENTER: Karnataka Tourism logo (central identity, wider flex)
                      Expanded(
                        flex: 5,
                        child: Center(
                          child: Image.asset(
                            'assets/images/branding/karnataka_tourism_logo.png',
                            height: logoHeight,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox.shrink(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // RIGHT: BLDEACET logo
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              'assets/images/branding/bldeacet_logo.jpg',
                              height: logoHeight,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Greeting & Tagline
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      greetingText,
                      style: AppTextStyles.headline.copyWith(
                        fontSize: 22,
                        letterSpacing: -0.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.homeTagline,
                      style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // Language Selector Button
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => showLanguageSelectionModal(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.translate_rounded,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        currentLang.nativeName,
                        style: AppTextStyles.label.copyWith(
                          fontSize: 12,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Profile Button
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onProfileTap,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : 'T',
                      style: const TextStyle(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
