import 'package:dio/dio.dart';

class NewsDioHelper{
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
        connectTimeout: 50000,
        receiveTimeout: 50000,
      ),
    );
  }
  
  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async{
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}