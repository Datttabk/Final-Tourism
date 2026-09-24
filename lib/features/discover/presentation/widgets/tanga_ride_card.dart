import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/localization/l10n_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import '../../domain/models/tanga_ride.dart';

/// Card widget presenting a verified Tanga Ride service provider in Vijayapura.
///
/// Public UI fields strictly limited to:
/// - Name (English and Kannada)
/// - Contact Number
class TangaRideCard extends StatelessWidget {
  final TangaRide tanga;

  const TangaRideCard({super.key, required this.tanga});

  void _callProvider() {
    UrlLauncherHelper.openUrl('tel:${tanga.contactNumber}');
  }

  void _copyContact(BuildContext context) {
    Clipboard.setData(ClipboardData(text: tanga.contactNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${tanga.contactNumber} copied to clipboard!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isKn = Localizations.localeOf(context).languageCode == 'kn';

    // Primary name based on active locale, secondary displays alternate script
    final primaryName = isKn ? tanga.nameKn : tanga.nameEn;
    final secondaryName = isKn ? tanga.nameEn : tanga.nameKn;

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
            // Top: Avatar + Name (English & Kannada)
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                  child: const Icon(
                    Icons.emoji_transportation_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        primaryName,
                        style: AppTextStyles.title.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (secondaryName != primaryName) ...[
                        const SizedBox(height: 2),
                        Text(
                          secondaryName,
                          style: AppTextStyles.bodySecondary.copyWith(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 12),

            // Contact Number & Action Buttons
            Row(
              children: [
                const Icon(
                  Icons.phone_outlined,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: InkWell(
                    onTap: _callProvider,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        tanga.contactNumber,
                        style: AppTextStyles.body.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, size: 16),
                  tooltip: 'Copy Number',
                  onPressed: () => _copyContact(context),
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 4),
                FilledButton.icon(
                  onPressed: _callProvider,
                  icon: const Icon(Icons.call, size: 14),
                  label: Text(l10n.call, style: const TextStyle(fontSize: 12)),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
