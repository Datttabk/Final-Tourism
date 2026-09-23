import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vijayapura_tourism/core/theme/app_theme.dart';
import 'package:vijayapura_tourism/features/travel_plans/presentation/screens/plans_screen.dart';

void main() {
  testWidgets('PlansScreen renders 4 plan selector tabs and switches plans', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(800, 3000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const PlansScreen()),
    );

    // Initial load
    await tester.pumpAndSettle();

    // Verify Title and Subtitle
    expect(find.text('Travel Plans'), findsOneWidget);

    // Verify 4 segmented tabs
    expect(find.text('1 Day'), findsOneWidget);
    expect(find.text('2 Days I'), findsOneWidget);
    expect(find.text('2 Days II'), findsOneWidget);
    expect(find.text('3 Days'), findsOneWidget);

    // Verify 1-Day Plan content is visible initially
    expect(find.text('One Day Trip to Vijayapur'), findsOneWidget);
    expect(find.text('ಒಂದು ದಿನದ ಪ್ರವಾಸ'), findsWidgets);
    expect(find.text('DAY 1'), findsOneWidget);
    expect(find.text('Gol Gumbaz'), findsWidgets);
    expect(find.text('Shivgiri'), findsWidgets);

    // Switch to 2 Days I
    await tester.tap(find.text('2 Days I'));
    await tester.pumpAndSettle();

    expect(find.text('Two Days Trip to Vijayapur (Plan I)'), findsOneWidget);
    expect(find.text('DAY 1'), findsOneWidget);
    expect(find.text('DAY 2'), findsOneWidget);
    expect(find.text('Jal Mahal'), findsWidgets);
    expect(find.text('Jod Gumbaz'), findsWidgets);

    // Switch to 2 Days II
    await tester.tap(find.text('2 Days II'));
    await tester.pumpAndSettle();

    expect(find.text('Two Days Trip to Vijayapur (Plan II)'), findsOneWidget);
    expect(find.text('Upli Burj'), findsWidgets);
    expect(find.text('Malik-e-Maidan'), findsWidgets);

    // Switch to 3 Days
    await tester.tap(find.text('3 Days'));
    await tester.pumpAndSettle();

    expect(find.text('Three Days Trip to Vijayapur'), findsOneWidget);
    expect(find.text('DAY 1'), findsOneWidget);

    // Scroll to verify DAY 3 in the 16-stop itinerary
    await tester.scrollUntilVisible(
      find.text('DAY 3'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('DAY 3'), findsOneWidget);
    expect(find.text('Kumatagi'), findsWidgets);
  });

  testWidgets('PlansScreen opens Google Maps modal on tapping Open Route', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const PlansScreen()),
    );

    await tester.pumpAndSettle();

    final openRouteButton = find.text('Open Route');
    expect(openRouteButton, findsOneWidget);

    await tester.tap(openRouteButton);
    await tester.pumpAndSettle();

    // Verify bottom sheet modal opened
    expect(find.text('Google Maps Route'), findsOneWidget);
    expect(find.text('Verified QR Destination'), findsOneWidget);
    expect(find.text('Copy Route Link'), findsOneWidget);
  });
}
