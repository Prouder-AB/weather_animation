import 'dart:math';

import 'package:flutter/material.dart';

class Lightning extends StatefulWidget {
  const Lightning({super.key});

  @override
  State<Lightning> createState() => _LightningState();
}

class _LightningState extends State<Lightning> with SingleTickerProviderStateMixin {
  late final AnimationController _lightningController;

  /// The index of the lightning image to show.
  int _visibleLightning = 0;

  @override
  void initState() {
    super.initState();

    _lightningController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      reverseDuration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    _animateLightning();
  }

  @override
  void dispose() {
    _lightningController.dispose();
    super.dispose();
  }

  /// Show a lightning strike with random intervals.
  Future<void> _animateLightning() async {
    while (true) {
      await Future.delayed(Duration(milliseconds: Random().nextInt(2000)));

      _visibleLightning = Random().nextInt(5);

      if (!mounted) {
        return;
      }

      _lightningController.forward();

      await Future.delayed(const Duration(milliseconds: 50));

      if (!mounted) {
        return;
      }

      _lightningController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Allow overflow, and fix the size of the lightning.
    return OverflowBox(
      minWidth: 500,
      maxWidth: 500,
      minHeight: 500,
      maxHeight: 500,
      alignment: Alignment.topLeft,
      child: Stack(
        children: List.generate(5, (index) {
          late double opacity;

          if (index == _visibleLightning) {
            opacity = _lightningController.value;
          } else {
            opacity = 0;
          }

          return Opacity(
            opacity: opacity,
            child: Image.asset(
              'assets/images/lightning$index.webp',
              package: 'weather_animation',
            ),
          );
        }),
      ),
    );
  }
}
