import 'package:flutter/material.dart';
import 'package:project4/widgets/bottom_bar_widget.dart';
import 'package:project4/widgets/header_bar_widgeet.dart';

import '../utils/constants.dart';

class BaseScreen extends StatefulWidget {
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

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

// class _BaseScreenState extends State<BaseScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class _BaseScreenState extends State<BaseScreen> {
  //send data ->base->bottom
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        // Hiển thị hoặc ẩn nút dựa vào vị trí cuộn
        _showToTopButton = scrollController.offset > 400;
      });
    });
  }

  ScrollController scrollController = ScrollController();
  bool _showToTopButton = false;

  @override
  Widget build(BuildContext context) {
    Color colorTheme = const Color(0xFF080401);

    double heightHeadBottom = baseConstraints.maxHeight * 0.09;

    /// base repo
    ///
    ///
    ///

    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 0),
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
              typeHeader: widget.setAppBar,
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
            widget.setBody,
          ],
        ),
      ),

      ////////////////////////////////////
      bottomNavigationBar: widget.setBottomBar
          ? Container(
              color: const Color.fromARGB(0, 0, 0, 0),
              height: heightHeadBottom,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          color: Colors.transparent,
                          height: constraints.maxHeight,
                          child: BottomBarWidget(
                            chooseBottomIcon: widget.chooseBottomIcon,
                            padding: 10,
                            colorTheme: colorTheme,
                          ),
                        ),
                      ),
                      _showToTopButton
                          ? Positioned(
                              // offset: Offset(
                              //     baseConstraints.maxWidth / 2 - (50 / 2), -60),
                              top: -20,
                              left: baseConstraints.maxWidth / 2 - (50 / 2),

                              child: ClipRect(
                                child: widget.setMoveUp
                                    ? InkWell(
                                        onTap: () {
                                          // Xử lý sự kiện khi nút được nhấn

                                          scrollController.animateTo(
                                            scrollController
                                                .position.minScrollExtent,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: Container(
                                          width: 50.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                              // shape: BoxShape.circle,
                                              color: colorTheme,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    25.0), // Bán kính của góc trái trên
                                                topRight: Radius.circular(
                                                    25.0), // Bán kính của góc phải trên
                                              ),
                                              border: const Border(
                                                top: BorderSide(
                                                    width: 2,
                                                    color: Colors.orange),
                                              ) // Viền xung quanh hình tròn
                                              ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.arrow_upward,
                                              color: Colors.orange,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                            )
                          : Container(),
                    ],
                  );
                },
              ),
            )
          : null,
      ///////////////////////////////
    );
  }
}


/////
///
