import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'app_exceptions.dart';

class BaseClient {
  static const int TIME_OUT_DURATION = 60;
  //GET
  Future<dynamic> get(String baseUrl, String api, String? queryString, String? bearerToken) async {
    var uri = Uri.parse(baseUrl + api + (queryString ?? ''));
    try {
      var response = await http.get(uri, headers: headers(bearerToken)).timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    } on UnAuthorizedException {
      throw UnAuthorizedException('UnAuthorized request', uri.toString());
    } on Exception {
      throw FetchDataException('Error occured with code : ${uri.toString()}', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj, String? bearerToken) async {

    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);

    // print ('payload: $payload');

    try {
      var response = await http
          .post(uri, body: payload, headers: headers(bearerToken))
          .timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time', uri.toString());
    } on UnAuthorizedException {
      throw UnAuthorizedException('UnAuthorized request', uri.toString());
    }

    // on Exception {
    //   throw FetchDataException('Error occured with code : ${uri.toString()}', uri.toString());
    // }
  }

  //DELETE
  //OTHER

  dynamic _processResponse(http.Response response) {
    var jsonData = json.decode(response.body);
    print ('status ${response.statusCode}');
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        throw BadRequestException(utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        var message = 'Error occured with code : ${response.statusCode}\n${jsonData['title']}';
        throw FetchDataException(message, response.request!.url.toString());
    }
  }

  Map<String, String> headers(String? bearerToken) {
    Map<String, String> headers = {'Content-Type': 'application/json', 'Accept': '*/*'};

    if (!(bearerToken == null || bearerToken.trim().isEmpty)) {
      headers['Authorization'] = 'Bearer $bearerToken';
    }

    return headers;
  }
}