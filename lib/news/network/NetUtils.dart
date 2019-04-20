import 'package:dio/dio.dart';

class NetUtils {
  static final Dio dio = new Dio();

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
