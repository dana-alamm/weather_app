import 'package:dio/dio.dart';
import 'package:weather_app/core/api/dio_handler.dart';
import 'package:weather_app/core/constants/api_constants.dart';
import 'package:weather_app/core/models/weather_model.dart';

class ApiServices {
  final DioHandler _apiClient=DioHandler();

  Future<CurrentWeatherModel>getCurrentWeather({
    required double lat,
    required double lon,
  })async{
    final response=await _apiClient.get(
      ApiConstants.current,
      queryParameters: {
        'lat':lat,
        'lon':lon,
        'units':'metric',
        'appid':ApiConstants.apiKey,
      },
    );
    return CurrentWeatherModel.fromJson(response as Map<String,dynamic>);
  }
  
  Future<List<HourlyWeatherModel>>getHourlyForecast({
    required double lat,
    required double lon,
    
  })async{
    final response = await _apiClient.get(
      ApiConstants.hourly,
      queryParameters: {
        'lat': lat,
        'lon': lon,
        'cnt': 24, // for 24h
        'units': 'metric',
        'appid': ApiConstants.apiKey,
      },
    );
    final reponseMap=response as Map<String,dynamic>;
    final List rawList=reponseMap['data']as List? ?? [];

return rawList
.map((hourJson)=>HourlyWeatherModel.fromJson(hourJson as Map<String,dynamic>))
.toList();
  }
  
  Future<List<SearchResultWeatherModel>> searchCityWithWeather(String query)async{
   final response=await _apiClient.get(
    ApiConstants.directGeo,
    queryParameters: {
      'q':query,
      'limit':5,
      'appid': ApiConstants.apiKey,
    },
   
   );
   final List geoList=response as List? ?? [];
   if(geoList.isEmpty) return [];

   final List<Future<SearchResultWeatherModel>>tasks=geoList.map((item)async{
   final cityMap=item as Map<String,dynamic>;
   final double lat = (cityMap['lat'] as num).toDouble();
      final double lon = (cityMap['lon'] as num).toDouble();
      final weather = await getCurrentWeather(lat: lat, lon: lon);

      return SearchResultWeatherModel(
        cityName: cityMap['name'] ?? '',
        state: cityMap['state'] ?? '',
        country: cityMap['country'] ?? '',
        lat: lat,
        lon: lon,
        temp: weather.temp,
        condition: weather.condition,
        description: weather.description,
        humidity: weather.humidity,
        icon: weather.icon,
      );
   
   }).toList();
    
    return await Future.wait(tasks);
   
  }

  Future<List<DailyWeatherModel>>getDailyForcast({
    required double lat,
    required double lon,

  })async{
  final response=await _apiClient.get(
    ApiConstants.daily,
    queryParameters: {
      'lat':lat,
      'lon':lon,
      'units': 'metric',
      'appid': ApiConstants.apiKey,
    },
  );
  final List dataList=response['data']??[];
   return dataList
   .skip(1)
   .map((item)=>DailyWeatherModel.fromJson(item as Map<String,dynamic>))
   .toList();
  }

  
}