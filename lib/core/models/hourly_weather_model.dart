import 'package:intl/intl.dart';
import 'package:weather_app/core/helpers/weather_icon_helper.dart';

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
