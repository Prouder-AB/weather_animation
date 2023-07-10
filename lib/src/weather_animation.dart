import 'package:flutter/material.dart';
import 'package:weather_animation/src/conditions.dart';
import 'package:weather_animation/src/lightning.dart';
import 'package:weather_animation/src/rain.dart';

class WeatherAnimation extends StatefulWidget {
  const WeatherAnimation({
    super.key,
    required this.condition,
  });

  final WeatherCondition condition;

  @override
  State<WeatherAnimation> createState() => _WeatherAnimationState();
}

class _WeatherAnimationState extends State<WeatherAnimation> with SingleTickerProviderStateMixin {
  static const _switchDuration = Duration(milliseconds: 500);

  /// Animation Controller for switching between weather conditions.
  late AnimationController _switchController;
  late Animation<Color?> _skyColorAnimation;

  @override
  void initState() {
    super.initState();

    _switchController = AnimationController(
      vsync: this,
      // Initialize the value to 1, since the lower bound has no value at this
      // point.
      value: 1,
      duration: _switchDuration,
    )..addListener(() {
        setState(() {});
      });

    _skyColorAnimation = ColorTween(
      end: widget.condition.skyColor,
    ).animate(_switchController);
  }

  @override
  void dispose() {
    _switchController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WeatherAnimation oldWidget) {
    if (oldWidget.condition != widget.condition) {
      _switchController.reset();

      _skyColorAnimation = ColorTween(
        begin: oldWidget.condition.skyColor,
        end: widget.condition.skyColor,
      ).animate(_switchController);

      _switchController.forward();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(
            color: _skyColorAnimation.value!,
          ),
        ),
        Positioned(
          left: 0,
          child: AnimatedOpacity(
            opacity: widget.condition.sunVisibility ? 1 : 0,
            duration: _switchDuration,
            child: Image.asset(
              'assets/images/sun.webp',
              package: 'weather_animation',
              height: 200,
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: widget.condition.cloudVisibility ? 1 : 0,
          duration: _switchDuration,
          child: Stack(
            children: [
              Positioned(
                left: -100,
                top: -150,
                child: Image.asset(
                  'assets/images/cloud.webp',
                  package: 'weather_animation',
                ),
              ),
              Positioned(
                left: 100,
                child: Image.asset(
                  'assets/images/cloud.webp',
                  package: 'weather_animation',
                ),
              ),
              Positioned(
                left: -500,
                top: 100,
                child: Image.asset(
                  'assets/images/cloud.webp',
                  package: 'weather_animation',
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: widget.condition.precipitationType == PrecipitationType.none ? 0 : 1,
            duration: _switchDuration,
            child: Precipitation(
              type: widget.condition.precipitationType,
            ),
          ),
        ),
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: widget.condition.lightningVisibility ? 1 : 0,
            duration: _switchDuration,
            child: const Lightning(),
          ),
        ),
      ],
    );
  }
}
