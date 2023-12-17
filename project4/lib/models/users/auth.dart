import '../../utils/constants.dart';

class Auth {
  String accessToken;
  String refreshToken;

  Auth({
    this.accessToken = '',
    this.refreshToken = '',
  });

  Auth.fromJson(Map<String, dynamic> json)
      : accessToken = json[FlutterSecureStorageEnum.accessToken.name],
        refreshToken = json[FlutterSecureStorageEnum.refreshToken.name];
}
