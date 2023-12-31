import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project4/screens/main_screen.dart';
import 'package:project4/widgets/base_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTimer() {
    Timer(const Duration(seconds: 2), () async {
      Navigator.push(context, MaterialPageRoute(builder: (c) => const MainScreen()));
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
          )
        ],
      ),
    );
  }
}
