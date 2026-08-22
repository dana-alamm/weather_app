import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

 
  static Future<bool> saveData({
  required String key,
  required dynamic value,
}) async {
  if (value is String) return _prefs.setString(key, value);
  if (value is bool) return _prefs.setBool(key, value);
  if (value is int) return _prefs.setInt(key, value);
  if (value is double) return _prefs.setDouble(key, value);
  if (value is List<String>) return _prefs.setStringList(key, value);
  return false;
}
static dynamic getData({required String key}){
  return _prefs.get(key);
}
static Future<bool>removeData({required String key})async{
  return await _prefs.remove(key);
}
static Future<bool>clearAll()async{
  return await _prefs.clear();
}
}
