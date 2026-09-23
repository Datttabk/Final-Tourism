import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class LocalHighlight {
  final String title;
  final String description;
  final IconData icon;

  const LocalHighlight({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class LocalHighlightsSection extends StatelessWidget {
  const LocalHighlightsSection({super.key});

  static const List<LocalHighlight> highlights = [
    LocalHighlight(
      title: 'Acoustic Mystery of Gol Gumbaz',
      description: 'A soft whisper against the gallery wall travels across the 38-metre interior diameter and echoes between 7 to 10 distinct times without electronic amplification.',
      icon: Icons.graphic_eq,
    ),
    LocalHighlight(
      title: 'Deccan Architecture Fusion',
      description: 'Vijayapura monuments showcase a unique synthesis of Persian, Ottoman, and indigenous Deccan stonecraft with characteristic petal domes and hanging stone chains.',
      icon: Icons.architecture,
    ),
    LocalHighlight(
      title: 'Subterranean Hydraulic Networks',
      description: 'The Adil Shahis engineered subterranean aqueducts leading from Torvi into municipal stepwells (Bawdis) and public fountains like Asar Mahal.',
      icon: Icons.water,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: highlights.map((highlight) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    highlight.icon,
                    size: 22,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        highlight.title,
                        style: AppTextStyles.label.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        highlight.description,
                        style: AppTextStyles.bodySecondary.copyWith(
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
