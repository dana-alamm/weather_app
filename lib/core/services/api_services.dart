import 'package:weather_app/core/api/dio_handler.dart';
import 'package:weather_app/core/constants/api_constants.dart';
import 'package:weather_app/core/models/weather_model.dart';

class ApiServices {
  final DioHandler _apiClient=DioHandler();

  Future<WeatherModel>getCurrentWeather({
    required double lat,
    required double lon,

  })async{
    final response=await _apiClient.get(
      ApiConstants.hourly,
      queryParameters: {
        'lat':lat,
        'lon':lon,
        'units':'metric',
        'appid':ApiConstants.apiKey,
      },
    );
    return  WeatherModel.fromJson(response as Map<String,dynamic>);
  }
}