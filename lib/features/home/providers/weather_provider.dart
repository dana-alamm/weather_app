import 'package:flutter/material.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:weather_app/core/services/api_services.dart';
import 'package:weather_app/core/services/location_service.dart'; // تأكدي من المسار

class WeatherProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  WeatherModel? _currentWeather;
  String _cityName = 'Loading...';
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel? get currentWeather => _currentWeather;
  String get cityName => _cityName;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCurrentWeather() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // 1. جلب الموقع واسم المدينة من كلاس LocationService
      final locationData = await LocationService.getCurrentLocationData();
      _cityName = locationData['cityName'];

      // 2. جلب بيانات الطقس بالإحداثيات المسترجعة
      _currentWeather = await _apiServices.getCurrentWeather(
        lat: locationData['latitude'],
        lon: locationData['longitude'],
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}