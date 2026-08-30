import 'package:intl/intl.dart';
import 'package:weather_app/core/helpers/weather_icon_helper.dart';

class CurrentWeatherModel {
  final double temp;
  final double feelsLike;
  final String condition;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final int visibility;
  final double? rainAmount;
  final int sunrise;
  final int sunset;
  final int timeZoneOffset;

  CurrentWeatherModel({
    required this.temp,
    required this.feelsLike,
    required this.condition,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visibility,
    this.rainAmount,
    required this.sunrise,
    required this.sunset,
    this.timeZoneOffset = 0,
  });

  String get assetIcon => getWeatherAssetIcon(icon);

  String get formattedSunRise {
    if (sunrise == 0) return '--:--'; //if there is an error
    final date = DateTime.fromMillisecondsSinceEpoch(
      (sunrise + timeZoneOffset) * 1000,
      isUtc: true,
    );
    return DateFormat('HH:mm').format(date);
  }

  String get formattedSunSet {
    if (sunset == 0) return '--:--';
    final date = DateTime.fromMillisecondsSinceEpoch(
      (sunset + timeZoneOffset) * 1000,
      isUtc: true,
    );
    return DateFormat('HH:mm').format(date);
  }

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    final rawDataList = json['data'] as List?;
    final Map<String, dynamic> dataItem =
        (rawDataList != null && rawDataList.isNotEmpty)
        ? rawDataList.first as Map<String, dynamic>
        : json;

    final weatherList = dataItem['weather'] as List?;
    final weatherItem = (weatherList != null && weatherList.isNotEmpty)
        ? weatherList.first as Map<String, dynamic>
        : <String, dynamic>{};

    double? rain;
    if (dataItem['rain'] != null && dataItem['rain'] is Map) {
      rain = (dataItem['rain']['1h'] as num?)?.toDouble();
    }

    final sysMap =
        dataItem['sys'] as Map<String, dynamic>? ??
        json['sys'] as Map<String, dynamic>?;

    final int sunriseTime =
        (dataItem['sunrise'] as num?)?.toInt() ??
        (sysMap?['sunrise'] as num?)?.toInt() ??
        0;

    final int sunsetTime =
        (dataItem['sunset'] as num?)?.toInt() ??
        (sysMap?['sunset'] as num?)?.toInt() ??
        0;

    final int offset =
        (json['timezone_offset'] as num?)?.toInt() ??
        (json['timezone'] as num?)?.toInt() ??
        0;

    return CurrentWeatherModel(
      temp: (dataItem['temp'] as num?)?.toDouble() ?? 0.0,
      feelsLike: (dataItem['feels_like'] as num?)?.toDouble() ?? 0.0,
      condition: (weatherItem['main'] ?? ''),
      description: (weatherItem['description'] ?? ''),
      icon: (weatherItem['icon'] ?? ''),
      humidity: (dataItem['humidity'] as num?)?.toInt() ?? 0,
      windSpeed: (dataItem['wind_speed'] as num?)?.toDouble() ?? 0.0,
      pressure: (dataItem['pressure'] as num?)?.toInt() ?? 0,
      visibility: (dataItem['visibility'] as num?)?.toInt() ?? 0,
      rainAmount: rain,
      sunrise: sunriseTime,
      sunset: sunsetTime,
      timeZoneOffset: offset,
    );
  }
}
