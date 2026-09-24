import 'package:flutter/foundation.dart';

/// Simple coordinator for selecting a travel plan index and navigating to Plans tab across screens.
abstract final class PlansNavController {
  static final ValueNotifier<int> selectedPlanIndex = ValueNotifier<int>(0);
  static final ValueNotifier<int?> requestedTab = ValueNotifier<int?>(null);

  static void selectPlan(int index, {bool switchToTab = true}) {
    selectedPlanIndex.value = index;
    if (switchToTab) {
      requestedTab.value = 2; // Tab 2: Plans
    }
  }
}
