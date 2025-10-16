import 'package:flutter/material.dart';
import 'package:test_project/theme/app_colors.dart';

import '../navigation/app_routes.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.activeIndex});

  final int activeIndex;

  static final List<_NavItem> _items = [
    _NavItem(
      icon: Icons.local_dining_outlined,
      label: 'Nutrition',
      route: AppRoutes.home,
    ),
    _NavItem(
      icon: Icons.calendar_today_outlined,
      label: 'Plan',
      route: AppRoutes.plan,
    ),
    _NavItem(
      icon: Icons.emoji_emotions_outlined,
      label: 'Mood',
      route: AppRoutes.mood,
    ),
    _NavItem(
      icon: Icons.person_outline,
      label: 'Profile',
      route: AppRoutes.profile,
    ),
  ];

  void _onTap(BuildContext context, int index) {
    if (index == activeIndex) {
      return;
    }
    final route = _items[index].route;
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 120,
          height: 4,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Row(
            children: [
              for (int i = 0; i < _items.length; i++)
                Expanded(
                  child: _BottomNavItem(
                    data: _items[i],
                    isActive: i == activeIndex,
                    onTap: () => _onTap(context, i),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.data,
    required this.isActive,
    required this.onTap,
  });

  final _NavItem data;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isActive
        ? AppColors.accent
        : AppColors.textSecondary;
    final Color textColor = isActive
        ? AppColors.textPrimary
        : AppColors.textSecondary;
    final FontWeight weight = isActive ? FontWeight.w700 : FontWeight.w500;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(data.icon, color: iconColor, size: 24),
          const SizedBox(height: 6),
          Text(
            data.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: weight,
              color: textColor,
            ),
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 8),
              height: 4,
              width: 26,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
        ],
      ),
    );
  }
}
