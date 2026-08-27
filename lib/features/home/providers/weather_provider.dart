import 'package:flutter/material.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:weather_app/core/services/api_services.dart';
import 'package:weather_app/core/services/location_service.dart';

class WeatherProvider extends ChangeNotifier {

  String cityName='Loading...';
  final ApiServices _apiServices=ApiServices();
  CurrentWeatherModel? currentWeather;
  List<HourlyWeatherModel> hourlyList=[];
  bool isLoading=false;
  String? errorMessage;

  

  Future<void> fetchWeatherData()async{
    isLoading=true;
    errorMessage=null;
    notifyListeners();

    try {
     final locationData = await LocationService.getCurrentLocationData();
    cityName = locationData['cityName'];
    final double lat = locationData['latitude'];
    final double lon = locationData['longitude'];

    final results = await Future.wait([
      _apiServices.getCurrentWeather(lat: lat, lon: lon),
      _apiServices.getHourlyForecast(lat: lat, lon: lon),
    ]);

    currentWeather = results[0] as CurrentWeatherModel;
    hourlyList = results[1] as List<HourlyWeatherModel>;
      
    } catch (e) {
      errorMessage = e.toString();
    }finally {
      isLoading = false;
      notifyListeners();
    }
  }

}