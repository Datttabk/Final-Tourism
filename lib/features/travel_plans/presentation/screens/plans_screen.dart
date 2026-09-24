import 'package:flutter/material.dart';

import '../../../../core/localization/l10n_extensions.dart';
import '../../../../core/services/plans_nav_controller.dart';
import '../../../../core/services/user_activity_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/url_launcher_helper.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../explore/domain/models/place.dart';
import '../../../explore/presentation/screens/place_detail_screen.dart';
import '../../data/repositories/local_travel_plans_repository.dart';
import '../../domain/models/travel_plan.dart';
import '../../domain/repositories/travel_plans_repository.dart';

class PlansScreen extends StatefulWidget {
  final int initialPlanIndex;

  const PlansScreen({super.key, this.initialPlanIndex = 0});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  final TravelPlansRepository _repository = LocalTravelPlansRepository();
  List<TravelPlan> _plans = [];
  int _selectedPlanIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _selectedPlanIndex = widget.initialPlanIndex;
    PlansNavController.selectedPlanIndex.addListener(_onPlanNavChanged);
    _loadPlans();
  }

  @override
  void dispose() {
    PlansNavController.selectedPlanIndex.removeListener(_onPlanNavChanged);
    super.dispose();
  }

  void _onPlanNavChanged() {
    final newIndex = PlansNavController.selectedPlanIndex.value;
    if (mounted &&
        newIndex != _selectedPlanIndex &&
        newIndex >= 0 &&
        newIndex < _plans.length) {
      setState(() {
        _selectedPlanIndex = newIndex;
      });
    }
  }

  Future<void> _loadPlans() async {
    final plans = await _repository.getPlans();
    if (!mounted) return;
    setState(() {
      _plans = plans;
      if (_selectedPlanIndex >= plans.length) {
        _selectedPlanIndex = 0;
      }
      _isLoading = false;
    });
  }

  void _openPlaceDetail(Place place) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => PlaceDetailScreen(place: place)));
  }

  String _getPlanVariantLabel(TravelPlan plan, AppLocalizations l10n) {
    if (plan.id == '1-day') return l10n.oneDayPlan;
    if (plan.id == '2-day-1') return l10n.twoDayPlan1;
    if (plan.id == '2-day-2') return l10n.twoDayPlan2;
    if (plan.id == '3-day') return l10n.threeDayPlan;
    return plan.variantLabel;
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
            Text(l10n.travelPlansTitle, style: AppTextStyles.headline),
            Text(
              l10n.travelPlansSubtitle,
              style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
            ),
          ],
        ),
        actions: [
          if (_plans.isNotEmpty && _selectedPlanIndex < _plans.length)
            ListenableBuilder(
              listenable: UserActivityController.instance,
              builder: (context, _) {
                final currentPlan = _plans[_selectedPlanIndex];
                final isSaved = UserActivityController.instance.isPlanSaved(
                  currentPlan.id,
                );
                return IconButton(
                  tooltip: isSaved ? 'Remove Saved Plan' : 'Save Travel Plan',
                  icon: Icon(
                    isSaved
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color: isSaved ? AppColors.accentGold : AppColors.primary,
                  ),
                  onPressed: () async {
                    await UserActivityController.instance.togglePlanSaved(
                      currentPlan.id,
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isSaved
                                ? 'Removed "${currentPlan.title}" from Saved Plans.'
                                : 'Saved "${currentPlan.title}" to Saved Travel Plans.',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                );
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            )
          : _plans.isEmpty
          ? const Center(child: Text('No travel plans available.'))
          : Column(
              children: [
                // Segmented Plan Selector: [ 1 Day ] [ 2 Days I ] [ 2 Days II ] [ 3 Days ]
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: List.generate(_plans.length, (index) {
                        final isSelected = _selectedPlanIndex == index;
                        final plan = _plans[index];
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPlanIndex = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: AppColors.primary.withValues(
                                            alpha: 0.25,
                                          ),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Text(
                                _getPlanVariantLabel(plan, l10n),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textPrimary,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),

                // Active Plan Content
                Expanded(
                  child: _PlanDetailView(
                    plan: _plans[_selectedPlanIndex],
                    onPlaceTap: _openPlaceDetail,
                  ),
                ),
              ],
            ),
    );
  }
}

class _PlanDetailView extends StatelessWidget {
  final TravelPlan plan;
  final ValueChanged<Place> onPlaceTap;

  const _PlanDetailView({required this.plan, required this.onPlaceTap});

  void _launchGoogleMapsRoute() {
    final url = plan.qrNavigationUrl;
    if (url != null && url.isNotEmpty) {
      UrlLauncherHelper.openUrl(url);
    }
  }

  void _openFullscreenRouteImage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => _FullscreenRouteImageViewer(
          title: plan.title,
          assetPath: plan.routeReferenceAsset,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 36),
      children: [
        // 1. Plan Header Summary Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.title,
                          style: AppTextStyles.title.copyWith(fontSize: 20),
                        ),
                        if (plan.kannadaTitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            plan.kannadaTitle!,
                            style: AppTextStyles.label.copyWith(
                              fontSize: 14,
                              color: AppColors.accentGold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Text(
                      '${plan.durationDays} ${plan.durationDays == 1 ? "DAY" : "DAYS"}',
                      style: AppTextStyles.label.copyWith(
                        fontSize: 11,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                plan.tagline,
                style: AppTextStyles.bodySecondary.copyWith(fontSize: 13),
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 14),

              // Metrics Grid: Duration, Stops, Start Time, Distance
              Row(
                children: [
                  Expanded(
                    child: _MetricItem(
                      icon: Icons.calendar_today_outlined,
                      label: 'Duration',
                      value: plan.formattedDuration,
                    ),
                  ),
                  Container(height: 36, width: 1, color: AppColors.border),
                  Expanded(
                    child: _MetricItem(
                      icon: Icons.pin_drop_outlined,
                      label: 'Total Stops',
                      value: '${plan.totalStopsCount} Monuments',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _MetricItem(
                      icon: Icons.wb_sunny_outlined,
                      label: 'Start Time',
                      value: plan.recommendedStartHour,
                    ),
                  ),
                  Container(height: 36, width: 1, color: AppColors.border),
                  Expanded(
                    child: _MetricItem(
                      icon: Icons.straighten_outlined,
                      label: 'Distance',
                      value: plan.formattedTotalDistance,
                      isPending: plan.totalDistanceKm == null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 2. Navigation Action: Open Route in Google Maps
        if (plan.qrNavigationUrl != null)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.28),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.directions_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Verified Route Navigation',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Decoded from official route-map QR code',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _launchGoogleMapsRoute,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryDark,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Open Route',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 24),

        // 3. Dedicated Route Reference Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Route Map Reference', style: AppTextStyles.title),
                Text(
                  'Official route-map supplied by Vijayapura Tourism',
                  style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                ),
              ],
            ),
            TextButton.icon(
              onPressed: () => _openFullscreenRouteImage(context),
              icon: const Icon(Icons.fullscreen, size: 18),
              label: const Text(
                'Expand',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Route Reference Image Box with InteractiveViewer
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(
                child: InteractiveViewer(
                  key: ValueKey(plan.routeReferenceAsset),
                  minScale: 1.0,
                  maxScale: 4.0,
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                    child: Image.asset(
                      plan.routeReferenceAsset,
                      key: ValueKey('img_${plan.routeReferenceAsset}'),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.broken_image_outlined,
                                color: Colors.white54,
                                size: 36,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Route reference image unavailable',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Floating hint overlay
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.pinch, size: 13, color: Colors.white70),
                      SizedBox(width: 4),
                      Text(
                        'Pinch to zoom • Tap Expand for full view',
                        style: TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // 4. Sequential Route Overview Visualizer Boundary
        const Text('Sequential Route Overview', style: AppTextStyles.title),
        const SizedBox(height: 4),
        Text(
          'Structured stop sequence • Map provider integration boundary',
          style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 10),
        _RouteSequenceOverviewCard(plan: plan, onPlaceTap: onPlaceTap),

        const SizedBox(height: 28),

        // 5. Day-by-Day Itinerary Stops
        Row(
          children: [
            const Text('Detailed Itinerary', style: AppTextStyles.title),
            const Spacer(),
            Text(
              '${plan.totalStopsCount} Curated Stops',
              style: AppTextStyles.bodySecondary.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        ...plan.days.map(
          (day) => _DaySection(day: day, onPlaceTap: onPlaceTap),
        ),
      ],
    );
  }
}

class _FullscreenRouteImageViewer extends StatelessWidget {
  final String title;
  final String assetPath;

  const _FullscreenRouteImageViewer({
    required this.title,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    final TransformationController controller = TransformationController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.8),
        foregroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        actions: [
          IconButton(
            tooltip: 'Reset Zoom',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              controller.value = Matrix4.identity();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          InteractiveViewer(
            transformationController: controller,
            minScale: 0.8,
            maxScale: 6.0,
            boundaryMargin: const EdgeInsets.all(60),
            child: Center(
              child: Image.asset(
                assetPath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'Unable to load route reference',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Pinch or drag to inspect streets and monuments',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteSequenceOverviewCard extends StatelessWidget {
  final TravelPlan plan;
  final ValueChanged<Place> onPlaceTap;

  const _RouteSequenceOverviewCard({
    required this.plan,
    required this.onPlaceTap,
  });

  @override
  Widget build(BuildContext context) {
    final allStops = [for (final day in plan.days) ...day.stops];
    final firstStop = allStops.isNotEmpty ? allStops.first : null;
    final lastStop = allStops.length > 1 ? allStops.last : null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Origin to Destination overview line
          if (firstStop != null && lastStop != null) ...[
            Row(
              children: [
                const Icon(
                  Icons.trip_origin_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Start: ${firstStop.place.name}',
                    style: AppTextStyles.label.copyWith(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.location_on_rounded,
                  size: 16,
                  color: AppColors.accentGold,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'End: ${lastStop.place.name}',
                    style: AppTextStyles.label.copyWith(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
          ],

          // Horizontal Sequence flow chip list
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: allStops.length,
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Center(
                  child: Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: AppColors.textSecondary.withValues(alpha: 0.6),
                  ),
                ),
              ),
              itemBuilder: (context, index) {
                final stop = allStops[index];
                return InkWell(
                  onTap: () => onPlaceTap(stop.place),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
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
                        Container(
                          width: 18,
                          height: 18,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${stop.stopOrder}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          stop.place.name,
                          style: AppTextStyles.label.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Curated Sequence Ready • Real map renderer will integrate here',
                style: AppTextStyles.bodySecondary.copyWith(fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isPending;

  const _MetricItem({
    required this.icon,
    required this.label,
    required this.value,
    this.isPending = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.label.copyWith(
            fontSize: 12,
            color: isPending ? AppColors.textSecondary : AppColors.textPrimary,
            fontStyle: isPending ? FontStyle.italic : FontStyle.normal,
          ),
        ),
        Text(label, style: AppTextStyles.bodySecondary.copyWith(fontSize: 10)),
      ],
    );
  }
}

class _DaySection extends StatelessWidget {
  final PlanDay day;
  final ValueChanged<Place> onPlaceTap;

  const _DaySection({required this.day, required this.onPlaceTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Day Header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'DAY ${day.dayNumber}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day.dayTitle,
                      style: AppTextStyles.title.copyWith(fontSize: 15),
                    ),
                    if (day.kannadaTitle != null)
                      Text(
                        day.kannadaTitle!,
                        style: AppTextStyles.bodySecondary.copyWith(
                          fontSize: 11,
                          color: AppColors.accentGold,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          day.summary,
          style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 14),

        // Ordered Stops List
        ...day.stops.map(
          (stop) => _StopCard(stop: stop, onPlaceTap: onPlaceTap),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _StopCard extends StatelessWidget {
  final PlanStop stop;
  final ValueChanged<Place> onPlaceTap;

  const _StopCard({required this.stop, required this.onPlaceTap});

  @override
  Widget build(BuildContext context) {
    final leg = stop.legFromPreviousStop;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Route Leg connector from previous stop
        if (leg != null)
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 4, bottom: 4),
            child: Row(
              children: [
                Container(
                  width: 2,
                  height: 36,
                  color: AppColors.accentGold.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.directions_car,
                          size: 13,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            leg.distanceKm != null
                                ? 'Route leg: ${leg.formattedDistance} (~${leg.formattedDuration})'
                                : 'Route leg: ${leg.originTitle} → ${leg.destinationTitle}',
                            style: AppTextStyles.bodySecondary.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Stop Card
        Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.border),
          ),
          child: InkWell(
            onTap: () => onPlaceTap(stop.place),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stop Number Badge
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${stop.stopOrder}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Stop Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                stop.place.name,
                                style: AppTextStyles.title.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              size: 13,
                              color: AppColors.accentGold,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              stop.recommendedTimeSlot,
                              style: AppTextStyles.label.copyWith(
                                fontSize: 11,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            if (stop.visitDuration != null) ...[
                              const SizedBox(width: 8),
                              Container(
                                width: 3,
                                height: 3,
                                decoration: const BoxDecoration(
                                  color: AppColors.textSecondary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                stop.visitDuration!,
                                style: AppTextStyles.bodySecondary.copyWith(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          stop.stopNotes,
                          style: AppTextStyles.bodySecondary.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Action pill: Tap to view monument details
                        Row(
                          children: [
                            Text(
                              'Canonical Place Detail',
                              style: AppTextStyles.label.copyWith(
                                fontSize: 11,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.open_in_new_rounded,
                              size: 12,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AppNetworkImage(
                      imageUrl: stop.place.imageUrl,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
