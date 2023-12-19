import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/models/users/user.dart';

import '../config/environment.dart';
import '../utils/util_func.dart';

class UserRepository {
  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/user';

  UserRepository();

  Future<User> getUserInfo() async {
    User user = User.empty();
    try {
      final Response response = await dio.get(
        '$_apiBase/get-information',
      );
      if (response.statusCode != 200) {
        debug("///ERROR getUserInfo: ${response.data}///");
        throw Exception(response.data);
      }
      user = User.fromJson(response.data);
    } catch (e) {
      debug("///ERROR getUserInfo: $e///");
    }
    return user;
  }

  Future<void> updateUserInfo({required String userName}) async {
    try {
      final Response response =
          await dio.post('$_apiBase/update-information', data: {
        'username': userName,
      });
      if (response.statusCode != 200) {
        debug("///ERROR at updateUserInfo: ${response.data}///");
        throw Exception(response.data);
      }
    } catch (e) {
      debug("///ERROR at updateUserInfo: $e///");
    }
  }
}
