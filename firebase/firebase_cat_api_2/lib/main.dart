import 'package:firebase_cat_api_2/screens/bottam_nav_bar.dart';
import 'package:firebase_cat_api_2/screens/home_screen.dart';
import 'package:firebase_cat_api_2/screens/login_screen.dart';
import 'package:firebase_cat_api_2/screens/profile_screen.dart';
import 'package:firebase_cat_api_2/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(initialRoute: isLoggedIn ? '/home' : '/'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat API',
      home: MaterialApp.router(routerConfig: _router(initialRoute)),
    );
  }
}

GoRouter _router(String initialRoute) => GoRouter(
  initialLocation: initialRoute,
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child); // Wrap all child screens here
      },
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterScreen();
      },
    ),
  ],
);
