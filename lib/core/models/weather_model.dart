import 'package:intl/intl.dart';
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
    );
  }
}
class HourlyWeatherModel{
  final DateTime time;
  final double temp;
  final String icon;
  final double pop;//%  Probability of Precipitation
  final double rainAmount;//for the columns at the end of the screen

  HourlyWeatherModel({
    required this.time,
    required this.temp,
    required this.icon,
    required this.pop,
    required this.rainAmount
  });
  String get assetIcon=>getWeatherAssetIcon(icon);
  String get formattedHour=>DateFormat('h a').format(time).toLowerCase();

  factory HourlyWeatherModel.fromJson(Map<String,dynamic>json){
    final weatherList=json['weather'] as List?;
    final weatheritem=(weatherList !=null && weatherList.isNotEmpty)
    ?weatherList.first as Map<String,dynamic>
    :<String,dynamic>{};

    double rain=0.0;
    if(json['rain']!=null && json['rain']is Map){
      rain=(json['rain']['1h'] as num?)?.toDouble() ??0.0;

    }
    return HourlyWeatherModel(
      time: DateTime.fromMillisecondsSinceEpoch(
        ((json['dt'] as num?)?.toInt() ?? 0) * 1000,
      ),
      temp: (json['temp']as num?)?.toDouble() ??0.0, 
      icon: weatheritem['icon']??'', 
      pop: (json['pop'] as num?)?.toDouble() ??0.0, 
      rainAmount: rain
      );

  }
}