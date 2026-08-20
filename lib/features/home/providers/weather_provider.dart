import 'package:flutter/material.dart';
import 'package:weather_app/core/services/location_service.dart';

class WeatherProvider extends ChangeNotifier{
  bool isLoading=false;
  String cityName='Loading....';
  double? latitude;
  double? longitude;
  String? errorMessage;


  Future<void> fetchLocationData() async {
    isLoading=true;
    errorMessage=null;
    notifyListeners();

    try {
      final locationData=await LocationService.getCurrentLocationData();
      cityName=locationData['cityName']?? 'Unknown City';
      latitude=locationData['latitude'];
      longitude=locationData['longitude'];
    } catch (e) {
      errorMessage=e.toString();
      cityName='Unknown City';

    }finally{
      isLoading=false;
      notifyListeners();
    }
  }
}