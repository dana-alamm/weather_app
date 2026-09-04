import 'package:dio/dio.dart';
import 'app_exceptions.dart'; 

class ErrorHandler {
  static AppException handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          return NetworkException('No internet connection. Please check your network.');

        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 404) {
            return NotFoundException('City or weather data not found.');
          }else if(statusCode==401){
 return UnauthorizedException('Invalid or inactive API Key.');
          }else if(statusCode==404){
            return NotFoundException('City or weather data not found.');
          }else if(statusCode==429){
            return UnknownException('Too many requests. Please try again in a moment.');
          }
           else if (statusCode != null && statusCode >= 500) {
            return ServerException('Server error. Please try again later.');
          }
          return UnknownException('Received invalid status: $statusCode');

        default:
          return UnknownException('Unexpected network error occurred.');
      }
    }
    return UnknownException(error.toString());
  }
}