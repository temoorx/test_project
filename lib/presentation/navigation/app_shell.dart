import 'package:flutter/material.dart';
import 'package:test_project/presentation/home/home_screen.dart';
import 'package:test_project/presentation/mood/mood_screen.dart';
import 'package:test_project/presentation/plan/plan_screen.dart';
import 'package:test_project/presentation/profile/profile_screen.dart';
import 'package:test_project/presentation/widgets/app_bottom_nav.dart';
import 'package:test_project/theme/app_colors.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _currentIndex;
  late final List<Widget> _tabs = const [
    HomeScreen(key: PageStorageKey('home')),
    PlanScreen(key: PageStorageKey('plan')),
    MoodScreen(key: PageStorageKey('mood')),
    ProfileScreen(key: PageStorageKey('profile')),
  ];
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    final initial = widget.initialIndex;
    if (initial >= 0 && initial < _tabs.length) {
      _currentIndex = initial;
    } else {
      _currentIndex = 0;
    }
  }

  void _handleSelect(int index) {
    if (index == _currentIndex) {
      return;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      body: PageStorage(
        bucket: _bucket,
        child: IndexedStack(index: _currentIndex, children: _tabs),
      ),
      bottomNavigationBar: AppBottomNav(
        activeIndex: _currentIndex,
        onItemSelected: _handleSelect,
      ),
    );
  }
}
