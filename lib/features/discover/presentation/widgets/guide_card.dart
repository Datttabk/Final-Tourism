import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/localization/l10n_extensions.dart';
import '../../domain/models/tourist_guide.dart';

/// Card widget presenting a verified tourist guide in Vijayapura.
///
/// Public UI fields strictly limited to:
/// - Name
/// - Languages Spoken
/// - Experience
/// - Contact Number
class GuideCard extends StatelessWidget {
  final TouristGuide guide;

  const GuideCard({super.key, required this.guide});

  void _showContactModal(BuildContext context) {
    final l10n = context.l10n;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.phone_in_talk_rounded, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(l10n.touristGuides, style: AppTextStyles.title),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reach out to ${guide.name}:',
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.contactNumber,
                    style: AppTextStyles.bodySecondary.copyWith(fontSize: 11),
                  ),
                  const SizedBox(height: 4),
                  SelectableText(
                    guide.contactNumber,
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${l10n.experience}: ${guide.experience}\n${l10n.languagesSpoken}: ${guide.formattedLanguages}',
              style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          OutlinedButton.icon(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: guide.contactNumber));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${guide.contactNumber} ${l10n.copiedToClipboard}',
                  ),
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            icon: const Icon(Icons.copy, size: 14),
            label: Text(l10n.copy),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Dialing ${guide.name} (${guide.contactNumber})...',
                  ),
                  backgroundColor: AppColors.primaryDark,
                ),
              );
            },
            icon: const Icon(Icons.call, size: 16),
            label: Text(l10n.dialNow),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
            // Top: Avatar + Name + Experience
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                  child: Text(
                    guide.name.isNotEmpty ? guide.name[0] : 'G',
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        guide.name,
                        style: AppTextStyles.title.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.history_edu_outlined,
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${l10n.experience}: ${guide.experience}',
                            style: AppTextStyles.bodySecondary.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Languages Spoken
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.translate_rounded,
                    size: 14,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: guide.languagesSpoken.map((lang) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          lang,
                          style: AppTextStyles.label.copyWith(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 10),

            // Contact Number & Action Button
            Row(
              children: [
                const Icon(
                  Icons.phone_outlined,
                  size: 15,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    guide.contactNumber,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => _showContactModal(context),
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
