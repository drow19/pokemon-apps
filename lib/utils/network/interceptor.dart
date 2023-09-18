import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pokedex/utils/commons/constan.dart';

requestInterceptor(Request request) {
  if (kDebugMode) {
    var message = {
      'REQUEST URL:': request.url,
      'REQUEST HEADER:': request.headers,
      'REQUEST METHOD:': request.method,
    };
    debugPrint('$message');
  }
  return request;
}

responseInterceptor(Request request, Response response,
    [bool redirect = true]) {
  var message = <String, dynamic>{
    'RESPONSE URL:': request.url,
    'RESPONSE CODE:': response.statusCode,
    'RESPONSE MESSAGE:': response.statusMessage,
    'RESPONSE BODY:': response.data,
    'RESPONSE UNAUTHORIZED:': response.headers,
  };
  debugPrint('$message');
  if (redirect) {
    GetStorage().remove(kToken);
  }
  return response;
}
