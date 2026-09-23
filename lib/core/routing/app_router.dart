import 'package:flutter/material.dart';

import '../../features/auth/presentation/screens/auth_gate_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/explore/domain/models/place.dart';
import '../../features/explore/presentation/screens/place_detail_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../widgets/main_shell_screen.dart';

abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const AuthGateScreen(),
          settings: settings,
        );

      case '/main':
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const MainShellScreen(),
          settings: settings,
        );

      case '/sign-in':
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
          settings: settings,
        );

      case '/sign-up':
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
          settings: settings,
        );

      case '/forgot-password':
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
          settings: settings,
        );

      case '/profile':
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );

      case '/place-detail':
        final place = settings.arguments as Place?;
        if (place == null) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Place details not found')),
            ),
            settings: settings,
          );
        }
        return MaterialPageRoute(
          builder: (_) => PlaceDetailScreen(place: place),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
          settings: settings,
        );
    }
  }
}
