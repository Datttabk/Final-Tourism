import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/main_shell_screen.dart';
import '../../../explore/data/repositories/local_places_repository.dart';
import '../../../explore/domain/models/place.dart';
import '../../../explore/presentation/screens/place_detail_screen.dart';
import '../widgets/featured_monument_carousel.dart';
import '../widgets/home_discover_preview.dart';
import '../widgets/home_header.dart';
import '../widgets/home_language_section.dart';
import '../widgets/home_plans_preview.dart';
import '../widgets/quick_explore_gateway.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalPlacesRepository _placesRepo = LocalPlacesRepository();
  List<Place> _featuredMonuments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFeaturedMonuments();
  }

  Future<void> _loadFeaturedMonuments() async {
    final places = await _placesRepo.getPlaces();
    final placeMap = {for (final p in places) p.id: p};

    // Exactly four attractions in requested carousel sequence:
    // 1. Gol Gumbaz
    // 2. Ibrahim Rauza
    // 3. Bara Kaman
    // 4. Basavana Bagewadi
    final ordered = <Place>[];
    const requestedIds = [
      'gol_gumbaz',
      'ibrahim_rauza',
      'bara_kaman',
      'basavana_bagewadi',
    ];

    for (final id in requestedIds) {
      if (placeMap.containsKey(id)) {
        ordered.add(placeMap[id]!);
      } else if (id == 'basavana_bagewadi' &&
          placeMap.containsKey('basavanagudi')) {
        ordered.add(placeMap['basavanagudi']!);
      }
    }

    if (!mounted) return;
    setState(() {
      _featuredMonuments = ordered;
      _isLoading = false;
    });
  }

  void _navigateToProfile() {
    Navigator.of(context).pushNamed('/profile');
  }

  void _openPlaceDetail(Place place) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => PlaceDetailScreen(place: place)));
  }

  void _switchToTab(int tabIndex) {
    final shellScope = MainShellScope.maybeOf(context);
    if (shellScope != null) {
      shellScope.switchTab(tabIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? displayName;
    try {
      displayName = FirebaseAuth.instance.currentUser?.displayName;
    } catch (_) {
      displayName = null;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              )
            : RefreshIndicator(
                onRefresh: _loadFeaturedMonuments,
                color: AppColors.primary,
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 32),
                  children: [
                    // 1. Personalized Header (Namaskara, [Name], Language Selector, Profile)
                    HomeHeader(
                      displayName: displayName,
                      onProfileTap: _navigateToProfile,
                    ),
                    const SizedBox(height: 10),

                    // 2. Featured Heritage Carousel (Exactly 4 attractions)
                    FeaturedMonumentCarousel(
                      featuredPlaces: _featuredMonuments,
                      onExploreDetails: _openPlaceDetail,
                    ),
                    const SizedBox(height: 22),

                    // 3. Quick Explore Gateway
                    QuickExploreGateway(
                      onExploreTap: () => _switchToTab(1), // Tab 1: Explore
                    ),
                    const SizedBox(height: 24),

                    // 4. Featured Travel Plans Preview
                    HomePlansPreview(
                      onViewAllTap: () => _switchToTab(2), // Tab 2: Plans
                    ),
                    const SizedBox(height: 24),

                    // 5. Discover Local Preview
                    HomeDiscoverPreview(
                      onDiscoverMoreTap: () =>
                          _switchToTab(3), // Tab 3: Discover
                    ),
                    const SizedBox(height: 24),

                    // 6. Language Selection Section (Replaces the old Travel Safely section)
                    const HomeLanguageSection(),
                  ],
                ),
              ),
      ),
    );
  }
}
