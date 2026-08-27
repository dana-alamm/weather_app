import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:weather_app/core/services/api_services.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/features/search/widgets/current_location_button.dart';

class SearchProvider  extends ChangeNotifier{
  final ApiServices _apiServices=ApiServices();


  bool _isLoading=false;
  String? _errorMessage;
  List<SearchResultWeatherModel> _searchResults=[];
   final List<SearchResultWeatherModel> _recentCities=[];

  bool get isLoading=>_isLoading;
  String? get errorMessage=>_errorMessage;
  List<SearchResultWeatherModel> get searchResults=>_searchResults;
  List<SearchResultWeatherModel> get recentCities=>_recentCities;

  Future<void> searchCity(String query)async{
    if(query.trim().isEmpty){
      _searchResults=[];
      notifyListeners();
      return;
    }

    _isLoading=true;
    _errorMessage=null;
    notifyListeners();


    try{
     // _isLoading=false; // we need API here
     _searchResults=await _apiServices.searchCityWithWeather(query.trim());
      
      notifyListeners();
    }catch (e){
      _searchResults=[];
      _errorMessage = 'Failed to find cities. Please try again.';
    }finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void clearSearch(){
    _searchResults=[];
    _errorMessage=null;
    notifyListeners();
  }


Future<String?>fetchCurrentCityName()async{
  _isLoading=true;
  _errorMessage=null;
  notifyListeners();

  try {
    final locationData=await LocationService.getCurrentLocationData();
    final String cityName=locationData['cityName']??'';

    // _isLoading=false;
    // notifyListeners();
    return cityName;
  } catch (e) {
   // _isLoading=false;
    _errorMessage=e.toString();
   // notifyListeners();
    return null;
  }finally {
      _isLoading = false;
      notifyListeners();
    }
}

void addToRecent(SearchResultWeatherModel city){
  _recentCities.removeWhere((item)=>item.cityName==city.cityName && item.country ==city.country);

  _recentCities.insert(0, city);

  if(recentCities.length>5){
    _recentCities.removeLast();
  }
  notifyListeners();

}
void removeFromRecent(SearchResultWeatherModel city){
  _recentCities.remove(city);
  notifyListeners();
}
}