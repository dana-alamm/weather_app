import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/models/search_result_weather_model.dart';
import 'package:weather_app/core/services/api_services.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/core/models/weather_model.dart'; 


class SearchProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  bool _isLoading = false;
  String? _errorMessage;
  List<SearchResultWeatherModel> _searchResults = [];

  //static const String _recentKey = 'recent_search_cities';
  String get _recentKey {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';
    return 'recent_search_$uid';
  }
  List<SearchResultWeatherModel> _recentCities = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<SearchResultWeatherModel> get searchResults => _searchResults;
  List<SearchResultWeatherModel> get recentCities => _recentCities;

  SearchProvider(){
 loadRecentCities();
  }

  Future<void> searchCity(String query) async {
    if (query.trim().isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // _isLoading=false; // we need API here
      _searchResults = (await _apiServices.searchCityWithWeather(query.trim())).cast<SearchResultWeatherModel>();

      notifyListeners();
    } catch (e) {
      _searchResults = [];
      _errorMessage = 'Failed to find cities. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _searchResults = [];
    _errorMessage = null;
    notifyListeners();
  }

  Future<String?> fetchCurrentCityName() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final locationData = await LocationService.getCurrentLocationData();
      final String cityName = locationData['cityName'] ?? '';

      // _isLoading=false;
      // notifyListeners();
      return cityName;
    } catch (e) {
      // _isLoading=false;
      _errorMessage = e.toString();
      // notifyListeners();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addToRecent(SearchResultWeatherModel city) async{
    _recentCities.removeWhere(
      (item) => item.cityName == city.cityName && item.country == city.country,
    );

    _recentCities.insert(0, city);

    if (recentCities.length > 5) {
      _recentCities.removeLast();
    }
    notifyListeners();
    await _saveToPrefs();
  }

  void removeFromRecent(SearchResultWeatherModel city) {
    _recentCities.remove(city);
    notifyListeners();
  }

  Future<void> loadRecentCities()async{
  final prefs=await SharedPreferences.getInstance();
  final List<String>?storedList=prefs.getStringList(_recentKey);

  if(storedList!=null && storedList.isNotEmpty){
    _recentCities=storedList
    .map((item)=>SearchResultWeatherModel.fromStoredJson(jsonDecode(item)))
    .toList();
    notifyListeners();
  }
  }

 
  Future<void> _saveToPrefs()async{
    final prefs=await SharedPreferences.getInstance();
    final List<String> encodedList=
    _recentCities.map((city)=>jsonEncode(city.toJson())).toList();
    await prefs.setStringList(_recentKey, encodedList);
  }
  Future<void> clearRecentCities() async {
    _recentCities.clear();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentKey);
  }
}
