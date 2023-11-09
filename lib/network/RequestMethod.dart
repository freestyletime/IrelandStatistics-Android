import 'dart:convert';
import 'dart:io';

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

  static void errorHandle(String id, int? statusCode) {
    String error = Strings.msg_default;
    switch(statusCode){
      case HttpStatus.badRequest:
        error = Strings.msg_400;
        break;
      case HttpStatus.forbidden:
        error = Strings.msg_403;
        break;
      case HttpStatus.notFound:
        error = Strings.msg_404;
        break;
    }
    Constants.eventBus.fire(FEvent(id, error));
  }

  static void get<T extends IBean>(String id, String url, {T? t, Map<String, dynamic>? data}) async {
    try {
      dio.get<List<dynamic>>(
        url,
        queryParameters: data,
      ).then((res) => {
        if(res.statusCode == HttpStatus.ok) {
          if(t != null) Constants.eventBus.fire(BeanEvent<T>(id, res.data, t))
        } else {
          errorHandle(id, res.statusCode)
        }
      });
    } catch(e) {
      rethrow;
    }
  }
}
