import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app/core/constants/api_constants.dart';

class DioHandler{
  static final DioHandler _instance=DioHandler._internal();
  final Dio dio;

 DioHandler._internal()
 :dio=Dio(
  BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    ),
 ){
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ),
  );
 }
  
  factory DioHandler()=>_instance;// برجع اوبجيكت موجود بالاصل
}
//محرك اتصال بالانترنت بضمن ان التطبيق كامل بوفر نسخة واحدة فقط من الديو طول الوقت