class UserLoginRes {
  String? accessToken;
  String? refreshToken;
  String? userId;
  String? username;
  String? email;
  String? avatar;
  bool? isReceiveNotification;

  UserLoginRes();

  UserLoginRes.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        refreshToken = json['refreshToken'],
        userId = json['userId'],
        username = json['username'],
        email = json['email'],
        avatar = json['avatar'],
        isReceiveNotification = json['isReceiveNotification'];

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "avatar": avatar,
        "isReceiveNotification": isReceiveNotification,
      };
}
