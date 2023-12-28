class User {
  String username;
  String email;
  String? avatar;
  bool isReceiveNotification;

  User.empty()
      : username = '',
        email = '',
        avatar = null,
        isReceiveNotification = false;

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        avatar = json['avatar'],
        isReceiveNotification = json['isReceiveNotification'] ?? false;

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "avatar": avatar,
        "isReceiveNotification": isReceiveNotification,
      };
}
