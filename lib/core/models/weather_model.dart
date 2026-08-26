import 'package:weather_app/core/helpers/weather_icon_helper.dart';

class WeatherModel {
  final double temp;
  final double feelsLike;
  final String condition;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final int visibility;
  final double? rain1h;
  WeatherModel({
    required this.temp,
    required this.feelsLike,
    required this.condition,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.visibility, 
    this.rain1h,
  });

  String get assetIcon => getWeatherAssetIcon(icon);
  
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final dataItem = (json['data'] as List).first as Map<String, dynamic>;
    final weatherItem =
        (dataItem['weather'] as List).first as Map<String, dynamic>;

    return WeatherModel(
      temp: (dataItem['temp'] as num).toDouble(),
      feelsLike: (dataItem['feels_like'] as num).toDouble(),
      condition: weatherItem['main'] ?? '',
      description: weatherItem['description'] ?? '',
      icon: weatherItem['icon'] ?? '',
      humidity: (dataItem['humidity'] as num).toInt(),
      windSpeed: (dataItem['wind_speed'] as num).toDouble(),
      pressure: (dataItem['pressure'] as num).toInt(),
      visibility: (dataItem['visibility'] as num).toInt(),
      rain1h: dataItem['rain']!=null ?(dataItem['rain']['1h']as num?)?.toDouble():null,
    );
  }
}
