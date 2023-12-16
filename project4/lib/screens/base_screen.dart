import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/models/handle_response_api.dart';
import 'package:project4/repositories/base_repository.dart';
import 'package:project4/repositories/user_repository.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/bottom_bar_widget.dart';
import 'package:project4/widgets/header_bar_widgeet.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen(
      {super.key,
      required this.baseConstraints,
      required this.setBody,
      this.setAppBar = 0,
      this.setBottomBar = false,
      this.chooseBottomicon = 0,
      this.setMoveUp = false});
  final BoxConstraints baseConstraints;
  final int setAppBar;
  final Widget setBody;
  final bool setBottomBar;
  final bool setMoveUp;

  final int chooseBottomicon;
  //send data ->base->bottom

  @override
  Widget build(BuildContext context) {
    Color colorTheme = Color(0xFF080401);

    double heightHeadBottom = baseConstraints.maxHeight * 0.09;
    final BaseRepository baseRepository = GetIt.instance<BaseRepository>();

    ScrollController _scrollController = ScrollController();

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
          controller: _scrollController,
          children: [
            //appBar

            HeaderBarWidget(
              heightHead: heightHeadBottom,
              typeHeader: setAppBar,
              padding: 10,
              colorTheme: colorTheme,
              baseConstraints: baseConstraints,
            ),
            // SizedBox(
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
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () {
                        _scrollController.animateTo(
                          0.0,
                          duration: Duration(seconds: 1),
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
                    baseRepository: baseRepository,
                    constraints: constraints,
                    chooseBottomicon: chooseBottomicon,
                    padding: 10,
                    colorTheme: colorTheme,
                    baseConstraints: baseConstraints,
                  );
                },
              ),
            )
          : null,
      ///////////////////////////////
    );
  }
}
