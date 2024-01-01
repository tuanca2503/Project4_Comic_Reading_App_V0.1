import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/users/user.dart';
import 'package:project4/utils/helper.dart';


class UserRepository {
  static UserRepository? _instance;
  UserRepository._();

  static UserRepository get instance {
    _instance ??= UserRepository._();
    return _instance!;
  }

  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/user';

  Future<User> getUserInfo() async {
    try {
      final Response response = await dio.get(
        '$_apiBase/get-information',
      );
      if (response.statusCode != 200) {
        Helper.debug("///ERROR getUserInfo: ${response.data}///");
        throw Exception(response.data);
      }
      User user = User.fromJson(response.data);
      return user;
    } catch (e) {
      Helper.debug("///ERROR getUserInfo: $e///");
      throw Exception(e);
    }
  }

  Future<void> updateUserInfo({required String username, required String avatar}) async {
    try {
      final Response response =
          await dio.post('$_apiBase/update-information', data: {
            'username': username,
            'avatar': avatar,
          });
      if (response.statusCode != 200) {
        Helper.debug("///ERROR at updateUserInfo: ${response.data}///");
        throw Exception(response.data);
      }
    } catch (e) {
      Helper.debug("///ERROR at updateUserInfo: $e///");
      throw Exception(e);
    }
  }

  Future<bool> toggleReceiveNotification() async {
    try {
      final Response response =
      await dio.post('$_apiBase/toggle-receive-notification', data: {});
      if (response.statusCode != 200) {
        Helper.debug("///ERROR at updateUserInfo: ${response.data}///");
        throw Exception(response.data);
      }
      return response.data;
    } catch (e) {
      Helper.debug("///ERROR at updateUserInfo: $e///");
      throw Exception(e);
    }
  }
}
