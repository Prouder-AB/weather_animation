import 'package:flutter/material.dart';

enum PrecipitationType {
  rain,
  snow,
  none,
}

/// Enum for weather conditions based on OpenWeatherMap's API.
///
/// https://openweathermap.org/weather-conditions
enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  atmosphere,
  clear,
  clouds;

  static WeatherCondition fromConditionId(int id) {
    if (id < 300) {
      return WeatherCondition.thunderstorm;
    } else if (id < 400) {
      return WeatherCondition.drizzle;
    } else if (id < 600) {
      return WeatherCondition.rain;
    } else if (id < 700) {
      return WeatherCondition.snow;
    } else if (id < 800) {
      return WeatherCondition.atmosphere;
    } else if (id == 800) {
      return WeatherCondition.clear;
    } else if (id < 900) {
      return WeatherCondition.clouds;
    } else {
      // This should never happen, so this is just a fallback in case something
      // goes wrong.
      return WeatherCondition.clear;
    }
  }

  Color get skyColor {
    switch (this) {
      case WeatherCondition.thunderstorm:
      case WeatherCondition.drizzle:
        return const Color(0xFF8A8E91);
      case WeatherCondition.rain:
      case WeatherCondition.snow:
        return const Color(0xFFCEDCE5);
      case WeatherCondition.atmosphere:
      case WeatherCondition.clear:
      case WeatherCondition.clouds:
        return const Color(0xFF3980CE);
    }
  }

  bool get sunVisibility {
    switch (this) {
      case WeatherCondition.thunderstorm:
      case WeatherCondition.drizzle:
      case WeatherCondition.rain:
      case WeatherCondition.snow:
      case WeatherCondition.atmosphere:
        return false;
      case WeatherCondition.clear:
      case WeatherCondition.clouds:
        return true;
    }
  }

  bool get cloudVisibility {
    switch (this) {
      case WeatherCondition.atmosphere:
      case WeatherCondition.clear:
        return false;
      case WeatherCondition.thunderstorm:
      case WeatherCondition.drizzle:
      case WeatherCondition.rain:
      case WeatherCondition.snow:
      case WeatherCondition.clouds:
        return true;
    }
  }

  PrecipitationType get precipitationType {
    switch (this) {
      case WeatherCondition.thunderstorm:
      case WeatherCondition.drizzle:
      case WeatherCondition.rain:
        return PrecipitationType.rain;
      case WeatherCondition.snow:
        return PrecipitationType.snow;
      case WeatherCondition.atmosphere:
      case WeatherCondition.clear:
      case WeatherCondition.clouds:
        return PrecipitationType.none;
    }
  }

  bool get lightningVisibility {
    switch (this) {
      case WeatherCondition.thunderstorm:
        return true;
      case WeatherCondition.drizzle:
      case WeatherCondition.rain:
      case WeatherCondition.snow:
      case WeatherCondition.atmosphere:
      case WeatherCondition.clear:
      case WeatherCondition.clouds:
        return false;
    }
  }
}
