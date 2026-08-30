import 'package:weather_app/core/helpers/weather_icon_helper.dart';

class CurrentWeatherModel{
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
  });

  String get assetIcon=>getWeatherAssetIcon(icon);

  factory CurrentWeatherModel.fromJson(Map<String,dynamic>json){
    final rawDataList=json['data']as List?;
    final Map<String,dynamic>dataItem=
    (rawDataList !=null && rawDataList.isNotEmpty)
    ? rawDataList.first as Map<String,dynamic>
    :json;

    final weatherList=dataItem['weather'] as List?;
    final weatherItem=(weatherList!=null && weatherList.isNotEmpty)
    ? weatherList.first as Map<String,dynamic>
    :<String,dynamic>{};

    double? rain;
    if (dataItem['rain'] != null && dataItem['rain'] is Map) {
      rain = (dataItem['rain']['1h'] as num?)?.toDouble();
    }

    return CurrentWeatherModel(
      temp: (dataItem['temp']as num?)?.toDouble() ?? 0.0, 
      feelsLike: (dataItem['feels_like']as num?)?.toDouble() ?? 0.0, 
      condition: (weatherItem['main']??''), 
      description: (weatherItem['description']??''), 
      icon: (weatherItem['icon']??''), 
      humidity: (dataItem['humidity']as num?)?.toInt() ??0, 
     windSpeed: (dataItem['wind_speed'] as num?)?.toDouble() ?? 0.0,
      pressure: (dataItem['pressure'] as num?)?.toInt() ?? 0,
      visibility: (dataItem['visibility'] as num?)?.toInt() ?? 0,
      rainAmount: rain,
    );
  }
}