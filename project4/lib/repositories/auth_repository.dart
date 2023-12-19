import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/main.dart';
import 'package:project4/repositories/user_repository.dart';

import '../config/environment.dart';
import '../models/users/auth.dart';
import '../utils/util_func.dart';

class AuthRepository {
  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/auth';
  final flutterSecureStorage = GetIt.instance<FlutterSecureStorage>();
  final userRepository = GetIt.instance<UserRepository>();
  final screenProvider = GetIt.instance<ScreenProvider>();

  AuthRepository();

  Future<Auth> loginUser(
      {required String email, required String password}) async {
    Auth auth = Auth();
    try {
      final Response response = await dio.post('$_apiBase/free/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode != 200) {
        debug(
            "///ERROR at loginUser with statusCode = ${response.statusCode}, error = ${response.data}///");
        throw Exception(response.data);
      }
      auth = Auth.fromJson(response.data);
      await updateTokenStorage(auth.accessToken, auth.refreshToken);
      Map<String, dynamic> tokenPayload = convertJwtToken(auth.accessToken);
      updateSharedPreferences(tokenPayload);

      screenProvider.updateUserInfo(tokenPayload['email']);
    } catch (e) {
      debug("///ERROR at loginUser(): $e///");
    }
    return auth;
  }

  Future<void> logout() async {
    try {
      await flutterSecureStorage.deleteAll();
      clearAllSharedPreferences();
      screenProvider.updateUserInfo(null);
    } catch (e) {
      debug("///ERROR at logout(): $e///");
    }
  }

  Future<void> registerUser(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      final Response response =
          await dio.post('$_apiBase/free/register', data: {
        'email': email,
        'password': password,
        'username': userName,
      });
      if (response.statusCode != 200) {
        debug("///ERROR at registerUser: ${response.data}///");
        throw Exception(response.data);
      }
    } catch (e) {
      debug("///ERROR at registerUser: $e///");
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      final Response response =
          await dio.post('$_apiBase/free/forgot-password', data: {
        'email': email,
      });
      if (response.statusCode != 200) {
        debug("///ERROR at forgotPassword: ${response.data}///");
        throw Exception(response.data);
      }
    } catch (e) {
      debug("///ERROR at forgotPassword: $e///");
    }
  }
}
