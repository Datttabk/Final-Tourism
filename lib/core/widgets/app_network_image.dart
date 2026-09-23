import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Resilient image widget with heritage-themed loading & error states.
class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final IconData fallbackIcon;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.fallbackIcon = Icons.account_balance,
  });

  Widget _buildFallback() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.surfaceVariant, AppColors.tagBackground],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: borderRadius,
      ),
      child: Center(
        child: Icon(
          fallbackIcon,
          size: 36,
          color: AppColors.primary.withValues(alpha: 0.6),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget imageWidget;

    if (imageUrl.startsWith('assets/')) {
      imageWidget = Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildFallback(),
      );
    } else {
      imageWidget = Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: borderRadius,
            ),
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => _buildFallback(),
      );
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }

    return imageWidget;
  }
}
