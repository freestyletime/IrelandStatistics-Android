import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../Constants.dart';

class NetWork {

  static Dio _getDio() {
    Dio dio = Dio();

    const Map<String, dynamic> headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };

    dio.options = BaseOptions(
      baseUrl: URLConstants.workPermit,
      headers: headers,
      receiveTimeout: const Duration(seconds: URLConstants.TIMEOUT),
      sendTimeout: const Duration(seconds: URLConstants.TIMEOUT),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }

  static Future<bool> isConnected() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<Response> get(String url, {Map<String, dynamic>? data}) async {
    try {
      Response res = await _getDio().get<List<int>>(
        url,
        queryParameters: data,
      );
      return res;
    } catch(e) {
      rethrow;
    }
  }
}
