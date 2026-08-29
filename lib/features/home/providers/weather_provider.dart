import 'package:flutter/material.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:weather_app/core/services/api_services.dart';
import 'package:weather_app/core/services/location_service.dart';

class WeatherProvider extends ChangeNotifier {

  String cityName='Loading...';
  final ApiServices _apiServices=ApiServices();
  CurrentWeatherModel? currentWeather;
  List<HourlyWeatherModel> hourlyList=[];
  List<DailyWeatherModel>dailyList=[];
  bool isLoading=false;
  String? errorMessage;

  

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
  } catch (e) {
    errorMessage = e.toString();
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

}