import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class User {
  String id;
  String username;
  String email;
  String? avatar;
  String idUser;
  String accessToken;
  String refreshToken;
  //
  int exp;
  int iat;
  //
  final List<Language> languages = Language().seed();
  final List<ThemeApp> themeApp = ThemeApp().seed();
  Notification notification = Notification();
  User({
    this.id = '',
    this.refreshToken = '',
    this.accessToken = '',
    this.idUser = '',
    this.username = '',
    this.email = '',
    this.exp = 0,
    this.iat = 0,
    this.avatar = 'th.jpg',
  });
  ThemeApp switchTheme({required bool choose}) {
    ThemeApp data;
    (themeApp.length == 2)
        ? choose
            ? data = themeApp[0]
            : data = themeApp[1]
        : data = themeApp[0];

    return data;
  }

  //
  List<User> seed() {
    return List.generate(
      10,
      (index) => User(
        //
        idUser: "MTU${Random().nextInt(200) + 10 + index}",
        username: "MTU${index + 1}",

        email: "User${index + 1}@MTU.com",

        ///
      ),
    );
  }

  void setDataFromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
  }
}
/////

class Language {
  final String key;
  final String name;
  Language({
    this.key = '',
    this.name = '',
  });
  List<Language> seed() {
    return [
      Language(key: 'vie', name: 'Việt Nam'),
      Language(key: 'eng', name: 'English'),
    ];
  }
}

class ThemeApp {
  final String themeName;
  final Color backgroundColor;
  final Color textColor;
  /////
  ThemeApp({
    this.themeName = "",
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
  });
  //
  List<ThemeApp> seed() {
    return [
      ThemeApp(
          themeName: 'Black',
          backgroundColor: Colors.black,
          textColor: Colors.white),
      ThemeApp(
          themeName: 'White',
          backgroundColor: Colors.white,
          textColor: Colors.black),
    ];
  }
}

class Notification {
  bool enabled;
  List<NotificationData> notificationDatas;
  Notification({
    this.enabled = true,
    this.notificationDatas = const [],
  }) {
    notificationDatas.isEmpty
        ? notificationDatas = NotificationData().seed()
        : null;
  }
}

class NotificationData {
  final int id;
  final String imgAuthor;
  final String nameComic;
  final String date;
  final String chapter;
  final String part;
  NotificationData({
    this.id = 0,
    this.imgAuthor = "",
    this.nameComic = "",
    this.date = "",
    this.chapter = "",
    this.part = "",
  });
  List<NotificationData> seed() {
    return List.generate(10, (index) {
      return NotificationData(
        id: Random().nextInt(10) + 1,
        imgAuthor: 'th.jpg',
        nameComic: 'The Amazing Adventures of Comic Hero ${index + 1}',
        date: DateTime(2023, Random().nextInt(12) + 1, Random().nextInt(28) + 1)
            .toIso8601String(),
        chapter: '${index + 1}',
        part: '1',
      );
    });
  }
}
