import 'package:flutter/material.dart';

import '../../../../core/localization/l10n_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../data/repositories/local_places_repository.dart';
import '../../domain/models/place.dart';
import '../../domain/models/place_localizations.dart';
import '../../domain/repositories/places_repository.dart';
import 'place_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  final String? initialCategory;

  const ExploreScreen({super.key, this.initialCategory});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final PlacesRepository _repository = LocalPlacesRepository();
  final TextEditingController _searchController = TextEditingController();

  List<Place> _places = [];
  List<String> _categories = [];
  String _selectedCategory = 'All';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      _selectedCategory = widget.initialCategory!;
    }
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    final categories = await _repository.getCategories();
    final places = await _repository.getPlaces();

    if (!mounted) return;
    setState(() {
      _categories = categories;
      _places = places;
      _isLoading = false;
    });
  }

  Future<void> _filterByCategory(String category) async {
    setState(() {
      _selectedCategory = category;
      _isLoading = true;
    });

    final filtered = await _repository.getPlacesByCategory(category);
    if (!mounted) return;
    setState(() {
      _places = filtered;
      _isLoading = false;
    });
  }

  Future<void> _onSearchChanged(String query) async {
    final results = await _repository.searchPlaces(query);
    if (!mounted) return;
    setState(() {
      _places = results;
    });
  }

  void _openPlaceDetail(Place place) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => PlaceDetailScreen(place: place)));
  }

  String _getCategoryLabel(String category, AppLocalizations l10n) {
    switch (category.toLowerCase()) {
      case 'all':
        return l10n.allPlaces;
      case 'mausoleums':
        return l10n.mausoleums;
      case 'monuments':
        return l10n.monuments;
      case 'forts & cannons':
        return l10n.historicForts;
      case 'temples & shrines':
        return l10n.religiousSites;
      default:
        return category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final locale = Localizations.maybeLocaleOf(context) ?? const Locale('en');

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.exploreTitle, style: AppTextStyles.headline),
            Text(
              l10n.exploreSubtitle,
              style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: l10n.searchPlaces,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          _filterByCategory(_selectedCategory);
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),

          // Category Chips Horizontal Scroll
          if (_categories.isNotEmpty)
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected =
                      cat.toLowerCase() == _selectedCategory.toLowerCase();
                  return ChoiceChip(
                    label: Text(_getCategoryLabel(cat, l10n)),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        _searchController.clear();
                        _filterByCategory(cat);
                      }
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      fontSize: 13,
                    ),
                  );
                },
              ),
            ),

          const SizedBox(height: 12),

          // Place Cards List
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  )
                : _places.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.travel_explore,
                          size: 54,
                          color: AppColors.textSecondary.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 12),
                        Text(l10n.noPlacesFound, style: AppTextStyles.title),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                    itemCount: _places.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final place = _places[index].localized(locale);
                      return _PlaceCard(
                        place: place,
                        onTap: () => _openPlaceDetail(place),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  final Place place;
  final VoidCallback onTap;

  const _PlaceCard({required this.place, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large Imagery with Category & Duration Badge overlay
            Stack(
              children: [
                AppNetworkImage(
                  imageUrl: place.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryDark.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      place.category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 13,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          place.suggestedDuration,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (place.galleryUrls.length > 1)
                  Positioned(
                    bottom: 10,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.72),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.photo_library_outlined,
                            size: 11,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${place.galleryUrls.length} Photos',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),

            // Card Body
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          place.name,
                          style: AppTextStyles.title.copyWith(fontSize: 17),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    place.shortDescription,
                    style: AppTextStyles.bodySecondary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 10),

                  // Metadata row: Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          place.locationName,
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
