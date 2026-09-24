import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/localization/l10n_extensions.dart';
import '../../../../core/services/user_activity_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/map_placeholder_boundary.dart';
import '../../domain/models/place.dart';
import '../../domain/models/place_localizations.dart';

class PlaceDetailScreen extends StatefulWidget {
  final Place place;

  const PlaceDetailScreen({super.key, required this.place});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  late bool _isBookmarked;
  int _selectedImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _isBookmarked = UserActivityController.instance.isPlaceBookmarked(
      widget.place.id,
    );
    UserActivityController.instance.recordPlaceViewed(widget.place.id);
  }

  void _toggleBookmark() async {
    await UserActivityController.instance.togglePlaceBookmark(widget.place.id);
    if (!mounted) return;
    setState(() {
      _isBookmarked = UserActivityController.instance.isPlaceBookmarked(
        widget.place.id,
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBookmarked
              ? 'Saved "${widget.place.name}" to Bookmarks.'
              : 'Removed "${widget.place.name}" from Bookmarks.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openFullScreenImage(
    BuildContext context,
    List<String> images,
    int initialIndex,
    String title,
    Map<String, String> imageCaptions,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _FullScreenImageViewer(
          images: images,
          initialIndex: initialIndex,
          title: title,
          imageCaptions: imageCaptions,
        ),
      ),
    );
  }

  void _openInMaps(BuildContext context, Place place, [String? overrideUrl]) {
    final url =
        overrideUrl ??
        place.mapsUrl ??
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent('${place.name}, Vijayapura, Karnataka')}';

    UrlLauncherHelper.openUrl(url);

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
                          place.name,
                          style: AppTextStyles.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Google Maps Destination',
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
                          Icons.link,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Destination Maps Link',
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.primaryDark,
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
                              'Google Maps link for ${place.name} copied to clipboard!',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy, size: 18),
                      label: const Text('Copy Link'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        UrlLauncherHelper.openUrl(url);
                        Navigator.of(ctx).pop();
                      },
                      icon: const Icon(Icons.open_in_new, size: 18),
                      label: const Text('Open Maps'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.maybeLocaleOf(context) ?? const Locale('en');
    final l10n = context.l10n;
    final place = widget.place.localized(locale);

    final galleryList = place.galleryUrls.isNotEmpty
        ? place.galleryUrls
        : [place.imageUrl];

    final currentMainImage = (_selectedImageIndex < galleryList.length)
        ? galleryList[_selectedImageIndex]
        : galleryList.first;

    final currentCaption = place.imageCaptions[currentMainImage];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. Photo Gallery Hero AppBar with Back & Bookmark
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.textPrimary,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: AppColors.surface.withValues(alpha: 0.9),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                    size: 20,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.surface.withValues(alpha: 0.9),
                  child: IconButton(
                    icon: Icon(
                      _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: _isBookmarked
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      size: 22,
                    ),
                    onPressed: _toggleBookmark,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTap: () => _openFullScreenImage(
                      context,
                      galleryList,
                      _selectedImageIndex,
                      place.name,
                      place.imageCaptions,
                    ),
                    child: AppNetworkImage(
                      imageUrl: currentMainImage,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.5),
                          Colors.transparent,
                          AppColors.background.withValues(alpha: 0.95),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                  // Caption Overlay on Main Image
                  if (currentCaption != null && currentCaption.isNotEmpty)
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: galleryList.length > 1 ? 120 : 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.72),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Text(
                          currentCaption,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  // Gallery Count Badge
                  if (galleryList.length > 1)
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () => _openFullScreenImage(
                          context,
                          galleryList,
                          _selectedImageIndex,
                          place.name,
                          place.imageCaptions,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.72),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.photo_library_outlined,
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '${_selectedImageIndex + 1}/${galleryList.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Content body strictly adhering to Section 24 order
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Photo Gallery Thumbnails (Horizontal strip)
                  if (galleryList.length > 1) ...[
                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: galleryList.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final imgUrl = galleryList[index];
                          final isSelected = index == _selectedImageIndex;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImageIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.border,
                                  width: isSelected ? 2.5 : 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: AppNetworkImage(
                                  imageUrl: imgUrl,
                                  width: 90,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],

                  // 2. Place Name & Header Meta
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Text(
                          place.category.toUpperCase(),
                          style: AppTextStyles.label.copyWith(
                            fontSize: 11,
                            color: AppColors.primaryDark,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            place.suggestedDuration,
                            style: AppTextStyles.bodySecondary.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Display Name
                  Text(
                    place.name,
                    style: AppTextStyles.display.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 6),

                  // Location string
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          place.locationName,
                          style: AppTextStyles.bodySecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),

                  // 3. Description (Complete verbatim supplied text, no truncation)
                  Text(l10n.historyOverview, style: AppTextStyles.title),
                  const SizedBox(height: 10),
                  ...place.description
                      .split('\n\n')
                      .map(
                        (paragraph) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Text(
                            paragraph.trim(),
                            style: AppTextStyles.body.copyWith(
                              height: 1.6,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                  const SizedBox(height: 16),

                  // 4. Key Info Card: Timings, Gate Closing & Ticket Price
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        _InfoRow(
                          icon: Icons.schedule,
                          title: l10n.timings,
                          detail: (place.visitingTimings != null &&
                                  place.visitingTimings!.isNotEmpty)
                              ? place.visitingTimings!
                              : '${place.openingTime} – ${place.closingTime}',
                        ),
                        if (place.gateClosingTime != null) ...[
                          const Divider(height: 20),
                          _InfoRow(
                            icon: Icons.door_front_door_outlined,
                            title: 'Gate Closing',
                            detail: place.gateClosingTime!,
                            isAlert: true,
                          ),
                        ],
                        const Divider(height: 20),
                        _InfoRow(
                          icon: Icons.confirmation_number_outlined,
                          title: l10n.entryFee,
                          detail: place.ticketPriceInfo,
                        ),
                      ],
                    ),
                  ),

                  // 5. How to Reach Section
                  if (place.howToReach != null &&
                      place.howToReach!.isNotEmpty) ...[
                    const Text('How to Reach', style: AppTextStyles.title),
                    const SizedBox(height: 12),
                    if (place.howToReach!.byAir != null &&
                        place.howToReach!.byAir!.isNotEmpty)
                      _TransportCard(
                        icon: Icons.flight,
                        mode: 'By Air',
                        details: place.howToReach!.byAir!,
                      ),
                    if (place.howToReach!.byTrain != null &&
                        place.howToReach!.byTrain!.isNotEmpty)
                      _TransportCard(
                        icon: Icons.train,
                        mode: 'By Train',
                        details: place.howToReach!.byTrain!,
                      ),
                    if (place.howToReach!.byBus != null &&
                        place.howToReach!.byBus!.isNotEmpty)
                      _TransportCard(
                        icon: Icons.directions_bus,
                        mode: 'By Bus',
                        details: place.howToReach!.byBus!,
                      ),
                    if (place.howToReach!.byRoad != null &&
                        place.howToReach!.byRoad!.isNotEmpty)
                      _TransportCard(
                        icon: Icons.directions_car,
                        mode: 'By Road',
                        details: place.howToReach!.byRoad!,
                      ),
                    const SizedBox(height: 20),
                  ],

                  // 6. Clickable [ Open in Maps ] Action Button(s)
                  if (place.secondaryMapsUrl != null &&
                      place.secondaryMapsUrl!.isNotEmpty) ...[
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            _openInMaps(context, place, place.mapsUrl),
                        icon: const Icon(Icons.map_rounded, size: 20),
                        label: Text(
                          place.name.contains('Mallayya')
                              ? 'Open Mallayya in Maps'
                              : 'Open in Maps',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            _openInMaps(context, place, place.secondaryMapsUrl),
                        icon: const Icon(Icons.map_rounded, size: 20),
                        label: Text(
                          place.secondaryMapsLabel ?? 'Open Kalmeshwar in Maps',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surface,
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 1,
                        ),
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () => _openInMaps(context, place),
                        icon: const Icon(Icons.map_rounded, size: 20),
                        label: const Text(
                          'Open in Maps',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 1,
                        ),
                      ),
                    ),
                  ],
                  if (place.bookingUrl != null &&
                      place.bookingUrl!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            UrlLauncherHelper.openUrl(place.bookingUrl!),
                        icon: const Icon(
                          Icons.confirmation_number_outlined,
                          size: 20,
                        ),
                        label: const Text(
                          'Book Online',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E20),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 1,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 28),

                  // 7. Existing additional detail sections: Map Boundary
                  Text(l10n.location, style: AppTextStyles.title),
                  const SizedBox(height: 4),
                  Text(
                    'Integration boundary for map provider navigation handoff.',
                    style: AppTextStyles.bodySecondary.copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  MapPlaceholderBoundary(
                    locationTitle: place.name,
                    coordinates: place.coordinates,
                    onNavigatePressed: () => _openInMaps(context, place),
                  ),
                  const SizedBox(height: 28),

                  // Nearby Attractions Section
                  if (place.nearbyAttractionNames.isNotEmpty) ...[
                    Text(l10n.nearbyAttractions, style: AppTextStyles.title),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: place.nearbyAttractionNames.map((name) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.near_me_outlined,
                                size: 14,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 6),
                              Text(name, style: AppTextStyles.label),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Nearby Food & Stays Recommendations
                  if (place.nearbyFoodRecommendations.isNotEmpty ||
                      place.nearbyAccommodationRecommendations.isNotEmpty) ...[
                    Text(l10n.nearbyFood, style: AppTextStyles.title),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (place.nearbyFoodRecommendations.isNotEmpty) ...[
                            Row(
                              children: [
                                const Icon(
                                  Icons.restaurant,
                                  size: 16,
                                  color: AppColors.accentGold,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Local Food Hints',
                                  style: AppTextStyles.label.copyWith(
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              place.nearbyFoodRecommendations.join(' • '),
                              style: AppTextStyles.bodySecondary,
                            ),
                          ],
                          if (place
                              .nearbyAccommodationRecommendations
                              .isNotEmpty) ...[
                            if (place.nearbyFoodRecommendations.isNotEmpty)
                              const Divider(height: 18),
                            Row(
                              children: [
                                const Icon(
                                  Icons.hotel,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  l10n.nearbyStays,
                                  style: AppTextStyles.label.copyWith(
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              place.nearbyAccommodationRecommendations.join(
                                ' • ',
                              ),
                              style: AppTextStyles.bodySecondary,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransportCard extends StatelessWidget {
  final IconData icon;
  final String mode;
  final String details;

  const _TransportCard({
    required this.icon,
    required this.mode,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mode,
                  style: AppTextStyles.label.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details,
                  style: AppTextStyles.body.copyWith(fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  final bool isAlert;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.detail,
    this.isAlert = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: isAlert ? AppColors.warning : AppColors.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.label.copyWith(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                detail,
                style: AppTextStyles.body.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isAlert ? AppColors.warning : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FullScreenImageViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  final String title;
  final Map<String, String> imageCaptions;

  const _FullScreenImageViewer({
    required this.images,
    required this.initialIndex,
    required this.title,
    this.imageCaptions = const {},
  });

  @override
  State<_FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<_FullScreenImageViewer> {
  late final PageController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentImg = widget.images[_currentIndex];
    final caption = widget.imageCaptions[currentImg];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              '${_currentIndex + 1} of ${widget.images.length}',
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 3.5,
                  child: AppNetworkImage(
                    imageUrl: widget.images[index],
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              );
            },
          ),
          if (caption != null && caption.isNotEmpty)
            Positioned(
              bottom: 24,
              left: 20,
              right: 20,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    caption,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
