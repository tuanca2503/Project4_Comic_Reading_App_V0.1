import 'dart:io';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get.dart';
import 'package:project4/config.dart';
import 'package:project4/models/handle_response_api.dart';
import 'package:project4/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';

class UserRepository {
  User _user = User();

  String ip;
  String port;
  UserRepository({required this.ip, required this.port});

  ///
  User fetchUserData() {
    // Make an API call to fetch user data using the stored token
    Future.delayed(Duration(seconds: 2));
    return _user;
  }

  ///
  Future<ResultCallAPI> loginUser(
      {required String email, required String password}) async {
    try {
      final ResultCallAPI response = await HandleResponseAPI().callAPI(
        method: 'post',
        ip: ip,
        port: port,
        api: 'api/auth/free/login',
        apiBody: {
          'email': email,
          'password': password,
        },
      );

      ///////////////////////////////
      if (response.check) {
        //set token
        _user.accessToken =
            HandleResponseAPI().getAccessToken(json: response.response.body);
        _user.refreshToken =
            HandleResponseAPI().getRefreshToken(json: response.response.body);
        saveRefreshTokenInCookie(_user.refreshToken);
        await getInforUser(accessToken: _user.accessToken);
      }
      return response;
    } catch (e) {
      print("///ERROR: $e///");
      return ResultCallAPI(
          response: http.Response.bytes([int.parse(e.toString())], 404));
    }
  }

  Future<dynamic> registerUser(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      final ResultCallAPI response = await HandleResponseAPI().callAPI(
        method: 'post',
        port: port,
        ip: ip,
        api: 'api/auth/free/register',
        apiBody: {
          'email': email,
          'password': password,
          'username': userName,
        },
      );

      return response;
    } catch (e) {
      print("///ERROR: $e///");
      return false;
    }
  }

  ///////////////////////////////////
  Future<dynamic> forgotPassword({required String email}) async {
    try {
      final ResultCallAPI response = await HandleResponseAPI().callAPI(
        method: 'post',
        port: port,
        ip: ip,
        api: 'api/auth/free/forgot-password',
        apiBody: {
          'email': email,
        },
      );

      return response;
    } catch (e) {
      print("///ERROR: $e///");
      return false;
    }
  }

  ///
  ///

  Future<dynamic> getInforUser({required String accessToken}) async {
    try {
      final ResultCallAPI response = await HandleResponseAPI().callAPI(
          method: 'get',
          port: port,
          ip: ip,
          api: 'api/user/get-information',
          apiHeader: {
            'Authorization': 'Bearer ${accessToken}',
            'Content-Type': 'application/json',
          });

      if (response.check) {
        _user.setDataFromJson(json.decode(response.response.body));
      }
    } catch (e) {
      print("///ERROR: $e///");
      return false;
    }

    return null;
  }

  void saveRefreshTokenInCookie(String refreshToken) async {
    try {
      var dio = Dio();

      // Xác định CookieJar
      var cookieJar = CookieJar();
      dio.interceptors.add(CookieManager(cookieJar));

      // Thực hiện một request mẫu để thiết lập cookie ban đầu
      await dio.get('https://example.com/dummy');

      // Đặt cookie của refresh token
      cookieJar.saveFromResponse(Uri.parse('https://example.com'), [
        Cookie('refreshToken', refreshToken),
      ]);
      print('Refresh token đã được lưu vào cookie');
    } catch (e) {
      print(e);
    }
  }

// //
//   Future<User?> getUser() async {
//     final user = await fetchUsers();
//     return user;
//   }

// //
//   Future<void> updateUser(User user) async {
//     // final Users = await fetchUsers();
//     print("update  User:${this.user!.nameUser}, code:${this.user!.idUser}");
//     this.user = user;
//   }
}
