import 'dart:io';
import 'package:dio/adapter.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
         ),
    );
    (dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
  }
  static Future<Response> getdata({
    required String url,
    Map<String, dynamic>? query,
     Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio?.options .headers={
      'lang': lang,
      'Authorization': token??'',
      'Content-Type':'application/json'
    };
    return await dio!.get(url,queryParameters: query,
    );
  }
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio?.options.headers= {
      'lang': lang,
      'Authorization': token??'',
      'Content-Type':'application/json'

    };
    return dio!.post(url, queryParameters: query, data: data);
  }
}
