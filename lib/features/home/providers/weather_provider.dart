import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/models/current_weather_model.dart';
import 'package:weather_app/core/models/daily_weather_model.dart';
import 'package:weather_app/core/models/hourly_weather_model.dart';

import 'package:weather_app/core/services/api_services.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/features/profile/services/user_stats_service.dart';

class WeatherProvider extends ChangeNotifier {

  String cityName='Loading...';
 
  
  final ApiServices _apiServices=ApiServices();
  

  CurrentWeatherModel? currentWeather;
  List<HourlyWeatherModel> hourlyList=[];
  List<DailyWeatherModel>dailyList=[];
  bool isLoading=false;
  String? errorMessage;

  

   String _temperatureUnit='metric';
   String get temperatureUnit=>_temperatureUnit;
   bool get isCelsius=>_temperatureUnit=='metric';
   String get unitLabel=>isCelsius?'Celsius' : 'Fahrenheit';
   String get tempSymbol=>isCelsius?'°C' : '°F';


   void setTemperatureUnit(String unit){
    if (_temperatureUnit == unit) return;
    _temperatureUnit = unit;
    notifyListeners();
   }

   int formatTemp(double? tempInCelsius){
    if (tempInCelsius==null)return 0;
    if(isCelsius){
      return tempInCelsius.round();
    }else{
      return ((tempInCelsius *9 /5)+32).round();
    }

   }

   String _timeFormat='24h';
   String get timeFormat=>_timeFormat;
   bool get is24Hour=>_timeFormat=='24h';

   void setTimeFormat(String format){
    if(_timeFormat==format)return;
    _timeFormat=format;
    notifyListeners();
   }

   String formatTime(DateTime? dateTime){
    if(dateTime==null)return '';
    if(is24Hour){
      return DateFormat('HH:mm').format(dateTime);
    }else{
      return DateFormat('h a').format(dateTime);
    }

   }

  Future<void> fetchWeatherData({
  double? lat,
  double? lon,
  String? newCityName,
}) async {
  isLoading = true;
  errorMessage = null;
  notifyListeners();

  try {
    double targetLat;
    double targetLon;


    if (lat != null && lon != null) {
      targetLat = lat;
      targetLon = lon;
      if (newCityName != null) {
        cityName = newCityName;
      }
    } else {
      final locationData = await LocationService.getCurrentLocationData();
      cityName = locationData['cityName'];
      targetLat = locationData['latitude'];
      targetLon = locationData['longitude'];
    }

    final results = await Future.wait([
      _apiServices.getCurrentWeather(lat: targetLat, lon: targetLon),
      _apiServices.getHourlyForecast(lat: targetLat, lon: targetLon),
      _apiServices.getDailyForcast(lat: targetLat, lon: targetLon),
    ]);

    currentWeather = results[0] as CurrentWeatherModel;
    hourlyList = results[1] as List<HourlyWeatherModel>;
    dailyList=results[2]as List<DailyWeatherModel>;

    // await _statsService.incrementChecks();

    

    final hasAlert=(currentWeather?.rainAmount !=null && currentWeather!.rainAmount!>0)||
    (currentWeather?.windSpeed??0)>8.0||
    (currentWeather?.visibility ?? 10000) < 2000 ||
          (currentWeather?.temp ?? 20) > 35.0 ||
          (currentWeather?.temp ?? 20) < 4.0;

      //     if (hasAlert) {
      //   await _statsService.incrementAlerts();
      // }
  } catch (e) {
    errorMessage = e.toString();
  } finally {
    isLoading = false;
    notifyListeners();
  }
}



}