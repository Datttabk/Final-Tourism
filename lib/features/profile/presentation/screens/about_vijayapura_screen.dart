import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/url_launcher_helper.dart';

/// About Vijayapura screen presenting institutional contributors,
/// the student developer team, and official social media channels.
class AboutVijayapuraScreen extends StatelessWidget {
  const AboutVijayapuraScreen({super.key});

  static const String instagramUrl =
      'https://www.instagram.com/vijayapura.tourism/';
  static const String facebookUrl =
      'https://www.facebook.com/profile.php?id=100011590277981';
  static const String youtubeUrl =
      'https://www.youtube.com/@VijayapuraTourism';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('About Vijayapura', style: AppTextStyles.headline),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          // App Identity Card with 3 Logos
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // 3 Institutional Logos Row
                SizedBox(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/branding/vijayapura_tourism_logo.jpg',
                          height: 44,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox.shrink(),
                        ),
                      ),
                      Image.asset(
                        'assets/images/branding/karnataka_tourism_logo.png',
                        height: 40,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox.shrink(),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/branding/bldeacet_logo.jpg',
                          height: 44,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Vijayapura Tourism',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Adil Shahi Heritage & Cultural Experience App',
                  style: AppTextStyles.bodySecondary,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Supporters Section
          const Text('Supporters', style: AppTextStyles.title),
          const SizedBox(height: 12),
          _buildContributorCard(
            name: 'Dr. Anandh K',
            title:
                'Deputy Commissioner and Chairman District Tourism Development Committee Vijayapura',
            icon: Icons.account_balance_rounded,
          ),
          const SizedBox(height: 10),
          _buildContributorCard(
            name: 'Shri. Aravind Hugar',
            title: 'Deputy Director, Department of Tourism Vijayapura',
            icon: Icons.travel_explore_rounded,
          ),
          const SizedBox(height: 10),
          _buildContributorCard(
            name: 'Dr. Sumangala Biradar',
            title:
                "HOD,CSE(AI&ML), BLDEA's V P Dr PG Halakatti College of Engineering & Technology",
            icon: Icons.school_rounded,
          ),
          const SizedBox(height: 24),

          // Content Supporter Section
          const Text('Content Supporter', style: AppTextStyles.title),
          const SizedBox(height: 12),
          _buildContributorCard(
            name: 'Mr. Anilkumar Banajiger',
            title: 'District Tourism Consultant, Department of Tourism',
            icon: Icons.badge_rounded,
          ),
          const SizedBox(height: 24),

          // Development Team Section
          const Text('Development Team', style: AppTextStyles.title),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                _buildDeveloperRow('Datta Kambagi'),
                const Divider(height: 16),
                _buildDeveloperRow('Yaris Nadaf'),
                const Divider(height: 16),
                _buildDeveloperRow('Ishwar Shatgar'),
                const Divider(height: 16),
                _buildDeveloperRow('Darshan Wali'),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Social Media Links Section
          const Text('Connect With Us', style: AppTextStyles.title),
          const SizedBox(height: 12),
          Row(
            children: [
              // Instagram
              Expanded(
                child: _SocialMediaButton(
                  label: 'Instagram',
                  icon: Icons.camera_alt_outlined,
                  color: const Color(0xFFE1306C),
                  onTap: () => UrlLauncherHelper.openUrl(instagramUrl),
                ),
              ),
              const SizedBox(width: 10),
              // Facebook
              Expanded(
                child: _SocialMediaButton(
                  label: 'Facebook',
                  icon: Icons.facebook,
                  color: const Color(0xFF1877F2),
                  onTap: () => UrlLauncherHelper.openUrl(facebookUrl),
                ),
              ),
              const SizedBox(width: 10),
              // YouTube
              Expanded(
                child: _SocialMediaButton(
                  label: 'YouTube',
                  icon: Icons.play_circle_fill_rounded,
                  color: const Color(0xFFFF0000),
                  onTap: () => UrlLauncherHelper.openUrl(youtubeUrl),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContributorCard({
    required String name,
    required String title,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.label.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  style: AppTextStyles.bodySecondary.copyWith(
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperRow(String name) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: const Center(
            child: Icon(Icons.code_rounded, size: 16, color: AppColors.primary),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: AppTextStyles.label.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialMediaButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _SocialMediaButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
