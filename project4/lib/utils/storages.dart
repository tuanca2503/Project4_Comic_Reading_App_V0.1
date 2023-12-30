import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project4/models/users/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _SharedPreferencesEnum { user, darkMode }

enum _FlutterSecureStorageEnum { accessToken, refreshToken }

class Storages {
  static Storages? _instance;

  static Storages get instance => _instance!;

  Storages._();

  late SharedPreferences _sharedPreferences;
  late FlutterSecureStorage _flutterSecureStorage;

  static initialize() async {
    if (_instance == null) {
      _instance = Storages._();
      _instance!._sharedPreferences = await SharedPreferences.getInstance();
      _instance!._flutterSecureStorage = const FlutterSecureStorage();
    }
  }

  Set<String> getKeys() {
    return _sharedPreferences.getKeys();
  }

  bool isLogin() => getUser() != null;

  User? getUser() {
    final user = _sharedPreferences.getString(_SharedPreferencesEnum.user.name);
    return user == null ? null : User.fromJson(jsonDecode(user));
  }

  Future<bool> setUser(User? user) {
    return _sharedPreferences.setString(
        _SharedPreferencesEnum.user.name, jsonEncode(user?.toJson()));
  }

  bool getIsNotify() {
    User user = getUser()!;
    return user.isReceiveNotification ?? false;
  }

  Future<bool> setIsNotify(bool isNotify) {
    User user = getUser()!;
    user.isReceiveNotification = isNotify;
    return setUser(user);
  }

  bool isDarkMode() {
    return _sharedPreferences.getBool(_SharedPreferencesEnum.darkMode.name) ??
        false;
  }

  Future<bool> setDarkMode(bool isDarkMode) {
    return _sharedPreferences.setBool(
        _SharedPreferencesEnum.darkMode.name, isDarkMode);
  }

  Future<String?> getAccessToken() {
    return _flutterSecureStorage.read(
        key: _FlutterSecureStorageEnum.accessToken.name);
  }

  Future<String?> getRefreshToken() {
    return _flutterSecureStorage.read(
        key: _FlutterSecureStorageEnum.refreshToken.name);
  }

  Future<int?> getExpAccessToken() async {
    String? accessToken = await getAccessToken();
    if (accessToken == null) return null;

    return _getPayloadToken(accessToken)['exp'];
  }

  Future<int?> getExpRefreshToken() async {
    String? refreshToken = await getRefreshToken();
    if (refreshToken == null) return null;

    return _getPayloadToken(refreshToken)['exp'];
  }

  Future<void> setToken(String? accessToken, String? refreshToken) async {
    await _flutterSecureStorage.write(
        key: _FlutterSecureStorageEnum.accessToken.name, value: accessToken);
    await _flutterSecureStorage.write(
        key: _FlutterSecureStorageEnum.refreshToken.name, value: refreshToken);
  }

  Future<void> removeAccessToken() async {
    await _flutterSecureStorage.delete(
        key: _FlutterSecureStorageEnum.accessToken.name);
  }

  Future<void> removeRefreshToken() async {
    await _flutterSecureStorage.delete(
        key: _FlutterSecureStorageEnum.refreshToken.name);
  }

  Future<void> clearStorage() async {
    await _sharedPreferences.remove(_SharedPreferencesEnum.user.name);
    await _flutterSecureStorage.delete(
        key: _FlutterSecureStorageEnum.accessToken.name);
    await _flutterSecureStorage.delete(
        key: _FlutterSecureStorageEnum.refreshToken.name);
  }

  Map<String, dynamic> _getPayloadToken(String token) {
    JWT jwt = JWT.decode(token);
    /*{
      "sub": "string",
      "exp": 1703189772,
      "iat": 1703186172,
      "email": "string@gmail.com",
    }*/
    return jwt.payload;
  }
}
