import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/language_selection_modal.dart';
import '../../../../core/localization/l10n_extensions.dart';
import '../../../../core/localization/locale_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;
  bool _notificationsEnabled = true;

  Future<void> _logout() async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.signOut, style: AppTextStyles.title),
        content: const Text(
          'Are you sure you want to sign out of Vijayapura Tourism?',
          style: AppTextStyles.bodySecondary,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(l10n.signOut),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final displayName = _user?.displayName ?? l10n.homeDefaultUser;
    final email = _user?.email ?? 'explore@vijayapura.karnataka.gov.in';
    final currentLang = LocaleController.instance.currentLanguage;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.profileTitle, style: AppTextStyles.headline),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
        children: [
          // User Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    displayName.isNotEmpty ? displayName[0].toUpperCase() : 'V',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: AppTextStyles.title.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        email,
                        style: AppTextStyles.bodySecondary.copyWith(
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          l10n.accountDetails,
                          style: AppTextStyles.label.copyWith(
                            fontSize: 10,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Saved & Activity Section
          const Text('Saved & Activity', style: AppTextStyles.title),
          const SizedBox(height: 10),
          _ProfileMenuTile(
            icon: Icons.bookmark_outline,
            title: 'Saved Places & Monuments',
            subtitle: 'Curated bookmarks of Adil Shahi architectural sites',
            trailingText: '6 Sites',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bookmarks are synced with local state.'),
                ),
              );
            },
          ),
          _ProfileMenuTile(
            icon: Icons.route_outlined,
            title: 'Saved Travel Plans',
            subtitle: '1-Day and 2-Day custom itineraries',
            trailingText: '2 Plans',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Custom itinerary sync will connect to Cloud Firestore.',
                  ),
                ),
              );
            },
          ),
          _ProfileMenuTile(
            icon: Icons.history,
            title: 'Recently Viewed',
            subtitle: 'Gol Gumbaz, Ibrahim Rauza, Bara Kaman',
            onTap: () {},
          ),
          const SizedBox(height: 24),

          // App Settings & Preferences
          const Text('Preferences & Settings', style: AppTextStyles.title),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text(
                    'Travel Notifications',
                    style: AppTextStyles.label,
                  ),
                  subtitle: const Text(
                    'Opening alert reminders and weather updates',
                    style: AppTextStyles.bodySecondary,
                  ),
                  value: _notificationsEnabled,
                  activeTrackColor: AppColors.primary,
                  onChanged: (val) {
                    setState(() {
                      _notificationsEnabled = val;
                    });
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.language, color: AppColors.primary),
                  title: Text(
                    l10n.languagePreference,
                    style: AppTextStyles.label,
                  ),
                  subtitle: Text(
                    '${currentLang.nativeName} (${currentLang.displayName})',
                    style: AppTextStyles.bodySecondary,
                  ),
                  trailing: const Icon(Icons.chevron_right, size: 20),
                  onTap: () => showLanguageSelectionModal(context),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                  ),
                  title: Text(l10n.aboutApp, style: AppTextStyles.label),
                  subtitle: Text(
                    '${l10n.version} 1.0.0 • Department of Tourism Karnataka',
                    style: AppTextStyles.bodySecondary,
                  ),
                  trailing: const Icon(Icons.chevron_right, size: 20),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'Vijayapura Tourism',
                      applicationVersion: '1.0.0',
                      applicationLegalese: 'Crafted for heritage preservation and traveler discovery.',
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Logout Button
          OutlinedButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: AppColors.error),
            label: Text(
              l10n.signOut,
              style: const TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.error),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? trailingText;
  final VoidCallback onTap;

  const _ProfileMenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailingText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        title: Text(title, style: AppTextStyles.label),
        subtitle: Text(subtitle, style: AppTextStyles.bodySecondary),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingText != null) ...[
              Text(
                trailingText!,
                style: AppTextStyles.bodySecondary.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 6),
            ],
            const Icon(Icons.chevron_right, size: 18),
          ],
        ),
      ),
    );
  }
}
