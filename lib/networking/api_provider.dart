import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:tabibak/networking/custom_exception.dart';
import 'package:tabibak/shared_preferences/shared_preferences.dart';

class ApiProvider {
// next three lines makes this class a Singleton
  static ApiProvider _instance = new ApiProvider.internal();

  ApiProvider.internal();

  factory ApiProvider() => _instance;

  final _defaultHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get(String url, {Map<String, String>? header}) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url),
          headers: header == null ? _defaultHeader : header);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, {body, Map<String, String>? header}) async {
    var responseJson;
    try {
      final response = await http.put(Uri.parse(url) ,
          headers: header == null ? _defaultHeader : header,
          body: json.encode(body));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, {body, Map<String, String>? header}) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(url),
          headers: header == null ? _defaultHeader : header,
          body: json.encode(body));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getWithDio(String url, {Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response = await Dio().get(url,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            headers: headers,
          ));
      responseJson = _dioResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postWithDio(String url,{ Map<String, String>? body, Map<String, String>? headers}) async {
    var responseJson;
    try {
      final response = await Dio().post(url,
          data: body,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            headers: headers,
          ));
      responseJson = _dioResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> putDataWithDio({
    required String? Url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    required Map<String, dynamic>? body,
  }) async {
    var _response ;
   try{
     _response =  await Dio().put(
       Url.toString(),
       data: body,
       queryParameters: query ?? null,
       options: Options(
         followRedirects: false,
         validateStatus: (status) {
           return status! < 500;
         },
         headers: headers == null ? _defaultHeader : headers,
       ),
     );
   } on SocketException {
     throw FetchDataException('No Internet connection');
   }
   return _response;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return {'status_code': 200, 'response': responseJson};
      case 422:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return {'status_code': 422, 'response': responseJson};

      case 400:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return {'status_code': 400, 'response': responseJson};

      case 401:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return {'status_code': 401, 'response': responseJson};
      case 424:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return {'status_code': 424, 'response': responseJson};
      case 405:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return {'status_code': 405, 'response': responseJson};
      // case 403:
      //   throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic _dioResponse(Response<dynamic> response) {
    var responseJson;
    switch (response.statusCode) {
      case 200:
        responseJson = response.data;
        print(responseJson);
        return {'status_code': 200, 'response': responseJson};
      case 400:
        responseJson = response.data;
        print(responseJson);
        return {'status_code': 400, 'response': responseJson};
      case 405:
        responseJson = response.data;
        print(responseJson);
        return {'status_code': 405, 'response': responseJson};
      case 422:
        responseJson = response.data;
        print(responseJson);
        return {'status_code': 422, 'response': responseJson};
      case 401:
      case 403:
        throw UnauthorisedException(response.data);
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
