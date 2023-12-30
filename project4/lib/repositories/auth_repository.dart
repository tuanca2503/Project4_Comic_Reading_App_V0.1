import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/main.dart';
import 'package:project4/models/users/user.dart';
import 'package:project4/models/users/user_login_res.dart';
import 'package:project4/repositories/user_repository.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/storages.dart';


class AuthRepository {
  static AuthRepository? _instance;
  AuthRepository._();

  static AuthRepository get instance {
    _instance ??= AuthRepository._();
    return _instance!;
  }

  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/auth';
  final _storage = Storages.instance;
  final userRepository = UserRepository.instance;
  final screenProvider = GetIt.instance<ScreenProvider>();

  Future<UserLoginRes> loginUser(
      {required String email, required String password}) async {
    UserLoginRes userLogin = UserLoginRes();
    try {
      final Response response = await dio.post('$_apiBase/free/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode != 200) {
        Helper.debug(
            "///ERROR at loginUser with statusCode = ${response.statusCode}, error = ${response.data}///");
        throw Exception(response.data);
      }
      // save token and user info
      userLogin = UserLoginRes.fromJson(response.data);
      await _storage.setToken(userLogin.accessToken, userLogin.refreshToken);
      await _storage.setUser(User.fromUserLogin(userLogin));

      // notify to change bottom avatar
      screenProvider.updateUserInfo(userLogin.email);
      return userLogin;
    } catch (e) {
      Helper.debug("///ERROR at loginUser(): $e///");
      throw Exception(e);
    }
  }

  Future<void> logout() async {
    try {
      await _storage.clearStorage();
      screenProvider.updateUserInfo(null);
    } catch (e) {
      Helper.debug("///ERROR at logout(): $e///");
      throw Exception(e);
    }
  }

  Future<Response?> registerUser(
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
        Helper.debug("///ERROR at registerUser: ${response.data}///");
        throw Exception(response.data);
      }
      return response;
    } catch (e) {
      Helper.debug("///ERROR at registerUser: $e///");
      throw Exception(e);
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      final Response response =
          await dio.post('$_apiBase/free/forgot-password', data: {
        'email': email,
      });
      if (response.statusCode != 200) {
        Helper.debug("///ERROR at forgotPassword: ${response.data}///");
        throw Exception(response.data);
      }
    } catch (e) {
      Helper.debug("///ERROR at forgotPassword: $e///");
      throw Exception(e);
    }
  }

  Future<void> updatePassword({required String oldPassword, required String newPassword}) async {
    try {
      final Response response =
      await dio.post('$_apiBase/change-password', data: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });
      if (response.statusCode != 200) {
        Helper.debug("///ERROR at forgotPassword: ${response.data}///");
        throw Exception(response.data);
      }
    } catch (e) {
      Helper.debug("///ERROR at forgotPassword: $e///");
      throw Exception(e);
    }
  }

  Future<void> updatePasswordByCode({required String code, required String email, required String newPassword}) async {
    try {
      final Response response =
      await dio.post('$_apiBase/free/change-password-by-token', data: {
        'email': email,
        'code': code,
        'newPassword': newPassword,
      });
      if (response.statusCode != 200) {
        Helper.debug("///ERROR at forgotPassword: ${response.data}///");
        throw Exception(response.data);
      }
    } catch (e) {
      Helper.debug("///ERROR at forgotPassword: $e///");
      throw Exception(e);
    }
  }
}
