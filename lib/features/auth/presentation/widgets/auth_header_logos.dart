import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Responsive institutional 3-logo header used across Authentication screens
/// (Sign In and Sign Up), matching the official branding row on Home.
///
/// LEFT: Vijayapura Tourism / Discover Vijayapura
/// CENTER: Karnataka Tourism (Department of Tourism)
/// RIGHT: BLDEACET
class AuthHeaderLogos extends StatelessWidget {
  const AuthHeaderLogos({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      margin: const EdgeInsets.only(bottom: 24),
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

                // CENTER: Karnataka Tourism logo
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
    );
  }
}
