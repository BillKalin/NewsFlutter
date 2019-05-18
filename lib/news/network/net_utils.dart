import 'package:dio/dio.dart';
import 'package:news_fluttter/news/constants/Api.dart';

class NetUtils {
  static final int TIME_OUT = Duration(seconds: 15).inMilliseconds;

  static final Dio dio = new Dio(BaseOptions(
      baseUrl: Api.BASE_HOST,
      connectTimeout: TIME_OUT,
      receiveTimeout: TIME_OUT));

  static Future get(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
  }) async {
    var response =
        await dio.get(path, queryParameters: queryParameters, options: options);
    return response.data;
  }

  static Future post(String path,
      {data, Map<String, dynamic> queryParameters, Options options}) async {
    var response = await dio.post(path,
        data: data, queryParameters: queryParameters, options: options);

    return response.data;
  }
}
