class ApiConstants {
  static const String baseUrl='https://api.openweathermap.org/data/2.5';
  static const String apiKey='01e7cfd24aa8322795e9cd9c53ac8130';

  static String currentWeather(String city)=>
  '$baseUrl/weather?q=$city&units=metric&appid=$apiKey';
}
//منرتب البيانات الجاي من السيرفر لتصبح مقروئةوسهلة الاستخدام