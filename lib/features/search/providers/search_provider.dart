import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/features/search/widgets/current_location_button.dart';

class SearchProvider  extends ChangeNotifier{
  bool _isLoading=false;
  String? _errorMessage;
  List<Map<String,dynamic>>_searchResults=[];

  bool get isLoading=>_isLoading;
  String? get errorMessage=>_errorMessage;
  List<Map<String,dynamic>> get searchResults=>_searchResults;

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
      _isLoading=false;
      notifyListeners();
    }catch (e){
      _isLoading=false;
      _errorMessage = 'Failed to find cities. Please try again.';
      notifyListeners();
    }
  }
  void clearSearch(){
    _searchResults=[];
    notifyListeners();
  }


Future<String?>fetchCurrentCityName()async{
  _isLoading=true;
  _errorMessage=null;
  notifyListeners();

  try {
    final locationData=await LocationService.getCurrentLocationData();
    final String cityName=locationData['cityName']??'';

    _isLoading=false;
    notifyListeners();
    return cityName;
  } catch (e) {
    _isLoading=false;
    _errorMessage=e.toString();
    notifyListeners();
    return null;
  }
}
}