import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  final dio = Dio();

  DioClient(){
    //dio.options.baseUrl = UrlConstants.host;
    dio.options.baseUrl = "";
    dio.interceptors.add(PrettyDioLogger());
  }
}

