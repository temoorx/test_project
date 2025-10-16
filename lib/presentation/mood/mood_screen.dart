import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:test_project/presentation/widgets/app_bottom_nav.dart';
import 'package:test_project/theme/app_colors.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  late final List<_MoodOption> _moods = const [
    _MoodOption(label: 'Euphoric', color: Color(0xFFFF9F7B)),
    _MoodOption(label: 'Joyful', color: Color(0xFFFFC27C)),
    _MoodOption(label: 'Calm', color: Color(0xFF7ADFCF)),
    _MoodOption(label: 'Focused', color: Color(0xFF5EC7DF)),
    _MoodOption(label: 'Inspired', color: Color(0xFF9A8BFF)),
    _MoodOption(label: 'Grateful', color: Color(0xFFF884C9)),
  ];

  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final selectedMood = _moods[_selectedIndex];
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Container(
          //   width: double.infinity,
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [Color(0xFF1A2A4A), Color(0xFF0D141F)],
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //     ),
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(36),
          //       bottomRight: Radius.circular(36),
          //     ),
          //   ),
          //   padding: const EdgeInsets.fromLTRB(24, 16, 24, 60),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       SizedBox(height: MediaQuery.of(context).padding.top),
          //       Text(
          //         'Mood',
          //         style: textTheme.headlineSmall?.copyWith(fontSize: 32),
          //       ),
          //       const SizedBox(height: 12),
          //       Text(
          //         'Start your day',
          //         style: textTheme.bodyMedium?.copyWith(
          //           color: AppColors.textSecondary,
          //         ),
          //       ),
          //       const SizedBox(height: 8),
          //       Text(
          //         'How are you feeling at the Moment?',
          //         style: textTheme.titleLarge?.copyWith(fontSize: 22),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(height: MediaQuery.of(context).padding.top + 100),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                children: [
                  Transform.translate(
                    offset: const Offset(0, -72),
                    child: _MoodWheel(
                      moods: _moods,
                      initialIndex: _selectedIndex,
                      onChanged: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    selectedMood.label,
                    style: textTheme.titleLarge?.copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.background,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Continue',
                        style: textTheme.titleMedium?.copyWith(
                          color: AppColors.background,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(activeIndex: 2),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          '9:41',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Spacer(),
        Icon(Icons.signal_cellular_alt, size: 18, color: Colors.white),
        SizedBox(width: 6),
        Icon(Icons.wifi, size: 18, color: Colors.white),
        SizedBox(width: 6),
        Icon(Icons.battery_full, size: 20, color: Colors.white),
      ],
    );
  }
}

class _MoodWheel extends StatefulWidget {
  const _MoodWheel({
    required this.moods,
    required this.initialIndex,
    required this.onChanged,
  });

  final List<_MoodOption> moods;
  final int initialIndex;
  final ValueChanged<int> onChanged;

  @override
  State<_MoodWheel> createState() => _MoodWheelState();
}

class _MoodWheelState extends State<_MoodWheel> {
  static const double _size = 280;
  static const double _ringWidth = 42;
  late int _selectedIndex = widget.initialIndex;

  double get _anglePerSegment => (2 * math.pi) / widget.moods.length;

  void _setIndex(int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
    widget.onChanged(index);
  }

  void _handleOffset(Offset position) {
    final center = Offset(_size / 2, _size / 2);
    final vector = position - center;
    final distance = vector.distance;
    final radius = _size / 2;
    if (distance < radius - _ringWidth) {
      return;
    }
    double angle = math.atan2(vector.dy, vector.dx);
    angle += math.pi / 2;
    if (angle < 0) {
      angle += 2 * math.pi;
    }
    final rawIndex = (angle / _anglePerSegment).round() % widget.moods.length;
    _setIndex(rawIndex);
  }

  @override
  Widget build(BuildContext context) {
    final colors = widget.moods.map((mood) => mood.color).toList();
    final radius = _size / 2;
    final pointerRadius = radius - (_ringWidth / 2);
    final pointerAngle = (-math.pi / 2) + (_selectedIndex * _anglePerSegment);
    final pointerSize = 50.0;
    final pointerCenter = Offset(
      radius + pointerRadius * math.cos(pointerAngle),
      radius + pointerRadius * math.sin(pointerAngle),
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) => _handleOffset(details.localPosition),
      onPanUpdate: (details) => _handleOffset(details.localPosition),
      onTapDown: (details) => _handleOffset(details.localPosition),
      child: SizedBox(
        width: _size,
        height: _size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              size: Size(_size, _size),
              painter: _MoodWheelPainter(
                colors: colors,
                ringWidth: _ringWidth,
                segments: widget.moods.length,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: _size - (_ringWidth * 2.2),
                height: _size - (_ringWidth * 2.2),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const _MoodFace(),
              ),
            ),
            Positioned(
              left: pointerCenter.dx - (pointerSize / 2),
              top: pointerCenter.dy - (pointerSize / 2),
              child: Container(
                width: pointerSize,
                height: pointerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.4),
                      blurRadius: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoodWheelPainter extends CustomPainter {
  const _MoodWheelPainter({
    required this.colors,
    required this.ringWidth,
    required this.segments,
  });

  final List<Color> colors;
  final double ringWidth;
  final int segments;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final shaderColors = <Color>[...colors, colors.first];
    final stops = List.generate(
      shaderColors.length,
      (index) => index / (shaderColors.length - 1),
    );
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: shaderColors,
        stops: stops,
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(rect);
    canvas.drawArc(
      rect.deflate(ringWidth / 2),
      0,
      2 * math.pi,
      false,
      ringPaint,
    );

    final tickPaint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < segments; i++) {
      final angle = (-math.pi / 2) + (i * (2 * math.pi / segments));
      final start = Offset(
        center.dx + (radius - ringWidth) * math.cos(angle),
        center.dy + (radius - ringWidth) * math.sin(angle),
      );
      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(start, end, tickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MoodFace extends StatelessWidget {
  const _MoodFace();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFFCE4EB),
        borderRadius: BorderRadius.circular(32),
      ),
      alignment: Alignment.center,
      child: const Text(
        '😊',
        style: TextStyle(fontSize: 48, color: Color(0xFF3F2E3E)),
      ),
    );
  }
}

class _MoodOption {
  const _MoodOption({required this.label, required this.color});

  final String label;
  final Color color;
}
