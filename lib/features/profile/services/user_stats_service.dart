// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserStatsService {
//   String get _uid=>FirebaseAuth.instance.currentUser?.uid??'guest';

//   Future<int> getCitiesCount() async {
//     final prefs = await SharedPreferences.getInstance();
  
//     final list = prefs.getStringList('recent_search_$_uid') ?? 
//                  prefs.getStringList('recent_searches_$_uid') ?? [];
//     return list.length;
//   }

//   Future<int> getChecksCount()async{
//     final prefs=await SharedPreferences.getInstance();
//     return prefs.getInt('checks_count_$_uid')?? 0;
//   }
//   Future<int> getAlertsCount()async{
//     final prefs=await SharedPreferences.getInstance();
//     return prefs.getInt('alerts_count_$_uid')??0;

//   }
//   Future<void>incrementChecks()async{
//     final prefs=await SharedPreferences.getInstance();
//     int current=prefs.getInt('checks_count_$_uid')??0;
//     await prefs.setInt('checks_count_$_uid', current + 1);

//   }
//   Future<void> incrementAlerts() async {
//     final prefs = await SharedPreferences.getInstance();
//     int current = prefs.getInt('alerts_count_$_uid') ?? 0;
//     await prefs.setInt('alerts_count_$_uid', current + 1);
//   }

//   Future<Map<String, int>> getAllStats() async {
//     return {
//       'cities': await getCitiesCount(),
//       'checks': await getChecksCount(),
//       'alerts': await getAlertsCount(),
//     };
//   }
// }