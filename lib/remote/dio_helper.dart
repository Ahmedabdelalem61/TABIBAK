import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper{
  static Dio? dio;
  static init()
  {
    dio = Dio(
        BaseOptions(
            baseUrl: 'https://tabiba.herokuapp.com/account/api/',
            receiveDataWhenStatusError: true,

        )
    );
  }
  static Future<Response>  getData({
    @required String? endPoint,
     Map<String,dynamic>? query,
   }
   )async{
    dio!.options.headers = {
      'Content-Type':'application/json'
    };
   return await dio!.get(endPoint!,queryParameters: query??null);
  }

  static Future<Response>  postData({
    Map<String,dynamic>? query,
    @required Map<String,dynamic>? data,
    @required String? endPoint
  }
      )async{
    dio!.options.headers = {
      'Content-Type':'application/json'
    };
    return  dio!.post(endPoint!,data: data,queryParameters: query??null);
  }

  static Future<Response>  putData({
    @required String? endPoint,
    Map<String,dynamic>? query,
    @required Map<String,dynamic>? data,
    String lang = 'en',
    String? token
  }
      )async{
    dio!.options.headers = {
      'Content-Type':'application/json'
    };
    return dio!.put(endPoint!,data: data,queryParameters: query??null);
  }
}