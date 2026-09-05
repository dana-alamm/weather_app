import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/models/current_weather_model.dart';
import 'package:weather_app/core/models/daily_weather_model.dart';
import 'package:weather_app/core/models/hourly_weather_model.dart';

import 'package:weather_app/core/services/api_services.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/core/services/shared_prefs_service.dart';


class WeatherProvider extends ChangeNotifier {

  String cityName='Loading...';
 
  
  final ApiServices _apiServices=ApiServices();
  

  CurrentWeatherModel? currentWeather;
  List<HourlyWeatherModel> hourlyList=[];
  List<DailyWeatherModel>dailyList=[];
  bool isLoading=false;
  String? errorMessage;

  

  String _temperatureUnit='metric';
  



static const String _tempUnitKey='user_temp_unit';
static const String _timeFormatKey='user_time_format';

WeatherProvider(){
  _loadSettingsFromPrefs();
}

void _loadSettingsFromPrefs(){
  final savedUnit=SharedPrefsService.getData(key:_tempUnitKey)as String?;
  final savedTime=SharedPrefsService.getData(key: _timeFormatKey)as String?;

  if(savedUnit!=null){
    _temperatureUnit=savedUnit;
  }
  if (savedTime != null) {
      _timeFormat = savedTime;
    }
    notifyListeners();
}
   String get temperatureUnit=>_temperatureUnit;
   bool get isCelsius=>_temperatureUnit=='metric';
   String get unitLabel=>isCelsius?'Celsius' : 'Fahrenheit';
   String get tempSymbol=>isCelsius?'°C' : '°F';

   void setTemperatureUnit(String unit)async{
    if (_temperatureUnit == unit) return;
    _temperatureUnit = unit;
    notifyListeners();
    await SharedPrefsService.saveData(key: _tempUnitKey, value: unit);
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

   void setTimeFormat(String format)async{
    if(_timeFormat==format)return;
    _timeFormat=format;
    notifyListeners();

    await SharedPrefsService.saveData(key: _timeFormatKey, value: format);
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


    if (lat != null && lon != null) { // like in search
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


    

    

      
  } catch (e) {
    errorMessage = e.toString();
  } finally {
    isLoading = false;
    notifyListeners();
  }
}



}