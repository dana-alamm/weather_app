import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{
  static const String _themeKey='is_dark_mode';//for sharedPrefs
  ThemeMode _themeMode=ThemeMode.light;

  ThemeMode get themeMode=>_themeMode;
  bool get isDarkMode=>_themeMode==ThemeMode.dark;

  ThemeProvider(){
    loadTheme();
  }

  Future<void> loadTheme() async{
    final prefs=await SharedPreferences.getInstance();
    final isDark=prefs.getBool(_themeKey)??false;
    _themeMode=isDark? ThemeMode.dark :ThemeMode.light;
    notifyListeners();

  }
  Future<void> toggleTheme(bool isDark)async{
    _themeMode=isDark?ThemeMode.dark:ThemeMode.light;
    notifyListeners();
    final prefs=await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }
}