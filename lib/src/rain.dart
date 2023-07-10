import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class Precipitation extends StatefulWidget {
  const Precipitation({
    super.key,
    required this.type,
  });

  final PrecipitationType type;

  @override
  State<Precipitation> createState() => _PrecipitationState();
}

class _PrecipitationState extends State<Precipitation> with SingleTickerProviderStateMixin {
  late AnimationController _heightController;

  static const _dropCount = 100;

  /// Random x positions for each drop, as a fraction.
  final List<double> _xPositions = [];

  /// Random y positions for each drop, as a fraction.
  final List<double> _yPositions = [];

  @override
  void initState() {
    _heightController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat();

    super.initState();

    // Add random x and y positions for each rain drop.
    for (var i = 0; i < _dropCount; i++) {
      _xPositions.add(
        (Random().nextDouble()),
      );

      _yPositions.add(
        (Random().nextDouble()),
      );
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: List.generate(_dropCount, (index) {
          // The duration of the animation is tuned for a height of 800.
          // This adjusts the animation value, so that the speed is the same for
          // different heights.
          final heightMultiplier = 800 / constraints.maxHeight;

          // The drop's random y position, as a fraction, plus the current
          // height of the animation.
          final yFraction = _heightController.value * heightMultiplier + _yPositions[index];

          return Positioned(
            // The drops are moved up a constant amount, so that they restart
            // their fall above the screen.
            top: (constraints.maxHeight * yFraction % constraints.maxHeight) - 80,
            left: constraints.maxWidth * _xPositions[index],
            child: Image.asset(
              'assets/images/rain.webp',
              package: 'weather_animation',
            ),
          );
        }),
      );
    });
  }
}
