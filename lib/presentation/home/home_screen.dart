import 'package:flutter/material.dart';
import 'package:test_project/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: _HomeBody()),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeaderRow(),
          const SizedBox(height: 26),
          Text('Today, 22 Dec 2024', style: textTheme.titleLarge),
          const SizedBox(height: 16),
          const _DatePager(),
          const SizedBox(height: 30),
          const _SectionTitle(label: 'Workouts', trailing: _WeatherChip()),
          const SizedBox(height: 16),
          const _WorkoutCard(),
          const SizedBox(height: 30),
          const _SectionTitle(label: 'My Insights'),
          const SizedBox(height: 18),
          const _InsightsRow(),
          const SizedBox(height: 18),
          const _HydrationCard(),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.notifications_none_outlined,
          size: 26,
          color: AppColors.textPrimary,
        ),
        Spacer(),
        _WeekSelector(),
        Spacer(),
      ],
    );
  }
}

class _WeekSelector extends StatelessWidget {
  const _WeekSelector();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.access_time, size: 18, color: AppColors.primary),
        SizedBox(width: 8),
        Text(
          'Week 1/4',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(width: 6),
        Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 20,
          color: AppColors.textSecondary,
        ),
      ],
    );
  }
}

class _DatePager extends StatelessWidget {
  const _DatePager();

  static const List<_DateItem> items = [
    _DateItem(label: 'M', day: '21'),
    _DateItem(label: 'TU', day: '22', isSelected: true, hasIndicator: true),
    _DateItem(label: 'W', day: '23'),
    _DateItem(label: 'TH', day: '24', hasBar: true),
    _DateItem(label: 'F', day: '25'),
    _DateItem(label: 'SA', day: '26'),
    _DateItem(label: 'SU', day: '27'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _DatePill(item: items[index]),
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: items.length,
      ),
    );
  }
}

class _DateItem {
  const _DateItem({
    required this.label,
    required this.day,
    this.isSelected = false,
    this.hasIndicator = false,
    this.hasBar = false,
  });

  final String label;
  final String day;
  final bool isSelected;
  final bool hasIndicator;
  final bool hasBar;
}

class _DatePill extends StatelessWidget {
  const _DatePill({required this.item});

  final _DateItem item;

  @override
  Widget build(BuildContext context) {
    final Color circleColor = item.isSelected
        ? AppColors.background
        : AppColors.surface;
    final Color borderColor = item.isSelected
        ? AppColors.primary
        : Colors.transparent;
    final Color textColor = item.isSelected
        ? AppColors.textPrimary
        : AppColors.textSecondary;
    return SizedBox(
      width: 56,
      child: Column(
        children: [
          Text(
            item.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
              border: Border.all(color: borderColor, width: 3),
            ),
            alignment: Alignment.center,
            child: Text(
              item.day,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (item.hasIndicator)
            Container(
              height: 8,
              width: 8,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            )
          else if (item.hasBar)
            Container(
              height: 4,
              width: 28,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
            )
          else
            const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label, this.trailing});

  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    return Row(
      children: [
        Text(label, style: textStyle),
        const Spacer(),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _WeatherChip extends StatelessWidget {
  const _WeatherChip();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.wb_sunny_outlined, size: 20, color: AppColors.accent),
        SizedBox(width: 6),
        Text(
          '9\u00B0',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.fromLTRB(32, 22, 22, 22),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'December 22 - 25m - 30m',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Upper Body',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 10,
              // margin: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InsightsRow extends StatelessWidget {
  const _InsightsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _InsightCard(
            value: '550',
            unit: 'Calories',
            subtitle: '1950 Remaining',
            progress: 0.22,
            minLabel: '0',
            maxLabel: '2500',
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _WeightCard(value: '75', unit: 'kg', delta: '+1.6kg'),
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({
    required this.value,
    required this.unit,
    required this.subtitle,
    required this.progress,
    required this.minLabel,
    required this.maxLabel,
  });

  final String value;
  final String unit;
  final String subtitle;
  final double progress;
  final String minLabel;
  final String maxLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            unit,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 22),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 6,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.surfaceVariant,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                minLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Text(
                maxLabel,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeightCard extends StatelessWidget {
  const _WeightCard({
    required this.value,
    required this.unit,
    required this.delta,
  });

  final String value;
  final String unit;
  final String delta;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: AppColors.positive.withOpacity(0.18),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_upward_rounded,
                  size: 14,
                  color: AppColors.positive,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                delta,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.positive,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                unit,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Weight',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _HydrationCard extends StatelessWidget {
  const _HydrationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '0%',
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Hydration',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Log Now',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          const _HydrationScale(),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.16),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              '500 ml added to water log',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HydrationScale extends StatelessWidget {
  const _HydrationScale();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '2 L',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '1 L',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '0 L',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 18),
          Container(
            width: 10,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                final bool isActive = index == 5;
                return Container(
                  height: 10,
                  width: 4,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.accent : AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: const Text(
                '0ml',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
