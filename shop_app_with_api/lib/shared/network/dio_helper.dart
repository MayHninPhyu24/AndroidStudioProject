
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;
  //
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
          connectTimeout: 50000,
          receiveTimeout: 50000,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang= 'en',
    String? token,
    }) async{
    print(dio);
      dio.options.headers = {
        'Content-Type': 'application/json', // Added contentType here
        'lang' : lang,
          'Authorization' : token??'',
        };

      return await dio.get(
        url,
        queryParameters: query
      );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang= 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json', // Added contentType here
      'lang' : lang,
      'Authorization' : token,
    };
    var res =  dio.post(
        url,
        queryParameters: query,
        data: data,
    );
    return res;
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang= 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json', // Added contentType here
      'lang' : lang,
      'Authorization' : token,
    };
    var res =  dio.put(
      url,
      queryParameters: query,
      data: data,
    );
    return res;
  }

  static Future<Response> getDataWithPara({
    required String url,
    Map<String, dynamic>? query,
    String lang= 'en',
    String? token,
  }) async{
    print(dio);
    dio.options.headers = {
      'Content-Type': 'application/json', // Added contentType here
      'lang' : lang,
      'Authorization' : token??'',
    };

    return await dio.get(
        url,
        queryParameters: query
    );
  }

}