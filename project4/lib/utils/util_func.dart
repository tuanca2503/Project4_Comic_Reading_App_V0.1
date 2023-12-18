import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:project4/config/environment.dart';

import '../widgets/base_widget.dart';
import 'constants.dart';

void debug(dynamic body) {
  if (kDebugMode) {
    print(body);
  }
}

bool checkStringIsNotEmpty(String? str) {
  return str != null && str.trim().isNotEmpty;
}

int getTsFromDateString(String date) {
  DateTime tempDate = DateFormat("dd/MM/yyy HH:mm:ss").parse(date);
  return tempDate.millisecond;
}

String updateAvatarUrl() {
  String? avatarUrl = sharedPreferences
      .getString(SharedPreferencesEnum.avatar.name);
  if (!checkStringIsNotEmpty(avatarUrl)) {
    return 'user.png';
  }
  return '${Environment.apiUrl}/images/$avatarUrl';
}

Widget getAvatarWidget() {
  String avatar = updateAvatarUrl();
  return avatar.startsWith('http')
      ? BaseWidget()
      .setImageNetwork(link: avatar)
      : BaseWidget().setImageAsset(avatar);
}

Map<String, dynamic> convertJwtToken(String token) {
  JWT jwt = JWT.decode(token);
  return jwt.payload;
}

Future<void> updateSharedPreferences(Map<String, dynamic> tokenPayload) async {
  await sharedPreferences.setString(
      SharedPreferencesEnum.avatar.name, tokenPayload['avatar'] ?? '');
  await sharedPreferences.setString(
      SharedPreferencesEnum.email.name, tokenPayload['email']);
  await sharedPreferences.setString(
      SharedPreferencesEnum.username.name, tokenPayload['username']);
}

Future<void> clearAllSharedPreferences() async {
  await sharedPreferences.remove(SharedPreferencesEnum.avatar.name);
  await sharedPreferences.remove(SharedPreferencesEnum.email.name);
  await sharedPreferences.remove(SharedPreferencesEnum.username.name);
}

Future<void> updateTokenStorage(String accessToken, String refreshToken) async {
  final flutterSecureStorage = GetIt.instance<FlutterSecureStorage>();
  await flutterSecureStorage.write(
      key: FlutterSecureStorageEnum.accessToken.name, value: accessToken);
  await flutterSecureStorage.write(
      key: FlutterSecureStorageEnum.refreshToken.name, value: refreshToken);
}

String formatDateFromTs(int ts) {
  return DateFormat('HH:mm dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(ts));
}

