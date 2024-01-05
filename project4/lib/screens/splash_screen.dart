import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/main.dart';
import 'package:project4/models/users/user.dart';
import 'package:project4/repositories/auth_repository.dart';
import 'package:project4/screens/main_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/socket_helper.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/widgets/base_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> startTimer() async {
    final storage = Storages.instance;
    final screenProvider = GetIt.instance<ScreenProvider>();
    User? userLogin = storage.getUser();
    bool expRefreshToken = await storage.isValidRefreshToken();

    if (storage.isLogin() && expRefreshToken) {
      SocketHelper.instance.activate();
    } else {
      AuthRepository.instance.logout();
    }
    Timer(const Duration(seconds: 1), () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const MainScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.cover,
              child: BaseWidget.instance.getBackground(context: context),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: AppColor.overlayActive,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: AppDimension.baseConstraints.maxHeight * 0.45,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Comic Reading',
                style: TextStyle(
                    color: AppColor.onOverlay,
                    fontSize: AppFontSize.headline1,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
