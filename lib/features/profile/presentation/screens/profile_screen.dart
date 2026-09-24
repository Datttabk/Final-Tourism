import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/language_selection_modal.dart';
import '../../../../core/localization/l10n_extensions.dart';
import '../../../../core/localization/locale_controller.dart';
import '../../../../core/services/plans_nav_controller.dart';
import '../../../../core/services/user_activity_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../explore/data/repositories/local_places_repository.dart';
import '../../../explore/presentation/screens/place_detail_screen.dart';
import '../../../travel_plans/data/repositories/local_travel_plans_repository.dart';
import 'about_vijayapura_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;
  final LocalPlacesRepository _placesRepo = LocalPlacesRepository();
  final LocalTravelPlansRepository _plansRepo = LocalTravelPlansRepository();
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

  void _showSavedPlacesSheet(BuildContext context) async {
    final allPlaces = await _placesRepo.getPlaces();
    final placeMap = {for (final p in allPlaces) p.id: p};

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollController) {
            return ListenableBuilder(
              listenable: UserActivityController.instance,
              builder: (ctx, _) {
                final savedIds =
                    UserActivityController.instance.bookmarkedPlaceIds;
                final savedPlaces = savedIds
                    .where((id) => placeMap.containsKey(id))
                    .map((id) => placeMap[id]!)
                    .toList();

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Saved Places & Monuments',
                                style: AppTextStyles.headline,
                              ),
                              Text(
                                '${savedPlaces.length} bookmarked destinations',
                                style: AppTextStyles.bodySecondary.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () => Navigator.of(ctx).pop(),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: savedPlaces.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(28),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.bookmark_border_rounded,
                                      size: 48,
                                      color: AppColors.textSecondary.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'No saved places yet',
                                      style: AppTextStyles.title,
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'Explore heritage monuments and tap the bookmark icon to save them here.',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.bodySecondary,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView.separated(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              itemCount: savedPlaces.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                final place = savedPlaces[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: AppNetworkImage(
                                          imageUrl: place.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      place.name,
                                      style: AppTextStyles.label.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      '${place.category} • ${place.locationName}',
                                      style: AppTextStyles.bodySecondary
                                          .copyWith(fontSize: 11),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: IconButton(
                                      tooltip: 'Remove bookmark',
                                      icon: const Icon(
                                        Icons.bookmark_rounded,
                                        color: AppColors.accentGold,
                                      ),
                                      onPressed: () {
                                        UserActivityController.instance
                                            .togglePlaceBookmark(place.id);
                                      },
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              PlaceDetailScreen(place: place),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  void _showSavedPlansSheet(BuildContext context) async {
    final allPlans = await _plansRepo.getPlans();
    final planMap = {for (final p in allPlans) p.id: p};

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollController) {
            return ListenableBuilder(
              listenable: UserActivityController.instance,
              builder: (ctx, _) {
                final savedIds = UserActivityController.instance.savedPlanIds;
                final savedPlans = savedIds
                    .where((id) => planMap.containsKey(id))
                    .map((id) => planMap[id]!)
                    .toList();

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Saved Travel Plans',
                                style: AppTextStyles.headline,
                              ),
                              Text(
                                '${savedPlans.length} saved custom itineraries',
                                style: AppTextStyles.bodySecondary.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () => Navigator.of(ctx).pop(),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: savedPlans.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(28),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.route_outlined,
                                      size: 48,
                                      color: AppColors.textSecondary.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'No saved travel plans yet',
                                      style: AppTextStyles.title,
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'Browse curated itineraries in the Plans section and tap the save button to keep them handy here.',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.bodySecondary,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView.separated(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              itemCount: savedPlans.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                final plan = savedPlans[index];
                                final planIndex = allPlans.indexWhere(
                                  (p) => p.id == plan.id,
                                );

                                return Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    leading: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.surfaceVariant,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.route_rounded,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    title: Text(
                                      plan.title,
                                      style: AppTextStyles.label.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      '${plan.variantLabel} • ${plan.tagline}',
                                      style: AppTextStyles.bodySecondary
                                          .copyWith(fontSize: 11),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: IconButton(
                                      tooltip: 'Remove plan',
                                      icon: const Icon(
                                        Icons.bookmark_rounded,
                                        color: AppColors.accentGold,
                                      ),
                                      onPressed: () {
                                        UserActivityController.instance
                                            .togglePlanSaved(plan.id);
                                      },
                                    ),
                                    onTap: () {
                                      if (planIndex >= 0) {
                                        PlansNavController.selectPlan(
                                          planIndex,
                                        );
                                        Navigator.of(context)
                                            .popUntil((r) => r.isFirst);
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  void _showRecentlyViewedSheet(BuildContext context) async {
    final allPlaces = await _placesRepo.getPlaces();
    final placeMap = {for (final p in allPlaces) p.id: p};

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, scrollController) {
            return ListenableBuilder(
              listenable: UserActivityController.instance,
              builder: (ctx, _) {
                final viewedIds =
                    UserActivityController.instance.recentlyViewedPlaceIds;
                final viewedPlaces = viewedIds
                    .where((id) => placeMap.containsKey(id))
                    .map((id) => placeMap[id]!)
                    .toList();

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Recently Viewed',
                                style: AppTextStyles.headline,
                              ),
                              Text(
                                '${viewedPlaces.length} destinations opened',
                                style: AppTextStyles.bodySecondary.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (viewedPlaces.isNotEmpty)
                                TextButton(
                                  onPressed: () {
                                    UserActivityController.instance
                                        .clearRecentlyViewed();
                                  },
                                  child: const Text('Clear'),
                                ),
                              IconButton(
                                icon: const Icon(Icons.close_rounded),
                                onPressed: () => Navigator.of(ctx).pop(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: viewedPlaces.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(28),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.history_rounded,
                                      size: 48,
                                      color: AppColors.textSecondary.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    const Text(
                                      'No recently viewed places yet',
                                      style: AppTextStyles.title,
                                    ),
                                    const SizedBox(height: 6),
                                    const Text(
                                      'Explore destinations across Vijayapura to see your recent browsing history here.',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.bodySecondary,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView.separated(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              itemCount: viewedPlaces.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (context, index) {
                                final place = viewedPlaces[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: AppNetworkImage(
                                          imageUrl: place.imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      place.name,
                                      style: AppTextStyles.label.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      '${place.category} • ${place.locationName}',
                                      style: AppTextStyles.bodySecondary
                                          .copyWith(fontSize: 11),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 14,
                                      color: AppColors.primary,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              PlaceDetailScreen(place: place),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final displayName = _user?.displayName ?? l10n.homeDefaultUser;
    final email = _user?.email ?? 'explore@vijayapura.karnataka.gov.in';

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

          // Saved & Activity Section (Live dynamic state)
          const Text('Saved & Activity', style: AppTextStyles.title),
          const SizedBox(height: 10),
          ListenableBuilder(
            listenable: UserActivityController.instance,
            builder: (context, _) {
              final controller = UserActivityController.instance;
              final savedCount = controller.bookmarkedPlaceIds.length;
              final plansCount = controller.savedPlanIds.length;
              final viewedCount = controller.recentlyViewedPlaceIds.length;

              return Column(
                children: [
                  _ProfileMenuTile(
                    icon: Icons.bookmark_outline,
                    title: 'Saved Places & Monuments',
                    subtitle: savedCount == 0
                        ? 'Tap to view bookmarked heritage sites'
                        : '$savedCount destinations bookmarked',
                    trailingText: '$savedCount Sites',
                    onTap: () => _showSavedPlacesSheet(context),
                  ),
                  _ProfileMenuTile(
                    icon: Icons.route_outlined,
                    title: 'Saved Travel Plans',
                    subtitle: plansCount == 0
                        ? 'Tap to view saved custom itineraries'
                        : '$plansCount itineraries saved',
                    trailingText: '$plansCount Plans',
                    onTap: () => _showSavedPlansSheet(context),
                  ),
                  _ProfileMenuTile(
                    icon: Icons.history,
                    title: 'Recently Viewed',
                    subtitle: viewedCount == 0
                        ? 'Explore destinations to see recent history'
                        : '$viewedCount destinations recently opened',
                    trailingText: viewedCount > 0
                        ? '$viewedCount Viewed'
                        : null,
                    onTap: () => _showRecentlyViewedSheet(context),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),

          // Preferences & Settings
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
                ListenableBuilder(
                  listenable: LocaleController.instance,
                  builder: (context, _) {
                    final currentLang =
                        LocaleController.instance.currentLanguage;
                    return ListTile(
                      leading: const Icon(
                        Icons.language,
                        color: AppColors.primary,
                      ),
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
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                  ),
                  title: const Text(
                    'About Vijayapura',
                    style: AppTextStyles.label,
                  ),
                  subtitle: const Text(
                    'Official contributors, development team & social media',
                    style: AppTextStyles.bodySecondary,
                  ),
                  trailing: const Icon(Icons.chevron_right, size: 20),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AboutVijayapuraScreen(),
                      ),
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
