import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/models/bazaar_market.dart';

/// Card widget presenting a traditional commercial market/bazaar in Vijayapura.
///
/// Strictly displays:
/// - Market name
/// - Category / Specialization
/// - Exact location / address
/// - Landmark
/// - Pincode
///
/// Never displays latitude/longitude or fake navigation buttons.
class BazaarMarketCard extends StatelessWidget {
  final BazaarMarket market;

  const BazaarMarketCard({super.key, required this.market});

  @override
  Widget build(BuildContext context) {
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
            // Store / Market Image if present
            if (market.imageUrl != null && market.imageUrl!.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    market.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceVariant,
                      child: const Center(
                        child: Icon(
                          Icons.storefront_rounded,
                          color: AppColors.textSecondary,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
            ],

            // Top Row: Icon + Market Name
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(
                    Icons.storefront_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        market.name,
                        style: AppTextStyles.title.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          market.category,
                          style: AppTextStyles.label.copyWith(
                            fontSize: 11,
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Description if available (e.g. Smarnika)
            if (market.description != null &&
                market.description!.isNotEmpty) ...[
              Text(
                market.description!,
                style: AppTextStyles.bodySecondary.copyWith(
                  fontSize: 13,
                  height: 1.45,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Exact Location / Address if available
            if (market.address != null && market.address!.isNotEmpty) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      market.address!,
                      style: AppTextStyles.bodySecondary.copyWith(
                        fontSize: 13,
                        height: 1.4,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],

            // Landmark & Pincode if available
            if ((market.landmark != null && market.landmark!.isNotEmpty) ||
                (market.pincode != null && market.pincode!.isNotEmpty)) ...[
              Row(
                children: [
                  if (market.landmark != null &&
                      market.landmark!.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.only(top: 1),
                      child: Icon(
                        Icons.flag_outlined,
                        size: 15,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Landmark: ${market.landmark}',
                        style: AppTextStyles.bodySecondary.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ] else
                    const Spacer(),
                  if (market.pincode != null && market.pincode!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        'PIN ${market.pincode}',
                        style: AppTextStyles.label.copyWith(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            if ((market.address == null || market.address!.isEmpty) &&
                (market.landmark == null || market.landmark!.isEmpty)) ...[
              Row(
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Location details pending verification',
                    style: AppTextStyles.bodySecondary.copyWith(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 10),

            // Navigation Status Indicator
            Row(
              children: [
                const Icon(
                  Icons.near_me_disabled_outlined,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Location navigation coming soon',
                  style: AppTextStyles.bodySecondary.copyWith(
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
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
