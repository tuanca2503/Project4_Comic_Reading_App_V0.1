import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project4/utils/constants.dart';

class User {
  String username;
  String email;
  String? avatar;
  bool isReceiveNotification;

  final List<Language> languages = Language().seed();
  final List<ThemeApp> themeApp = ThemeApp().seed();
  Notification notification = Notification();

  User.empty()
      : username = '',
        email = '',
        avatar = null,
        isReceiveNotification = false;

  ThemeApp switchTheme({required bool choose}) {
    ThemeApp data;
    (themeApp.length == 2)
        ? choose
            ? data = themeApp[0]
            : data = themeApp[1]
        : data = themeApp[0];

    return data;
  }

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        avatar = json['avatar'],
        isReceiveNotification = json['isReceiveNotification'] ?? false;
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
