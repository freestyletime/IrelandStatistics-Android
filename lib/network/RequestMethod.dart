import 'package:dio/dio.dart';

final dio = Dio();

Future<void> http_get(String url, Map<String, dynamic> data, Map<String, dynamic> headers) async {
  Response res = await dio.request(
    url,
    data: data,
    options: Options(
        method: 'GET',
        headers: headers
    ),
  );
}