import 'package:intl/intl.dart';
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
  final List<HourlyWeatherModel> hourly;
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
    required this.hourly,
    
  });

  String get assetIcon => getWeatherAssetIcon(icon);

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    // final dataList = (json['data'] as List).cast<Map<String, dynamic>>();
    // final dataItem = (json['data'] as List).first as Map<String, dynamic>;
    // final weatherItem =
    //     (dataItem['weather'] as List).first as Map<String, dynamic>;
    final rawDataList = json['data'] as List?;
    final List<Map<String, dynamic>> dataList = (rawDataList != null && rawDataList.isNotEmpty)
        ? rawDataList.cast<Map<String, dynamic>>()
        : [];

    // 2. قراءة أول عنصر بأمان
    final dataItem = dataList.isNotEmpty ? dataList.first : <String, dynamic>{};
    
    // 3. قراءة weather بأمان
    final weatherList = dataItem['weather'] as List?;
    final weatherItem = (weatherList != null && weatherList.isNotEmpty)
        ? weatherList.first as Map<String, dynamic>
        : <String, dynamic>{};

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
      hourly: dataList.map((item)=>HourlyWeatherModel.fromJson(item)).toList(),
    );
  }
}
class HourlyWeatherModel {
final DateTime time;
final double temp;
final String icon;
final double pop;
final double rainAmount;

HourlyWeatherModel({
  required this.time,
    required this.temp,
    required this.icon,
    required this.pop,
    required this.rainAmount,
});
String get assetIcon=>getWeatherAssetIcon(icon);
String get formattedHour=>DateFormat('h a').format(time).toLowerCase();

factory HourlyWeatherModel.fromJson(Map<String,dynamic>json){
  final weatherList=json['weather']as List?;
  final weatherItem=(weatherList != null && weatherList.isNotEmpty)
  ?weatherList.first as Map<String,dynamic>
  :{};
double rain=0.0;
if(json['rain']!=null && json['rain'] is Map){
  rain=(json['rain']['1h']as num?)?.toDouble()??0.0;
}
return HourlyWeatherModel(
  time: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000),
  temp: (json['temp']as num?)?.toDouble()??0.0,
  icon: weatherItem['icon'] ?? '',
  pop: (json['pop'] as num?)?.toDouble() ?? 0.0,
  rainAmount: rain,
  );
}
}