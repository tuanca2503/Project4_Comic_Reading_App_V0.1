import 'dart:convert';

import 'package:get/get.dart';
import 'package:project4/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class HandleResponseAPI {
  //////
  dynamic accessTokenToData({
    required dynamic json,
  }) {
    // data[nameAccessToken];

    JWT jwt = JWT.decode(getAccessToken(json: json));
    //  final Map<String, dynamic> payloadData = jwt.payload; ////token to json
    return jwt;

    ///
    // return User(
    //     nameUser: payloadData['username'],
    //     email: payloadData['sub'],
    //     exp: payloadData['exp'],
    //     iat: payloadData['iat']);
  }

  ////////
  String getAccessToken({
    required dynamic json,
    String nameAccessToken = 'accessToken',
  }) {
    return jsonDecode(json)[nameAccessToken];
  }

  String getRefreshToken({
    required dynamic json,
    String nameAccessToken = 'refreshToken',
  }) {
    return jsonDecode(json)[nameAccessToken];
  }

  ////////////////////// Response?
  Future<dynamic> callAPI(
      {required String method,
      String ip = 'http://localhost',
      String port = '',
      required String api,
      Map<String, String> apiHeader = const {
        'accept': '*/*',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      Map<String, String> apiBody = const {}}) async {
    String url = '${ip}${port}${api}';
    print(url);
    // apiBody = jsonEncode(apiBody);

    switch (method.toLowerCase()) {
      case 'get':
        final http.Response response = await http.get(
          Uri.parse(url),
          headers: apiHeader,
        );
        return ResultCallAPI(
          response: response,
        );

      case 'post':
        final http.Response response = await http.post(Uri.parse(url),
            headers: apiHeader, body: jsonEncode(apiBody));
        return ResultCallAPI(
          response: response,
        );

      case 'put':
        return http.put(Uri.parse(url),
            headers: apiHeader, body: jsonEncode(apiBody));

      case 'delete':
        return http.delete(Uri.parse(url),
            headers: apiHeader, body: jsonEncode(apiBody));

      default:
        return null;
    }
  }

  ResultCallAPI getErrReturn(e) {
    return ResultCallAPI(
        response: http.Response.bytes([int.parse(e.toString())], 404));
  }

  ///////////////////////////
}

class ResultCallAPI {
  final http.Response response;
  dynamic data;
  int code = 404;
  bool check = false;
  String mess = '';
  ResultCallAPI({
    required this.response,
    this.data,
  }) {
    checkStatusCode();
  }

  void checkStatusCode() {
    code = response.statusCode;
    switch (code) {
      case 200:
        check = true;
        mess = "Successful Code: $code";
        break;
      // return [true, "Successful Code: $statusCode"];

      case 201:
        check = true;
        mess = "Created Code $code";
        break;

      case 401:
        check = false;
        mess = "Unauthorized Code: $code";
        break;
      case 403:
        check = false;
        mess = "Forbidden Code: $code";
        break;
      case 500:
        check = false;
        mess = "Error Internal Server Code: $code";
        break;

      case 404:
      default:
        check = false;
        mess = "Not Found Code: $code";
        break;
    }
  }
}
