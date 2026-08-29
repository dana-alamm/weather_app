import 'package:flutter/material.dart';
import 'package:weather_app/core/services/shared_prefs_service.dart';

class ThemeProvider extends ChangeNotifier{
  static const String _themeKey='is_dark_mode';
  bool _isDarkMode=false;

  ThemeProvider(){
    _loadThemeFromMemory();
  }

  bool get isDarkMode=>_isDarkMode;

  ThemeMode get currentTheme=>_isDarkMode?ThemeMode.dark:ThemeMode.light;

  void toggleTheme([bool? value]){
    _isDarkMode=value?? !_isDarkMode;
    notifyListeners();
    SharedPrefsService.saveData(key: _themeKey, value: _isDarkMode);
  }
  void _loadThemeFromMemory()async{
    _isDarkMode=SharedPrefsService.getData(key: _themeKey)as bool? ??false;
    notifyListeners();
  }
}