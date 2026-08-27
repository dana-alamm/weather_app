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
  

  
}