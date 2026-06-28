
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../features/auth/login_screen.dart';
import '../shared/models/user_model.dart';

class AppRouter {
  static GoRouter router(UserModel? user) {
    return GoRouter(
      initialLocation: '/login',
      redirect: (context, state) {
        final loggedIn = FirebaseAuth.instance.currentUser != null;
        final onLogin = state.matchedLocation == '/login';

        if (!loggedIn && !onLogin) return '/login';
        if (loggedIn && onLogin) return _homeForRole(user?.role);
        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          builder: (_, __) => const LoginScreen(),
        ),
      ],
    );
  }

  static String _homeForRole(String? role) {
    switch (role) {
      case 'admin':
        return '/admin';
      case 'maintenance':
        return '/maintenance';
      case 'security':
        return '/security';
      default:
        return '/my-complaints';
    }
  }
}