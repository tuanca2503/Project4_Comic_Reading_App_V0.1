import 'package:flutter/material.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/widgets/base_widget.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key, required this.baseConstraints});
  final BoxConstraints baseConstraints;

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      setBottomBar: true,
      chooseBottomicon: 3,
      baseConstraints: widget.baseConstraints,
      setBody: Container(),
      setAppBar: 2,
    );
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
