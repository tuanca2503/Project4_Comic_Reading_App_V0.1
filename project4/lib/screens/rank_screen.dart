import 'package:flutter/material.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  @override
  Widget build(BuildContext context) {
    return bodyRankScreen();
  }

  Widget bodyRankScreen() {
    return Container();

    // return NotificationListener<ScrollNotification>(
    //   onNotification: (scrollNotification) {
    //     return false;
    //   },
    //   child: ,
    // );
  }
}
