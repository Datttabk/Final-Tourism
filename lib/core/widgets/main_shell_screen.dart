import 'package:flutter/material.dart';

import '../../features/discover/presentation/screens/discover_screen.dart';
import '../../features/explore/presentation/screens/explore_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/safety/presentation/screens/safety_screen.dart';
import '../../features/travel_plans/presentation/screens/plans_screen.dart';
import '../localization/l10n_extensions.dart';
import '../services/plans_nav_controller.dart';

/// Scope to allow deep tab switching from within children (e.g. Home quick categories)
class MainShellScope extends InheritedWidget {
  final int currentIndex;
  final void Function(int index) switchTab;

  const MainShellScope({
    super.key,
    required this.currentIndex,
    required this.switchTab,
    required super.child,
  });

  static MainShellScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<MainShellScope>();
    assert(scope != null, 'No MainShellScope found in context');
    return scope!;
  }

  static MainShellScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MainShellScope>();
  }

  @override
  bool updateShouldNotify(MainShellScope oldWidget) =>
      currentIndex != oldWidget.currentIndex;
}

class MainShellScreen extends StatefulWidget {
  final int initialIndex;

  const MainShellScreen({super.key, this.initialIndex = 0});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  late int _currentIndex;

  final List<Widget> _screens = const [
    HomeScreen(),
    ExploreScreen(),
    PlansScreen(),
    DiscoverScreen(),
    SafetyScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    PlansNavController.requestedTab.addListener(_onRequestedTabChanged);
  }

  @override
  void dispose() {
    PlansNavController.requestedTab.removeListener(_onRequestedTabChanged);
    super.dispose();
  }

  void _onRequestedTabChanged() {
    final tab = PlansNavController.requestedTab.value;
    if (tab != null && mounted) {
      setState(() {
        _currentIndex = tab;
      });
      PlansNavController.requestedTab.value = null;
    }
  }

  void _onTabSelected(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return MainShellScope(
      currentIndex: _currentIndex,
      switchTab: _onTabSelected,
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: _onTabSelected,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home_rounded),
              label: l10n.navHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.explore_outlined),
              selectedIcon: const Icon(Icons.explore_rounded),
              label: l10n.navExplore,
            ),
            NavigationDestination(
              icon: const Icon(Icons.route_outlined),
              selectedIcon: const Icon(Icons.route_rounded),
              label: l10n.navPlans,
            ),
            NavigationDestination(
              icon: const Icon(Icons.storefront_outlined),
              selectedIcon: const Icon(Icons.storefront_rounded),
              label: l10n.navDiscover,
            ),
            NavigationDestination(
              icon: const Icon(Icons.shield_outlined),
              selectedIcon: const Icon(Icons.shield_rounded),
              label: l10n.navSafety,
            ),
          ],
        ),
      ),
    );
  }
}
