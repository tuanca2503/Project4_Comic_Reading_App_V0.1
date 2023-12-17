import 'package:flutter/material.dart';
import 'package:project4/widgets/bottom_bar_widget.dart';
import 'package:project4/widgets/header_bar_widgeet.dart';

import '../utils/constants.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen(
      {super.key,
      required this.setBody,
      this.setAppBar = 0,
      this.setBottomBar = false,
      this.chooseBottomIcon = 0,
      this.setMoveUp = false});

  final int setAppBar;
  final Widget setBody;
  final bool setBottomBar;
  final bool setMoveUp;

  final int chooseBottomIcon;

  //send data ->base->bottom

  @override
  Widget build(BuildContext context) {
    Color colorTheme = const Color(0xFF080401);

    double heightHeadBottom = baseConstraints.maxHeight * 0.09;

    ScrollController scrollController = ScrollController();

    /// base repo
    ///
    ///
    ///

    return Scaffold(
      /////////////////////////////////

      body: Container(
        //-----
        color: colorTheme,

        child: ListView(
          controller: scrollController,
          children: [
            //appBar

            HeaderBarWidget(
              heightHead: heightHeadBottom,
              typeHeader: setAppBar,
              padding: 10,
              colorTheme: colorTheme,
              baseConstraints: baseConstraints,
            ), // SizedBox(
            //   child: LayoutBuilder(
            //     builder: (context, constraints) {
            //       return ;
            //     },
            //   ),
            // ),

            //body
            setBody,

            setMoveUp
                ? Container(
                    height: 50,
                    // color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () {
                        scrollController.animateTo(
                          0.0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text(
                        "Lên đầu trang",
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),

      ////////////////////////////////////
      bottomNavigationBar: setBottomBar
          ? SizedBox(
              height: heightHeadBottom,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return BottomBarWidget(
                    chooseBottomIcon: chooseBottomIcon,
                    padding: 10,
                    colorTheme: colorTheme,
                  );
                },
              ),
            )
          : null,
      ///////////////////////////////
    );
  }
}
