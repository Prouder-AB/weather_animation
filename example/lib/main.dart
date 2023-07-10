import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _condition = 800;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: WeatherAnimation(
                  condition: WeatherCondition.fromConditionId(_condition),
                ),
              ),
              SizedBox(
                width: 400,
                child: TextField(
                  onSubmitted: (value) {
                    setState(() {
                      _condition = int.parse(value);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
