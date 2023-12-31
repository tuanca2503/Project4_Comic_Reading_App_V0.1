import 'package:project4/models/users/user_login_res.dart';

class User {
  String? id;
  String? username;
  String? email;
  String? avatar;
  bool? isReceiveNotification;

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        avatar = json['avatar'],
        isReceiveNotification = json['isReceiveNotification'] ?? false;

  User.fromUserLogin(UserLoginRes userLogin)
      : id = userLogin.userId,
        username = userLogin.username,
        email = userLogin.email,
        avatar = userLogin.avatar,
        isReceiveNotification = userLogin.isReceiveNotification ?? false;

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "avatar": avatar,
        "isReceiveNotification": isReceiveNotification,
      };
}
