import 'package:flutter/material.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:weather_app/core/services/api_services.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/features/home/widgets/precipitation_card.dart'; // تأكدي من المسار

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

  List<HourlyWeatherModel> get hourlyForecast => _currentWeather?.hourly ?? [];



    

  // 3. Getter يحسب نسبة تقدم الشمس بين الشروق والغروب (0.0 إلى 1.0)
  double get sunProgress {
    final now = DateTime.now();
    // أوقات مرجعية تقريبية (أو يمكن جلبها من الـ API)
    final sunrise = DateTime(now.year, now.month, now.day, 6, 0);
    final sunset = DateTime(now.year, now.month, now.day, 19, 30);

    if (now.isBefore(sunrise)) return 0.0;
    if (now.isAfter(sunset)) return 1.0;

    final totalDaylight = sunset.difference(sunrise).inMinutes;
    final currentDaylight = now.difference(sunrise).inMinutes;
    return (currentDaylight / totalDaylight).clamp(0.0, 1.0);
  }

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