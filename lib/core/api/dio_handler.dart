import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app/core/api/error_handler.dart';
import 'package:weather_app/core/constants/api_constants.dart';

class DioHandler {
  static final DioHandler _instance = DioHandler._internal();
  final Dio dio;

  DioHandler._internal()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,

          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          responseType: ResponseType.json,
        ),
      ) {
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

  factory DioHandler() => _instance; // برجع اوبجيكت موجود بالاصل
 Future<dynamic>get(
  String path,{
    Map<String,dynamic>?queryParameters,
      })async{
        try {
          final reponse=await dio.get(
            path,
            queryParameters: queryParameters,
          );
          return reponse.data;

        } on DioException catch(e){
          throw Exception(e.message ?? 'An unexpected network error occurred');
        }
        catch (e) {
          throw ErrorHandler.handle(e);
        }
      }

 
}
//محرك اتصال بالانترنت بضمن ان التطبيق كامل بوفر نسخة واحدة فقط من الديو طول الوقت