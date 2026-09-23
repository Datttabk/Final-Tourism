import 'package:flutter/material.dart';

import '../../../../core/localization/l10n_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../explore/domain/models/place.dart';
import '../../../explore/domain/models/place_localizations.dart';

/// Horizontal hero carousel displaying the 4 major historical attractions
/// of Vijayapura in exact sequence:
/// 1. Gol Gumbaz
/// 2. Ibrahim Rauza
/// 3. Bara Kaman
/// 4. Basavanagudi
class FeaturedMonumentCarousel extends StatefulWidget {
  final List<Place> featuredPlaces;
  final ValueChanged<Place> onExploreDetails;

  const FeaturedMonumentCarousel({
    super.key,
    required this.featuredPlaces,
    required this.onExploreDetails,
  });

  @override
  State<FeaturedMonumentCarousel> createState() =>
      _FeaturedMonumentCarouselState();
}

class _FeaturedMonumentCarouselState extends State<FeaturedMonumentCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.featuredPlaces.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.featuredPlaces.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final place = widget.featuredPlaces[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _MonumentSlideCard(
                  place: place,
                  onTap: () => widget.onExploreDetails(place),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),

        // Page Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.featuredPlaces.length, (index) {
            final isSelected = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isSelected ? 22 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.border,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _MonumentSlideCard extends StatelessWidget {
  final Place place;
  final VoidCallback onTap;

  const _MonumentSlideCard({required this.place, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.maybeLocaleOf(context) ?? const Locale('en');
    final l10n = context.l10n;
    final localizedPlace = place.localized(locale);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Monument Image
            AppNetworkImage(
              imageUrl: localizedPlace.imageUrl,
              fit: BoxFit.cover,
            ),

            // Subtle bottom readability overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.35),
                    Colors.black.withValues(alpha: 0.85),
                  ],
                  stops: const [0.3, 0.65, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            // Text and Action Content
            Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    localizedPlace.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    localizedPlace.shortDescription,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 12,
                      height: 1.35,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Single Primary CTA
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryDark,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 9,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.homeExploreDetails,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward_rounded, size: 14),
                      ],
                    ),
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
