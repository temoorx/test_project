import 'package:flutter/material.dart';
import 'package:test_project/theme/app_colors.dart';

const List<DaySchedule> _initialDays = [
  DaySchedule(
    dayLabel: 'Mon',
    dayNumber: '8',
    workout: WorkoutSchedule(
      title: 'Arm Blaster',
      tag: 'Arms Workout',
      tagColor: Color(0xFF1F8F5C),
      duration: '25m - 30m',
    ),
  ),
  DaySchedule(dayLabel: 'Tue', dayNumber: '9'),
  DaySchedule(dayLabel: 'Wed', dayNumber: '10'),
  DaySchedule(
    dayLabel: 'Thu',
    dayNumber: '11',
    workout: WorkoutSchedule(
      title: 'Leg Day Blitz',
      tag: 'Leg Workout',
      tagColor: Color(0xFF4B59D9),
      duration: '25m - 30m',
    ),
  ),
  DaySchedule(dayLabel: 'Fri', dayNumber: '12'),
  DaySchedule(dayLabel: 'Sat', dayNumber: '13'),
  DaySchedule(dayLabel: 'Sun', dayNumber: '14'),
];

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late List<DaySchedule> _days = List<DaySchedule>.of(_initialDays);

  void _handleMoveWorkout(int fromIndex, int toIndex) {
    if (fromIndex == toIndex) {
      return;
    }
    final WorkoutSchedule? fromWorkout = _days[fromIndex].workout;
    if (fromWorkout == null) {
      return;
    }
    setState(() {
      final WorkoutSchedule? targetWorkout = _days[toIndex].workout;
      final List<DaySchedule> updated = List<DaySchedule>.of(_days);
      updated[fromIndex] = updated[fromIndex].copyWithWorkout(targetWorkout);
      updated[toIndex] = updated[toIndex].copyWithWorkout(fromWorkout);
      _days = updated;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                child: Row(
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
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: _WeekSummary(
                  title: 'Week 2/8',
                  subtitle: 'December 8-14',
                  total: 'Total: 60min',
                ),
              ),
              const SizedBox(height: 24),
              for (int index = 0; index < _days.length; index++) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _DayScheduleTile(
                    day: _days[index],
                    index: index,
                    onMoveWorkout: _handleMoveWorkout,
                  ),
                ),
                const SizedBox(height: 24),
              ],
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: _NextWeekSummary(
                  title: 'Week 2',
                  subtitle: 'December 14-22',
                  total: 'Total: 60min',
                ),
              ),
              const SizedBox(height: 32),
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

  DaySchedule copyWithWorkout(WorkoutSchedule? nextWorkout) {
    return DaySchedule(
      dayLabel: dayLabel,
      dayNumber: dayNumber,
      workout: nextWorkout,
    );
  }
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

class _WorkoutDragData {
  const _WorkoutDragData({required this.sourceIndex, required this.workout});

  final int sourceIndex;
  final WorkoutSchedule workout;
}

class _DayScheduleTile extends StatelessWidget {
  const _DayScheduleTile({
    required this.day,
    required this.index,
    required this.onMoveWorkout,
  });

  final DaySchedule day;
  final int index;
  final void Function(int fromIndex, int toIndex) onMoveWorkout;

  @override
  Widget build(BuildContext context) {
    final hasWorkout = day.workout != null;
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
          child: DragTarget<_WorkoutDragData>(
            onWillAcceptWithDetails: (details) =>
                details.data.sourceIndex != index,
            onAcceptWithDetails: (details) =>
                onMoveWorkout(details.data.sourceIndex, index),
            builder: (context, candidateData, rejectedData) {
              final bool isReceiving = candidateData.isNotEmpty;
              final EdgeInsets padding = hasWorkout && isReceiving
                  ? const EdgeInsets.all(4)
                  : EdgeInsets.zero;
              final BoxDecoration? decoration = hasWorkout && isReceiving
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: AppColors.accent, width: 1.5),
                    )
                  : null;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                curve: Curves.easeInOut,
                padding: padding,
                decoration: decoration,
                child: hasWorkout
                    ? _DraggableWorkoutCard(index: index, workout: day.workout!)
                    : _EmptyWorkoutSlot(isHighlighted: isReceiving),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DraggableWorkoutCard extends StatelessWidget {
  const _DraggableWorkoutCard({required this.workout, required this.index});

  final WorkoutSchedule workout;
  final int index;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<_WorkoutDragData>(
      data: _WorkoutDragData(sourceIndex: index, workout: workout),
      dragAnchorStrategy: childDragAnchorStrategy,
      feedback: _WorkoutDragPreview(workout: workout),
      childWhenDragging: Opacity(
        opacity: 0.35,
        child: _WorkoutCard(workout: workout),
      ),
      child: _WorkoutCard(workout: workout),
    );
  }
}

class _WorkoutDragPreview extends StatelessWidget {
  const _WorkoutDragPreview({required this.workout});

  final WorkoutSchedule workout;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 8,
      borderRadius: BorderRadius.circular(24),
      child: IgnorePointer(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 220, maxWidth: 320),
          child: SizedBox(width: 260, child: _WorkoutCard(workout: workout)),
        ),
      ),
    );
  }
}

class _EmptyWorkoutSlot extends StatelessWidget {
  const _EmptyWorkoutSlot({required this.isHighlighted});

  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isHighlighted
        ? AppColors.accent
        : AppColors.surfaceVariant;
    final Color backgroundColor = isHighlighted
        ? AppColors.surface
        : AppColors.background;
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 1.4),
      ),
      alignment: Alignment.center,
      child: Text(
        'Drag workout here',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
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
          top: 0,
          bottom: 0,
          child: Container(
            width: 12,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
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
