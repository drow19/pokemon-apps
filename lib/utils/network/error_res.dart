import 'package:dio/dio.dart';

class ErrorRes {
  int code = 0;
  String message = "";
  Response? response;
  String methodUrl = "GET";

  ErrorRes(response,{String method = "GET"}) {
    if (response is Response && response.statusCode != null) {
      code = response.statusCode!;
      this.response = response;
    }
    methodUrl = method;
    message = getErrorMessage(response);
  }

  static String getErrorMessage(response) {
    if (response is Response) {
      try {
        var res = response.data;
        if (res.meta.message.isNotEmpty) {
          return res.meta.message;
        }
      } catch (e) {
        return response.toString();
      }
      switch (response.statusCode) {
        case 200:
        case 201:
        case 202:
          return "Success";
        case 400:
          return "Sorry, we couldn't process the request. Please try again later.";
        case 401:
          return "Your session has ended";
        case 404:
          return "The resource you are looking is temporarily unavailable. Please try again later.";
        case 405:
          return "Method not allowed";
        case 500:
          return "Sorry, we couldn't process the request. Please try again later.";
        default:
          if (response.data.connectionError) {
            return 'Connection Timeout. Please try again later.';
          }
          if (response.statusMessage != null && response.statusMessage!.isNotEmpty) {
            return response.statusMessage!;
          }
          return 'Unknown error.';
      }
    } else {
      return response.toString();
    }
  }

  @override
  String toString() {
    return message;
  }
}