// class WeatherModel {
//   final String cityName;
//   final double temperature;
//   final double feelsLike;
//   final String condition;
//   final String description;
//   final String iconCode;
//   final int humidity;
//   final double windSpeed;
//   final double tempMin;
//   final double tempMax;
//   WeatherModel({
//     required this.cityName,
//     required this.temperature,
//     required this.feelsLike,
//     required this.condition,
//     required this.description,
//     required this.iconCode,
//     required this.humidity,
//     // required this.windSpeed,
//     required this.tempMin,
//     required this.tempMax,

//   });
//   factory WeatherModel.fromJson(Map<String,dynamic>json){
//     final weatherList=json['weather']as List<dynamic>?;
//     final weatherInfo=(weatherList !=null &&  weatherList.isNotEmpty)
//     ? weatherList[0] as Map<String,dynamic>
//     :{};
//     final main=json['main'] as Map<String,dynamic>? ?? {};
//     final wind=json['wind'] as Map<String,dynamic>? ?? {};
//   }
// }