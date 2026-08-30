import 'package:intl/intl.dart';
import 'package:weather_app/core/helpers/weather_icon_helper.dart';

class DailyWeatherModel{
  final DateTime date;
  final double minTemp;
  final double maxTemp;
  final String condition;
  final String description;
  final String icon;

  DailyWeatherModel({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.condition,
    required this.description,
    required this.icon,
  });

  String get assetIcon=>getWeatherAssetIcon(icon);
  String get dayName=>DateFormat('EEE').format(date);
  String get FormattedDate=>DateFormat('MMM d').format(date);

  factory DailyWeatherModel.fromJson(Map<String,dynamic>json){
    final weatherList=json['weather']as List?;
    final weatherItem=(weatherList!=null && weatherList.isNotEmpty)
    ? weatherList.first as Map<String,dynamic>
    :<String,dynamic>{};

    final tempMap=(json['temp']!=null && json['temp']is Map)
    ? json['temp']as Map<String,dynamic>
    :<String,dynamic>{};

    return DailyWeatherModel(
      date: DateTime.fromMillisecondsSinceEpoch(
        ((json['dt']as num?)?.toInt() ?? 0)*1000,
      ), 
      minTemp: (tempMap['min'] as num?)?.toDouble() ?? 0.0,
       maxTemp: (tempMap['max']as num?)?.toDouble()??0.0, 
       condition: weatherItem['main']??'', 
       description: weatherItem['description']??'', 
       icon: weatherItem['icon']??'',
       );


  }
}