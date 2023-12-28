import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/users/user_login_res.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/utils/string_utils.dart';

class BaseWidget {
  final String _imageAsset = 'assets/images/';
  static BaseWidget? _instance;

  BaseWidget._();

  static BaseWidget get instance {
    _instance ??= BaseWidget._();
    return _instance!;
  }

  Widget getAvatarWidget({double? size}) {
    UserLoginRes? userLoginRes = Storages.instance.getUserLogin();
    if (userLoginRes == null || !userLoginRes.avatar.isHasText) {
      return setImageAsset(link: 'user.png', size: size);
    } else {
      return setImageNetwork(
          link: '${Environment.apiUrl}/images/${userLoginRes.avatar}',
          size: size);
    }
  }

  Widget getLogoApp({required BuildContext context, double scale = 0.7}) {
    String logo = context.isDarkMode ? 'logo_white.png' : 'logo_black.png';
    return Transform.scale(
      scale: scale,
      child: Image.asset('$_imageAsset/$logo'),
    );
  }

  Widget getBackground({required BuildContext context}) {
    String background =
        context.isDarkMode ? 'background.png' : 'background.png';
    return Image.asset('$_imageAsset/$background');
  }

  Transform setImageAsset(
      {required String link,
      BoxFit fit = BoxFit.cover,
      double scale = 1,
      double? size}) {
    return Transform.scale(
        scale: scale,
        child: Image.asset(
          '$_imageAsset/$link',
          fit: fit,
          height: size,
          width: size,
        ));
  }

  Image setImageNetwork(
      {required String link, BoxFit fit = BoxFit.cover, double? size}) {
    return Image.network(
      height: size,
      width: size,
      link.startsWith('http') ? link : '${Environment.apiUrl}/$link',
      headers: const {
        'ngrok-skip-browser-warning': 'true',
      },
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          '$_imageAsset/background.png',
          fit: fit,
        );
      },
    );
  }

  Icon setIcon({required IconData iconData, Color? color, size = 24}) {
    return Icon(
      iconData,
      color: color,
      size: size,
    );
  }

  Widget loadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget emptyWidget() {
    return SizedBox(
      height: AppDimension.baseConstraints.maxHeight * 0.4,
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.insert_drive_file,
              size: 48.0,
              color: Colors.grey,
            ),
            SizedBox(height: 8.0),
            Text(
              'Danh sách trống',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget setFutureBuilder(
      {required Function(dynamic) callback, required repo}) {
    return FutureBuilder(
      future: repo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('hasError: $snapshot');
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.done) {
          return callback(snapshot);
        } else {
          print('ELSE: $snapshot');
          return Container();
        }
      },
    );
  }

  Widget setStreamBuilder(
      {required Function(dynamic) callback,
      required StreamController streamController}) {
    return StreamBuilder(
      stream: streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            // fake center screen (in singleScroll -> cannot use Expanded)
            height: AppDimension.baseConstraints.maxHeight * 0.5,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          Helper.debug('hasError: $snapshot');
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return callback(snapshot);
        } else {
          Helper.debug('ELSE setStreamBuilder: $snapshot');
          return Container();
        }
      },
    );
  }

  Widget handleEventNavigation(
      {required Widget child,
      required Widget pageTo,
      required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pageTo,
          ),
        );
      },
      child: child,
    );
  }

  Widget handleEventBackNavigation(
      {required Widget child, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: child,
    );
  }

  Text setText(
      {required String txt,
      double? fontSize = 18,
      FontWeight fontWeight = FontWeight.bold,
      Color color = Colors.white,
      TextOverflow? textOverflow,
      double letterSpacing = 0,
      TextAlign textAlign = TextAlign.center,
      String fontFamily = ''}) {
    return Text(
      txt,
      maxLines: 1,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          overflow: TextOverflow.ellipsis,
          letterSpacing: letterSpacing,
          fontFamily: fontFamily),
      textAlign: textAlign,
    );
  }
}
