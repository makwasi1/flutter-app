import 'dart:async';
import 'dart:convert' show Encoding, utf8;
import 'dart:io';

import 'package:citizen_feedback/shared/exceptions/app_exception.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class HttpUtils {
  static String refreshToken = 'refresh_token';
  static String keyForJWTToken = 'accessToken';
  static String keyForUsername = 'username';
  static String keyForUserJson = 'user_model_json';
  static String keyForDistricts = 'districts';
  static String keyForRegions = 'regions';
  static String keyForPolls = 'polls';
  static int timeout = 300;

  static String encodeUTF8(String toEncode) {
    return utf8.decode(toEncode.runes.toList());
  }

  static Future<Object> headers([bool session = true]) async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    String jwt = await storage.read(key: HttpUtils.keyForJWTToken);
    if (!session) {
      return {
        'Accept': 'application/json;charset=UTF-8',
        'Content-Type': 'application/json',
        'Charset': 'utf-8',
      };
    }
    if (jwt != null) {
      return {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      };
    } else {
      return {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
    }
  }

  static Future<Response> postRequest<T>(String endpoint, T body,
      [bool session = true]) async {
    var headers = await HttpUtils.headers(session);
    final String json = JsonMapper.serialize(body, SerializationOptions(indent: ''));
    Response response;
    try {
      response = await http
          .post('$endpoint',
              headers: headers,
              body: json,
              encoding: Encoding.getByName('utf-8'))
          .timeout(Duration(seconds: timeout));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout');
    }
    print('Response:${response.statusCode}');
    return response;
  }

  static Future<Response> getRequest(String endpoint,
      [bool session = true]) async {
    var headers = await HttpUtils.headers(session);
    Response response;
    try {
      response = await http
          .get('$endpoint', headers: headers)
          .timeout(Duration(seconds: timeout));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout');
    }
    print('Response:${response.statusCode}');
    return returnResponse(response);
  }

  static Future<Response> putRequest<T>(String endpoint, T body,
      [bool session = true]) async {
    var headers = await HttpUtils.headers(session);
    final String json =
        JsonMapper.serialize(body, SerializationOptions(indent: ''));
    Response response;
    try {
      response = await http
          .put('$endpoint',
              headers: headers,
              body: json,
              encoding: Encoding.getByName('utf-8'))
          .timeout(Duration(seconds: timeout));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout');
    }
    return response;
  }

  static Future<Response> deleteRequest(String endpoint,
      [bool session = true]) async {
    var headers = await HttpUtils.headers(session);
    try {
      return await http
          .delete('$endpoint', headers: headers)
          .timeout(Duration(seconds: timeout));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout');
    }
  }

  static dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  static Future<Response> postMulitpartRequest<T>(String endpoint, T body,
      [bool session = true]) async {
    var headers = await HttpUtils.headers(session);
    final String json =
        JsonMapper.serialize(body, SerializationOptions(indent: ''));
    Response response;
    try {
      response = await http
          .post('$endpoint',
              headers: headers,
              body: json,
              encoding: Encoding.getByName('utf-8'))
          .timeout(Duration(seconds: timeout));
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw FetchDataException('Request timeout');
    }
    return response;
  }
}
