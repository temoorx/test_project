import 'package:flutter/material.dart';
import 'presentation/home/home_screen.dart';
import 'presentation/mood/mood_screen.dart';
import 'presentation/navigation/app_routes.dart';
import 'presentation/plan/plan_screen.dart';
import 'presentation/profile/profile_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.plan: (_) => const PlanScreen(),
        AppRoutes.mood: (_) => const MoodScreen(),
        AppRoutes.profile: (_) => const ProfileScreen(),
      },
    );
  }
}
