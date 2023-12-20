import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../Constants.dart';
import '../events/Event.dart';
import '../models/IBean.dart';

class NetWork {
  static Dio dio = _getDio();

  static Dio _getDio() {
    Dio dio = Dio();

    const Map<String, dynamic> headers = {
      'content-type': 'application/json;charset=utf-8',
      'accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': true,
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE'
    };

    dio.options = BaseOptions(
      baseUrl: URLConstants.workPermit,
      headers: headers,
      receiveTimeout: const Duration(seconds: URLConstants.receiveTimeout),
      sendTimeout: const Duration(seconds: URLConstants.sendTimeout),
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

  static void get<T extends IBean>(String id, String url,
      {T? t, Map<String, dynamic>? data}) {

    Future<List<dynamic>> httpGet(String url,
        {Map<String, dynamic>? data,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress}) async {
      try {
        var response = await dio.get(
          url,
          queryParameters: data,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
        return response.data;
      } catch (e) {
        rethrow;
      }
    }

    List<dynamic> errorHandle(String id, Exception e) {
      var res = [];
      var str = '';
      if (e is DioException) {
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
            str = Strings.msg_connection_timeout;
            break;
          case DioExceptionType.connectionError:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            str = Strings.msg_network_timeout;
            break;
          case DioExceptionType.badCertificate:
            str = Strings.msg_cert_error;
          case DioExceptionType.badResponse:
            str = Strings.msg_params_error;
            break;
          case DioExceptionType.cancel:
            str = Strings.msg_connection_cancel;
            break;
          default:
            str = Strings.msg_unknow;
            break;
        }
      }

      Constants.eventBus.fire(FEvent(id, str));
      return res;
    }

    Constants.eventBus.fire(SEvent(id));
    NetWork.isConnected().then((isConnected) => {
          if (isConnected)
            {
              httpGet(url, data: data)
                  .catchError((error, stackTrace) => errorHandle(id, error))
                  .then((res) => {
                        if (t != null)
                          Constants.eventBus.fire(BeanEvent<T>(id, res, t))
                      })
                  .whenComplete(() => Constants.eventBus.fire(CEvent(id)))
            }
          else
            {Constants.eventBus.fire(FEvent(id, Strings.msg_not_connection))}
        });
  }
}
