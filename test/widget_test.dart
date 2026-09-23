import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vijayapura_tourism/core/theme/app_theme.dart';
import 'package:vijayapura_tourism/features/auth/presentation/screens/sign_in_screen.dart';

void main() {
  testWidgets('Vijayapura Tourism app starts with sign in screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light(), home: const SignInScreen()),
    );

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
