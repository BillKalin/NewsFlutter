import 'package:dio/dio.dart';
import 'package:news_fluttter/news/constants/Api.dart';

class NetUtils {
  static final int TIME_OUT = Duration(seconds: 30).inMilliseconds;

//  static final Dio dio = new Dio(BaseOptions(
//      baseUrl: Api.BASE_HOST,
//      connectTimeout: TIME_OUT,
//      receiveTimeout: TIME_OUT));

  static Dio createInstance() {
    var dio = new Dio(BaseOptions(
        baseUrl: Api.BASE_HOST,
        connectTimeout: TIME_OUT,
        receiveTimeout: TIME_OUT));
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (RequestOptions options) {
        print("======> onRequest: url = ${options.uri}");
        return options;
      }, onResponse: (Response e) {
        print("======> onResponse: url = ${e.request.uri}, error = ${e.data}");
        return e;
      }, onError: (DioError e) {
        print("======> onError: url = ${e.request.uri}, error = ${e.type}");
        return e;
      }),
    );
    return dio;
  }

  static Future get(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
  }) async {
    var dio = createInstance();
    var response =
        await dio.get(path, queryParameters: queryParameters, options: options);
    return response.data;
  }

  static Future post(String path,
      {data, Map<String, dynamic> queryParameters, Options options}) async {
    var dio = createInstance();
    var response = await dio.post(path,
        data: data, queryParameters: queryParameters, options: options);

    return response.data;
  }
}
