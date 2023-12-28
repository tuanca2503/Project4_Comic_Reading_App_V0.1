import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/users/user_login_res.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/utils/string_utils.dart';

import '../widgets/base_widget.dart';

class Helper {
  Helper._();

  static void navigatorPush(
      {required BuildContext context,
      required Widget screen,
      bool isReplace = false}) {
    if (isReplace) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );
    }
  }

  static Future<bool> navigatorPop(BuildContext context) {
    return Navigator.maybePop(context);
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Theme.of(context).colorScheme.onSurface),),
        action: null,
        backgroundColor: Colors.greenAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Theme.of(context).colorScheme.onSurface),),
        action: null,
        backgroundColor: Colors.greenAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void debug(dynamic body) {
    if (kDebugMode) {
      print(body);
    }
  }
}
