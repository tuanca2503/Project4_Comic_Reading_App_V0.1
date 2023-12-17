import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/users/user_info.dart';

late final SharedPreferences sharedPreferences;

late BoxConstraints baseConstraints;
late UserInfo userInfo;

enum FlutterSecureStorageEnum { accessToken, refreshToken }

enum SharedPreferencesEnum { email, avatar, username }

enum AuthorizationPrefix { Bearer, Refresh }
