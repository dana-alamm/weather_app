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

class SearchResultWeatherModel{
  final String cityName;
  final String state;
  final String country;
  final double lat;
  final double lon;
  final double temp;
  final String condition;
  final String description;
  final int humidity;
  final String icon;

  SearchResultWeatherModel({
    required this.cityName,
    required this.state,
    required this.country,
    required this.lat,
    required this.lon,
    required this.temp,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.icon,
  });
  String get subtitle{
    final parts=[cityName, if(state.isNotEmpty)state,country];
    return parts.join(', ');
  }
  factory SearchResultWeatherModel.fromApiJson({
    required Map<String, dynamic> geoJson,
    required Map<String, dynamic> weatherJson,
  }) {
    return SearchResultWeatherModel(
      cityName: geoJson['name'] ?? '',
      state: geoJson['state'] ?? '',
      country: geoJson['country'] ?? '',
      lat: (geoJson['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (geoJson['lon'] as num?)?.toDouble() ?? 0.0,
      temp: (weatherJson['main']['temp'] as num?)?.toDouble() ?? 0.0,
      condition: weatherJson['weather'][0]['main'] ?? '',
      description: weatherJson['weather'][0]['description'] ?? '',
      humidity: weatherJson['main']['humidity'] ?? 0,
      icon: weatherJson['weather'][0]['icon'] ?? '',
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'state': state,
      'country': country,
      'lat': lat,
      'lon': lon,
      'temp': temp,
      'condition': condition,
      'description': description,
      'humidity': humidity,
      'icon': icon,
    };
  }

  //to read the object after sharedPreference
  factory SearchResultWeatherModel.fromStoredJson(Map<String, dynamic> json) {
    return SearchResultWeatherModel(
      cityName: json['cityName'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      temp: (json['temp'] as num?)?.toDouble() ?? 0.0,
      condition: json['condition'] ?? '',
      description: json['description'] ?? '',
      humidity: json['humidity'] ?? 0,
      icon: json['icon'] ?? '',
    );
  }
}
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