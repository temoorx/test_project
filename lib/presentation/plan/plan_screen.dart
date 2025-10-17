import 'package:flutter/material.dart';
import 'package:test_project/theme/app_colors.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  static const _days = [
    const DaySchedule(
      dayLabel: 'Mon',
      dayNumber: '8',
      workout: const WorkoutSchedule(
        title: 'Arm Blaster',
        tag: 'Arms Workout',
        tagColor: Color(0xFF1F8F5C),
        duration: '25m - 30m',
      ),
    ),
    const DaySchedule(dayLabel: 'Tue', dayNumber: '9'),
    const DaySchedule(dayLabel: 'Wed', dayNumber: '10'),
    const DaySchedule(
      dayLabel: 'Thu',
      dayNumber: '11',
      workout: const WorkoutSchedule(
        title: 'Leg Day Blitz',
        tag: 'Leg Workout',
        tagColor: Color(0xFF4B59D9),
        duration: '25m - 30m',
      ),
    ),
    const DaySchedule(dayLabel: 'Fri', dayNumber: '12'),
    const DaySchedule(dayLabel: 'Sat', dayNumber: '13'),
    const DaySchedule(dayLabel: 'Sun', dayNumber: '14'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Training Calendar',
                    style: textTheme.headlineSmall?.copyWith(fontSize: 28),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              const _WeekSummary(
                title: 'Week 2/8',
                subtitle: 'December 8-14',
                total: 'Total: 60min',
              ),
              const SizedBox(height: 24),
              for (final day in _days) ...[
                _DayScheduleTile(day: day),
                const SizedBox(height: 24),
              ],
              const SizedBox(height: 12),
              const _NextWeekSummary(
                title: 'Week 2',
                subtitle: 'December 14-22',
                total: 'Total: 60min',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DaySchedule {
  const DaySchedule({
    required this.dayLabel,
    required this.dayNumber,
    this.workout,
  });

  final String dayLabel;
  final String dayNumber;
  final WorkoutSchedule? workout;
}

class WorkoutSchedule {
  const WorkoutSchedule({
    required this.title,
    required this.tag,
    required this.tagColor,
    required this.duration,
  });

  final String title;
  final String tag;
  final Color tagColor;
  final String duration;
}

class _WeekSummary extends StatelessWidget {
  const _WeekSummary({
    required this.title,
    required this.subtitle,
    required this.total,
  });

  final String title;
  final String subtitle;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          const Spacer(),
          Text(
            total,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _DayScheduleTile extends StatelessWidget {
  const _DayScheduleTile({required this.day});

  final DaySchedule day;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day.dayLabel,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 6),
            Text(
              day.dayNumber,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 24),
            ),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: day.workout == null
              ? Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: AppColors.surfaceVariant,
                  ),
                )
              : _WorkoutCard(workout: day.workout!),
        ),
      ],
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  const _WorkoutCard({required this.workout});

  final WorkoutSchedule workout;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.fromLTRB(24, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.drag_indicator,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: workout.tagColor.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      workout.tag,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: workout.tagColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      workout.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    workout.duration,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 12,
          bottom: 12,
          child: Container(
            width: 12,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

class _NextWeekSummary extends StatelessWidget {
  const _NextWeekSummary({
    required this.title,
    required this.subtitle,
    required this.total,
  });

  final String title;
  final String subtitle;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withOpacity(0.4), width: 2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          const Spacer(),
          Text(
            total,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
