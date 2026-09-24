import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/localization/l10n_extensions.dart';
import '../../data/repositories/local_discover_repository.dart';
import '../../domain/models/bazaar_market.dart';
import '../../domain/models/craft_specialty.dart';
import '../../domain/models/cuisine_entry.dart';
import '../../domain/models/discover_item.dart';
import '../../domain/models/hotel.dart';
import '../../domain/models/tanga_ride.dart';
import '../../domain/models/tourist_guide.dart';
import '../widgets/bazaar_market_card.dart';
import '../widgets/craft_specialty_card.dart';
import '../widgets/cuisine_card.dart';
import '../widgets/guide_card.dart';
import '../widgets/hotel_card.dart';
import '../widgets/tanga_ride_card.dart';

enum BazaarFilter { all, markets, crafts }

class DiscoverScreen extends StatefulWidget {
  final DiscoverCategory initialCategory;

  const DiscoverScreen({
    super.key,
    this.initialCategory = DiscoverCategory.accommodation,
  });

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final LocalDiscoverRepository _repository = LocalDiscoverRepository();
  final TextEditingController _searchController = TextEditingController();

  late DiscoverCategory _selectedCategory;
  BazaarFilter _selectedBazaarFilter = BazaarFilter.all;

  List<Hotel> _hotels = [];
  List<TouristGuide> _guides = [];
  List<BazaarMarket> _bazaars = [];
  List<CraftSpecialty> _crafts = [];
  List<CuisineEntry> _cuisines = [];
  List<TangaRide> _tangaRides = [];

  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    switch (_selectedCategory) {
      case DiscoverCategory.accommodation:
        final hotels = await _repository.getHotels(searchQuery: _searchQuery);
        if (!mounted) return;
        setState(() {
          _hotels = hotels;
          _isLoading = false;
        });
        break;

      case DiscoverCategory.food:
        final cuisines = await _repository.getCuisines(
          searchQuery: _searchQuery,
        );
        if (!mounted) return;
        setState(() {
          _cuisines = cuisines;
          _isLoading = false;
        });
        break;

      case DiscoverCategory.bazaars:
        final bazaars = await _repository.getBazaars(searchQuery: _searchQuery);
        final crafts = await _repository.getCrafts(searchQuery: _searchQuery);
        if (!mounted) return;
        setState(() {
          _bazaars = bazaars;
          _crafts = crafts;
          _isLoading = false;
        });
        break;

      case DiscoverCategory.guides:
        final guides = await _repository.getTouristGuides(
          searchQuery: _searchQuery,
        );
        if (!mounted) return;
        setState(() {
          _guides = guides;
          _isLoading = false;
        });
        break;

      case DiscoverCategory.tanga:
        final tangaRides = await _repository.getTangaRides(
          searchQuery: _searchQuery,
        );
        if (!mounted) return;
        setState(() {
          _tangaRides = tangaRides;
          _isLoading = false;
        });
        break;
    }
  }

  void _onCategorySelected(DiscoverCategory cat) {
    if (cat == _selectedCategory) return;
    setState(() {
      _selectedCategory = cat;
      _searchQuery = '';
      _selectedBazaarFilter = BazaarFilter.all;
      _searchController.clear();
    });
    _loadData();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _loadData();
  }

  void _clearSearch() {
    _searchController.clear();
    _onSearchChanged('');
  }

  String _getSearchHint(AppLocalizations l10n) {
    switch (_selectedCategory) {
      case DiscoverCategory.accommodation:
        return l10n.searchHotels;
      case DiscoverCategory.food:
        return l10n.searchDishes;
      case DiscoverCategory.bazaars:
        return l10n.searchBazaars;
      case DiscoverCategory.guides:
        return l10n.searchGuides;
      case DiscoverCategory.tanga:
        return l10n.searchTanga;
    }
  }

  String _getCategoryName(DiscoverCategory cat, AppLocalizations l10n) {
    switch (cat) {
      case DiscoverCategory.accommodation:
        return l10n.hotelsAndStay;
      case DiscoverCategory.food:
        return l10n.localCuisine;
      case DiscoverCategory.bazaars:
        return l10n.bazaarsAndCraft;
      case DiscoverCategory.guides:
        return l10n.touristGuides;
      case DiscoverCategory.tanga:
        return l10n.tangaRides;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.discoverTitle, style: AppTextStyles.headline),
            Text(
              l10n.discoverSubtitle,
              style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 5 Primary Category Selector Tabs
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: DiscoverCategory.values.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(_getCategoryName(cat, l10n)),
                      selected: isSelected,
                      onSelected: (_) => _onCategorySelected(cat),
                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.surface,
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                      ),
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textPrimary,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: _getSearchHint(l10n),
                  hintStyle: AppTextStyles.bodySecondary.copyWith(fontSize: 13),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          onPressed: _clearSearch,
                          color: AppColors.textSecondary,
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),

          // Sub-filter for Bazaars & Craft
          if (_selectedCategory == DiscoverCategory.bazaars)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 6),
              child: Row(
                children: [
                  _buildSubFilterChip(
                    label: '${l10n.all} (${_bazaars.length + _crafts.length})',
                    filter: BazaarFilter.all,
                  ),
                  const SizedBox(width: 8),
                  _buildSubFilterChip(
                    label: '${l10n.markets} (${_bazaars.length})',
                    filter: BazaarFilter.markets,
                  ),
                  const SizedBox(width: 8),
                  _buildSubFilterChip(
                    label: '${l10n.crafts} (${_crafts.length})',
                    filter: BazaarFilter.crafts,
                  ),
                ],
              ),
            ),

          // Result Count Banner
          if (!_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                children: [
                  if (_selectedCategory == DiscoverCategory.accommodation)
                    Text(
                      _searchQuery.isEmpty
                          ? 'All ${_hotels.length} Stays in Vijayapura'
                          : '${_hotels.length} ${_hotels.length == 1 ? "stay" : "stays"} found',
                      style: AppTextStyles.label.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    )
                  else if (_selectedCategory == DiscoverCategory.food)
                    Text(
                      _searchQuery.isEmpty
                          ? 'All ${_cuisines.length} Regional Culinary Specialties'
                          : '${_cuisines.length} ${_cuisines.length == 1 ? "dish" : "dishes"} found',
                      style: AppTextStyles.label.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    )
                  else if (_selectedCategory == DiscoverCategory.bazaars)
                    Text(
                      _searchQuery.isEmpty
                          ? 'Showing ${_bazaars.length} Traditional Markets & ${_crafts.length} Craft Specialties'
                          : '${_bazaars.length + _crafts.length} matching listings found',
                      style: AppTextStyles.label.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    )
                  else if (_selectedCategory == DiscoverCategory.guides)
                    Text(
                      _searchQuery.isEmpty
                          ? 'All ${_guides.length} Registered Tourist Guides'
                          : '${_guides.length} ${_guides.length == 1 ? "guide" : "guides"} found',
                      style: AppTextStyles.label.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    )
                  else if (_selectedCategory == DiscoverCategory.tanga)
                    Text(
                      _searchQuery.isEmpty
                          ? 'All ${_tangaRides.length} Registered Tanga Ride Providers'
                          : '${_tangaRides.length} ${_tangaRides.length == 1 ? "provider" : "providers"} found',
                      style: AppTextStyles.label.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),

          // Active Category View
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  )
                : _buildCategoryContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSubFilterChip({
    required String label,
    required BazaarFilter filter,
  }) {
    final isSelected = _selectedBazaarFilter == filter;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBazaarFilter = filter;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceVariant : AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.2 : 1.0,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? AppColors.primaryDark : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryContent() {
    switch (_selectedCategory) {
      case DiscoverCategory.accommodation:
        if (_hotels.isEmpty) {
          return _buildEmptyState(
            icon: Icons.hotel_outlined,
            message: 'No hotels found matching "$_searchQuery"',
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          itemCount: _hotels.length,
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) => HotelCard(hotel: _hotels[index]),
        );

      case DiscoverCategory.food:
        if (_cuisines.isEmpty) {
          return _buildEmptyState(
            icon: Icons.restaurant_outlined,
            message: 'No local dishes found matching "$_searchQuery"',
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          itemCount: _cuisines.length,
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) =>
              CuisineCard(cuisine: _cuisines[index]),
        );

      case DiscoverCategory.bazaars:
        final showMarkets =
            _selectedBazaarFilter == BazaarFilter.all ||
            _selectedBazaarFilter == BazaarFilter.markets;
        final showCrafts =
            _selectedBazaarFilter == BazaarFilter.all ||
            _selectedBazaarFilter == BazaarFilter.crafts;

        final hasMarkets = showMarkets && _bazaars.isNotEmpty;
        final hasCrafts = showCrafts && _crafts.isNotEmpty;

        if (!hasMarkets && !hasCrafts) {
          return _buildEmptyState(
            icon: Icons.storefront_outlined,
            message: 'No markets or crafts found matching "$_searchQuery"',
          );
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            if (hasMarkets) ...[
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.store_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Traditional Bazaars & Commercial Markets',
                      style: AppTextStyles.title,
                    ),
                  ],
                ),
              ),
              ..._bazaars.map(
                (market) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: BazaarMarketCard(market: market),
                ),
              ),
            ],
            if (hasCrafts) ...[
              Padding(
                padding: EdgeInsets.only(top: hasMarkets ? 16 : 4, bottom: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.palette_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Traditional Crafts & Regional Specialties',
                      style: AppTextStyles.title,
                    ),
                  ],
                ),
              ),
              ..._crafts.map(
                (craft) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: CraftSpecialtyCard(craft: craft),
                ),
              ),
            ],
          ],
        );

      case DiscoverCategory.guides:
        if (_guides.isEmpty) {
          return _buildEmptyState(
            icon: Icons.person_search_outlined,
            message: 'No guides found matching "$_searchQuery"',
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          itemCount: _guides.length,
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) => GuideCard(guide: _guides[index]),
        );

      case DiscoverCategory.tanga:
        if (_tangaRides.isEmpty) {
          return _buildEmptyState(
            icon: Icons.emoji_transportation_outlined,
            message: 'No tanga ride providers found matching "$_searchQuery"',
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          itemCount: _tangaRides.length,
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) =>
              TangaRideCard(tanga: _tangaRides[index]),
        );
    }
  }

  Widget _buildEmptyState({required IconData icon, required String message}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: AppColors.textSecondary),
          const SizedBox(height: 12),
          Text(message, style: AppTextStyles.bodySecondary),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _clearSearch,
            child: const Text('Clear search'),
          ),
        ],
      ),
    );
  }
}
