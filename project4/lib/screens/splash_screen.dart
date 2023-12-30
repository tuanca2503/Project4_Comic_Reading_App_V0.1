import 'package:flutter/material.dart';
import 'package:project4/widgets/base_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
