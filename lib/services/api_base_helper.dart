import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import 'app_exception.dart';
import 'local_storage_service.dart';

class ApiBaseHelper {

  Future<String?> getToken() {
    return LocalStorageService.getJWT();
  }

  Future<String> get({required String url, Map<String, dynamic>? qParams}) async {
    var responseJson;
    try {
      Map<String, String> headers = await getHeaders();
      Uri uri = Uri.parse(url);
      if (qParams != null) {
        uri = uri.replace(queryParameters: qParams);
      }
      print(uri.path);
      final response = await http.get(uri, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(Consts.ERROR_MSG_FETCH_DATA_EXCEPTION);
    }
    return responseJson;
  }

  Future<String> post(String url, dynamic obj) async {
    var responseJson;
    try {
      Map<String, String> headers = await getHeaders();
      print(json.encode(obj));
      final response = await http.post(Uri.parse(url),
          body: json.encode(obj),
          headers: headers
      );
          // .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on UnauthorizedException {
      throw UnauthorizedException(Consts.ERROR_MSG_FETCH_DATA_EXCEPTION);
    }on SocketException {
      throw FetchDataException(Consts.ERROR_MSG_FETCH_DATA_EXCEPTION);
    }
    return responseJson;
  }

  Future<String> delete(String url) async {
    var responseJson;
    try {
      Map<String, String> headers = await getHeaders();
      final response = await http.delete(Uri.parse(url),
          headers: headers
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(Consts.ERROR_MSG_FETCH_DATA_EXCEPTION);
    }
    return responseJson;
  }

  Future<String> patch({required String url, required dynamic obj}) async {
    var responseJson;
    try {
      Map<String, String> headers = await getHeaders();
      final response = await http.patch(Uri.parse(url),
          body: json.encode(obj),
          headers: headers
      );
      // .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(Consts.ERROR_MSG_FETCH_DATA_EXCEPTION);
    }
    return responseJson;
  }

  Future<String> put(String url, dynamic obj) async {
    var responseJson;
    try {
      Map<String, String> headers = await getHeaders();
      final response = await http.put(Uri.parse(url),
          body: json.encode(obj),
          headers: headers
      );
      // .timeout(const Duration(seconds: 10));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(Consts.ERROR_MSG_FETCH_DATA_EXCEPTION);
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return const Utf8Decoder().convert(response.bodyBytes);
      case 400:
        throw BadRequestException(const Utf8Decoder().convert(response.bodyBytes));
      case 401:
      case 403:
        throw UnauthorizedException(const Utf8Decoder().convert(response.bodyBytes));
      case 500:
      case 515:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }

  Future<Map<String, String>> getHeaders() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    String? token = await getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<Map<String, String>> getFormDataHeaders() async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    String? token = await getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

}