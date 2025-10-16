import 'package:flutter/material.dart';
import 'package:test_project/presentation/widgets/app_bottom_nav.dart';
import 'package:test_project/theme/app_colors.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Plan',
                  style: textTheme.headlineSmall?.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 12),
                Text(
                  'Planning view coming soon.',
                  style: textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(activeIndex: 1),
    );
  }
}
