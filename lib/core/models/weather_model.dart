class WeatherModel {
  final double temp;
  final double feelsLike;
  final String condition;
  final String description;
  final String icon;
   WeatherModel({
    required this.temp,
    required this.feelsLike,
    required this.condition,
    required this.description,
    required this.icon,
   });
   factory WeatherModel.fromJson(Map<String,dynamic>json){
    final dataItem = (json['data'] as List).first as Map<String, dynamic>;
    final weatherItem = (dataItem['weather'] as List).first as Map<String, dynamic>;

    return WeatherModel(
      temp: (dataItem['temp']as num).toDouble(),
      feelsLike: (dataItem['feels_like']as num).toDouble(),

      condition: weatherItem['main']??'',
      description: weatherItem['description']??'',
      icon: weatherItem['icon']??'',
      );
   }

   
}