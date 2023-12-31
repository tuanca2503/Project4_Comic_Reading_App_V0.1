import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/models/notification/notification_pass_data.dart';

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

  static Future<bool> navigatorPopWithMessage(
      BuildContext context, NotificationPassData notification) {
    return Navigator.maybePop(context, notification);
  }

  static void dialogPop(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: AppColor.onToast),
        ),
        action: null,
        backgroundColor: AppColor.error,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: AppColor.onToast),
        ),
        action: null,
        backgroundColor: AppColor.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void debug(dynamic body) {
    if (kDebugMode) {
      print(body);
    }
  }

  static String? showTimeUpdatedComic(int lastUpdatedDate) {
    int currentTs = DateTime.now().millisecondsSinceEpoch;
    int gapTime = ((currentTs - lastUpdatedDate) / 1000).round();
    if (gapTime < 60 * 60) {
      return '${(gapTime / 60).round()} phút trước';
    } else if (gapTime < 60 * 60 * 24) {
      return '${(gapTime / 60 / 60).round()} giờ trước';
    } else if (gapTime < 60 * 60 * 24 * 30) {
      return '${(gapTime / 60 / 60 / 24).round()} ngày trước';
    }
    return null;
  }
}
