import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import '../../domain/models/hotel.dart';

/// Card widget presenting a verified hotel/stay in Vijayapura.
///
/// Strictly adheres to location and content display rules:
/// - Coordinates (latitude, longitude) are internal backend fields and NEVER rendered in the address.
/// - Shows Google Maps action when a verified link is supplied.
/// - Preserves exact spreadsheet data for rooms, amenities, contacts, and destinations.
class HotelCard extends StatelessWidget {
  final Hotel hotel;
  final VoidCallback? onNavigate;

  const HotelCard({super.key, required this.hotel, this.onNavigate});

  void _showGoogleMapsModal(BuildContext context) {
    if (hotel.mapsUrl == null) return;
    final url = hotel.mapsUrl!;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            16,
            24,
            MediaQuery.of(ctx).viewInsets.bottom + 28,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.map_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel.name,
                          style: AppTextStyles.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Verified Google Maps Destination',
                          style: AppTextStyles.bodySecondary.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.verified_outlined,
                          size: 16,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Google Maps Place Link',
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.success,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    SelectableText(
                      url,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 13,
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: url));
                        Navigator.of(ctx).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Google Maps link for ${hotel.name} copied to clipboard!',
                            ),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded, size: 16),
                      label: const Text('Copy Maps Link'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        UrlLauncherHelper.openUrl(url);
                      },
                      icon: const Icon(Icons.open_in_new, size: 16),
                      label: const Text('Open in Maps'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showNavigationHandoff(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.navigation_rounded, color: AppColors.primary),
            const SizedBox(width: 8),
            const Text('Navigation Handoff', style: AppTextStyles.title),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Routing navigation to ${hotel.name}:',
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                hotel.address,
                style: AppTextStyles.body.copyWith(fontSize: 13),
              ),
            ),
            if (hotel.isApproximateLocation) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 14,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Location coordinates are approximate and pending verification.',
                        style: AppTextStyles.bodySecondary.copyWith(
                          fontSize: 11,
                          color: AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              if (hotel.hasValidMapsUrl) {
                UrlLauncherHelper.openUrl(hotel.mapsUrl!);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Starting route to ${hotel.name}...'),
                    backgroundColor: AppColors.primaryDark,
                  ),
                );
              }
            },
            icon: const Icon(Icons.directions, size: 16),
            label: const Text('Navigate'),
          ),
        ],
      ),
    );
  }

  void _showDetailsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, scrollController) {
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Title and Type badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              hotel.type,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            hotel.name,
                            style: AppTextStyles.title.copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    if (hotel.numberOfGuestRooms.isNotEmpty &&
                        hotel.numberOfGuestRooms != 'Nil')
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.meeting_room_outlined,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${hotel.numberOfGuestRooms} Rooms',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: AppColors.border),
                const SizedBox(height: 16),

                // Address & Taluka
                _detailSection(
                  icon: Icons.location_on_outlined,
                  title: 'Address',
                  content:
                      '${hotel.address}\nTaluka: ${hotel.taluka} | District: ${hotel.district}',
                ),

                // Key Facilities & Amenities
                if (hotel.amenities.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  _detailSection(
                    icon: Icons.room_service_outlined,
                    title: 'Facilities & Amenities',
                    content: hotel.amenities,
                  ),
                ],

                // Contact Person & Phone
                if (hotel.contactPerson.isNotEmpty || hotel.hasPhoneNumber) ...[
                  const SizedBox(height: 14),
                  _detailSection(
                    icon: Icons.person_outline,
                    title: 'Contact Information',
                    content: [
                      if (hotel.contactPerson.isNotEmpty)
                        'Contact: ${hotel.contactPerson}',
                      if (hotel.hasPhoneNumber) 'Phone: ${hotel.phoneNumber}',
                    ].join('\n'),
                    actionWidget: hotel.hasPhoneNumber
                        ? IconButton(
                            icon: const Icon(Icons.copy, size: 18),
                            tooltip: 'Copy Phone',
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: hotel.phoneNumber),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Phone number copied!'),
                                ),
                              );
                            },
                          )
                        : null,
                  ),
                ],

                // Email
                if (hotel.hasEmail) ...[
                  const SizedBox(height: 14),
                  _detailSection(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    content: hotel.email,
                    actionWidget: IconButton(
                      icon: const Icon(Icons.copy, size: 18),
                      tooltip: 'Copy Email',
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: hotel.email));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Email copied!')),
                        );
                      },
                    ),
                  ),
                ],

                // Nearest Tourist Destination
                if (hotel.nearestTouristDestination.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  _detailSection(
                    icon: Icons.near_me_outlined,
                    title: 'Nearest Tourist Destination & Distance',
                    content: hotel.nearestTouristDestination,
                  ),
                ],

                // Google Maps source / link
                const SizedBox(height: 14),
                _detailSection(
                  icon: Icons.map_outlined,
                  title: 'Google Maps / Location Reference',
                  content: hotel.mapsSourceValue.isNotEmpty
                      ? hotel.mapsSourceValue
                      : (hotel.mapsUrl ?? 'Not specified'),
                  actionWidget: hotel.hasValidMapsUrl
                      ? TextButton.icon(
                          onPressed: () =>
                              UrlLauncherHelper.openUrl(hotel.mapsUrl!),
                          icon: const Icon(Icons.open_in_new, size: 16),
                          label: const Text('Open'),
                        )
                      : null,
                ),

                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _detailSection({
    required IconData icon,
    required String title,
    required String content,
    Widget? actionWidget,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.label.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                SelectableText(
                  content,
                  style: AppTextStyles.body.copyWith(fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
          if (actionWidget != null) actionWidget,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      color: AppColors.surface,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showDetailsModal(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Icon + Type Badge + Featured / Approx Tag
              Row(
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
                      Icons.hotel_rounded,
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
                          hotel.name,
                          style: AppTextStyles.title.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(
                                  alpha: 0.08,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                hotel.type,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (hotel.numberOfGuestRooms.isNotEmpty &&
                                hotel.numberOfGuestRooms != 'Nil') ...[
                              const SizedBox(width: 6),
                              Text(
                                '• ${hotel.numberOfGuestRooms} Rooms',
                                style: AppTextStyles.bodySecondary.copyWith(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (hotel.featuredPriority != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentGold,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, size: 12, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            'Featured #${hotel.featuredPriority}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (hotel.isApproximateLocation)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: AppColors.warning.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 12,
                            color: AppColors.warning,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Approximate',
                            style: AppTextStyles.label.copyWith(
                              fontSize: 10,
                              color: AppColors.warning,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),

              // Address display (NEVER showing latitude or longitude)
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
                      hotel.address,
                      style: AppTextStyles.bodySecondary.copyWith(
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),

              // Nearest destination preview if present
              if (hotel.nearestTouristDestination.isNotEmpty) ...[
                const SizedBox(height: 6),
                Row(
                  children: [
                    const SizedBox(width: 24),
                    Expanded(
                      child: Text(
                        'Near: ${hotel.nearestTouristDestination}',
                        style: AppTextStyles.bodySecondary.copyWith(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 12),
              const Divider(height: 1, color: AppColors.border),
              const SizedBox(height: 12),

              // Action row: Google Maps, View Details & Directions
              Row(
                children: [
                  if (hotel.hasValidMapsUrl) ...[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            UrlLauncherHelper.openUrl(hotel.mapsUrl!),
                        icon: const Icon(Icons.map_outlined, size: 15),
                        label: const Text(
                          'Google Maps',
                          style: TextStyle(fontSize: 12),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryDark,
                          side: const BorderSide(color: AppColors.border),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showDetailsModal(context),
                      icon: const Icon(Icons.info_outline, size: 15),
                      label: const Text(
                        'Details',
                        style: TextStyle(fontSize: 12),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryDark,
                        side: const BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        if (onNavigate != null) {
                          onNavigate!();
                        } else {
                          _showNavigationHandoff(context);
                        }
                      },
                      icon: const Icon(Icons.directions_outlined, size: 15),
                      label: const Text(
                        'Directions',
                        style: TextStyle(fontSize: 12),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
