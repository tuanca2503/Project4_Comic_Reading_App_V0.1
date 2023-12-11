import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:project4/models/comic_book.dart';

import 'package:project4/screens/base_screen.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/list_widget.dart';

// ignore: must_be_immutable

class UserScreen extends StatefulWidget {
  const UserScreen({
    super.key,
    required this.baseConstraints,
  });

  final BoxConstraints baseConstraints;

  @override
  State<UserScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<UserScreen> {
  @override
  _AccountScreenState({
    Key? key,
  });
  BoxConstraints constraints = BoxConstraints();
  bool DarkSwitched = true;
  bool NotificationsSwitched = true;
  double fontSize = 0;
  double fontFour = 0;
  double fontBac = 0;
  double boxBack = 0;
  double fontBack = 0;
  double create = 0;
  bool chooseScreen = false;

  bool key = false; // true là đăng kí fales là đăng nhập
  ////
  ///
  double screenWidth = 0;
  double screenHeight = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chooseScreen = true;
    screenWidth = widget.baseConstraints.maxWidth;
    screenHeight = widget.baseConstraints.maxHeight;
    fontSize = screenWidth * 0.03;
    fontFour = screenWidth * 0.04;
    fontBac = screenWidth * 0.02;
    fontBack = screenWidth * 0.05;
    create = screenWidth * 0.025;
  }

  ////
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        chooseBottomicon: 4,
        baseConstraints: widget.baseConstraints,
        setAppBar: 3,
        setBottomBar: true,
        setBody: chooseScreen
            ? settingUser(
                key: key,
                context: context,
                baseConstraints: widget.baseConstraints)
            : inforUser(
                context: context, baseConstraints: widget.baseConstraints));
  }

  Widget inforUser(
      {required BuildContext context,
      bool key = false,
      required BoxConstraints baseConstraints}) {
    double heightBackgroundBox = widget.baseConstraints.maxHeight * 0.6;
    double heightContentBox = widget.baseConstraints.maxHeight * 0.37;

    return Container(
      width: screenWidth,
      height: screenHeight,
      padding: EdgeInsets.all(10),
      color: Colors.black,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              ///
              Container(
                height: heightBackgroundBox,
                child: Stack(
                  children: [
                    backgroundDetails(constraints: constraints),
                    blurBottomBackground(constraints: constraints),
                    ////////////////////background
                    boxDetailsComic(constraints: constraints),
                    boxBotomBack(constraints: constraints),
                  ],
                ),
              ),

              Container(
                height: heightContentBox,
                child: Stack(
                  children: [
                    boxBottom(constraints: constraints),
                  ],
                ),
              ),

              ///
            ],
          );
        },
      ),
    );

    // ignore: dead_code
  }

//////////////////////////////////////
  Widget boxBotomBack({
    required BoxConstraints constraints,
  }) {
    return Container(
        child: GestureDetector(
      onTap: () {
        setState(() {
          chooseScreen = true;
        });
      },
      child: Container(
        width: screenWidth * 0.06,
        height: screenHeight * 0.06,
        child: BaseWidget().setImageAsset('back_white.png'),
      ),
    ));
  }

//////////////////////////////////////
  Widget boxBottom({
    required BoxConstraints constraints,
  }) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Truyện đang theo dõi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontFour,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Xem tất cả',
                    style: TextStyle(
                      color: Color(0xffd1480b),
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            height: 300,
            child: ListWidget(
              baseConstraints: widget.baseConstraints,
              setList: 1,
              comicBooks: ComicBook().Seed(),
            ),
          ),
        )
      ],
    );
  }

//////////////////////////////////////
  Widget boxDetailsComic({
    required BoxConstraints constraints,
  }) {
    return Positioned(
      bottom: 5,
      child: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight * 0.4,
        child: Column(
          children: [
            // Padding(
            //     padding: EdgeInsets.only(bottom: constraints.maxWidth * 0.15)),
            Expanded(
              flex: 5,
              child: Align(
                alignment: Alignment.center,
                child: LayoutBuilder(builder: (ct, cs) {
                  return Container(
                    width: cs.maxHeight,
                    height: cs.maxHeight,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(120))),
                    child: BaseWidget().setImageAsset("th.jpg"),
                  );
                }),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Hoài Nam',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontBack,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(children: [
                Expanded(
                  child: Container(
                      child: Column(
                    children: [
                      Text(
                        '43',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontFour,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Người đăng ký',
                        style: TextStyle(
                          color: Color(0xff736b68),
                        ),
                      )
                    ],
                  )),
                ),
                Expanded(
                  child: Container(
                      child: Column(
                    children: [
                      Text(
                        '43',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontFour,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' Manga đã đọc',
                        style: TextStyle(
                          color: Color(0xff736b68),
                        ),
                      )
                    ],
                  )),
                ),
                Expanded(
                  child: Container(
                      child: Column(
                    children: [
                      Text(
                        '43',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontFour,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Người theo dõi',
                        style: TextStyle(
                          color: Color(0xff736b68),
                        ),
                      )
                    ],
                  )),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  ///

  Widget backgroundDetails({required BoxConstraints constraints}) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: FittedBox(
        fit: BoxFit.cover,
        child: BaseWidget().setImageAsset('th.jpg'),
      ),
    );
  }

  Widget blurBottomBackground({required BoxConstraints constraints}) {
    return Positioned(
      bottom: -1,
      child: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
            colors: [
              Colors.transparent,
              Color(0xFF080401).withOpacity(1),
            ],
          ),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////

  Widget settingUser(
      {required BuildContext context,
      bool key = false,
      required BoxConstraints baseConstraints}) {
    return Container(
      width: constraints.maxWidth,
      height: screenHeight * 0.91,
      padding: EdgeInsets.all(screenHeight * 0.03),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Color(0xff0b0704),
            Color(0xff16110d),
            Color(0xff1f1b19),
          ],
        ),
      ),
      child: ListView(children: [
        Container(
          width: constraints.maxWidth,
          height: screenHeight * 0.06,
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.white),
          // ),
          child: Text(
            'Settings',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontBack),
          ),
        ),
        Container(
          width: constraints.maxWidth,
          height: screenHeight * 0.08,
          child: Row(children: [
            Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: LayoutBuilder(builder: (ct, cs) {
                    return Container(
                      width: cs.maxHeight,
                      height: cs.maxHeight,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(120))),
                      child: BaseWidget().setImageAsset("th.jpg"),
                    );
                  }),
                )),
            Expanded(
              flex: 6,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    chooseScreen = false;
                  });
                },
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  padding: EdgeInsets.only(left: 20),
                  child: ListView(
                    children: [
                      Text(
                        'Hoài Nam',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontBack),
                      ),
                      Text(
                        'Edit personal details',
                        style: TextStyle(
                            color: Color(0xff575757), fontSize: fontFour),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Transform.scale(
                    scale: 0.25,
                    child: BaseWidget().setImageAsset('next-white.png'),
                  ),
                )),
          ]),
        ),
        Container(
          width: constraints.maxWidth,
          height: screenHeight * 0.04,
        ),
        Container(
          width: constraints.maxWidth,
          height: screenHeight * 0.07,
          child: Row(children: [
            Expanded(
                flex: 2,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Transform.scale(
                    scale: 0.7,
                    child: BaseWidget().setImageAsset('moon.png'),
                  ),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  padding: EdgeInsets.only(left: 20),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Đặt vị trí về giữa bên trái
                          child: Text(
                            'Dark Mode',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: fontFour),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
              flex: 2,
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Center(
                  child: Switch(
                    value: DarkSwitched,
                    onChanged: (value) => {
                      setState(() {
                        DarkSwitched = value;
                      })
                    },
                  ),
                ),
              ),
            ),
          ]),
        ),
        Container(
          width: constraints.maxWidth,
          height: screenHeight * 0.06,
          child: Center(
            child: Stack(
              children: [
                Align(
                  alignment:
                      Alignment.centerLeft, // Đặt vị trí về giữa bên trái
                  child: Text(
                    'Profile',
                    style: TextStyle(
                        color: Color(0xff595959),
                        fontWeight: FontWeight.bold,
                        fontSize: fontFour),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: constraints.maxWidth,
          height: screenHeight * 0.07,
          child: Row(children: [
            Expanded(
                flex: 2,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Transform.scale(
                    scale: 0.8,
                    child: BaseWidget().setImageAsset('clock.png'),
                  ),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  padding: EdgeInsets.only(left: 20),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Đặt vị trí về giữa bên trái
                          child: Text(
                            'Reading history',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: fontFour),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Transform.scale(
                    scale: 0.25,
                    child: BaseWidget().setImageAsset('next-white.png'),
                  ),
                )),
          ]),
        ),
        Container(
          width: constraints.maxWidth,
          height: screenHeight * 0.07,
          child: Row(children: [
            Expanded(
                flex: 2,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Transform.scale(
                    scale: 0.7,
                    child: BaseWidget().setImageAsset('padlock.png'),
                  ),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  padding: EdgeInsets.only(left: 20),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Đặt vị trí về giữa bên trái
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: fontFour),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Transform.scale(
                    scale: 0.25,
                    child: BaseWidget().setImageAsset('next-white.png'),
                  ),
                )),
          ]),
        ),
        Container(
          width: constraints.maxWidth,
          height: screenHeight * 0.06,
          child: Center(
            child: Stack(
              children: [
                Align(
                  alignment:
                      Alignment.centerLeft, // Đặt vị trí về giữa bên trái
                  child: Text(
                    'Notifications',
                    style: TextStyle(
                        color: Color(0xff595959),
                        fontWeight: FontWeight.bold,
                        fontSize: fontFour),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: constraints.maxWidth,
          height: screenHeight * 0.07,
          child: Row(children: [
            Expanded(
                flex: 2,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Transform.scale(
                    scale: 0.7,
                    child: BaseWidget().setImageAsset('notification-bell.png'),
                  ),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  padding: EdgeInsets.only(left: 20),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Đặt vị trí về giữa bên trái
                          child: Text(
                            'Notifications',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: fontFour),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Center(
                    child: Switch(
                      value: NotificationsSwitched,
                      onChanged: (value) => {
                        setState(() {
                          NotificationsSwitched = value;
                        })
                      },
                    ),
                  ),
                )),
          ]),
        ),
        Container(
          width: constraints.maxWidth,
          height: screenHeight * 0.06,
          child: Center(
            child: Stack(
              children: [
                Align(
                  alignment:
                      Alignment.centerLeft, // Đặt vị trí về giữa bên trái
                  child: Text(
                    'Regional',
                    style: TextStyle(
                        color: Color(0xff595959),
                        fontWeight: FontWeight.bold,
                        fontSize: fontFour),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: constraints.maxWidth,
          height: screenHeight * 0.07,
          child: Row(children: [
            Expanded(
                flex: 2,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Transform.scale(
                    scale: 0.7,
                    child: BaseWidget().setImageAsset('language.png'),
                  ),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  padding: EdgeInsets.only(left: 20),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Đặt vị trí về giữa bên trái
                          child: Text(
                            'Language',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: fontFour),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Transform.scale(
                    scale: 0.25,
                    child: BaseWidget().setImageAsset('next-white.png'),
                  ),
                )),
          ]),
        ),
        Container(
          width: constraints.maxWidth,
          height: screenHeight * 0.07,
          // child: BaseWidget().handleEventNavigation(
          child: Row(children: [
            Expanded(
                flex: 2,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Transform.scale(
                    scale: 0.7,
                    child: BaseWidget().setImageAsset('logout.png'),
                  ),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  padding: EdgeInsets.only(left: 20),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Đặt vị trí về giữa bên trái
                          child: Text(
                            'Loguot',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: fontFour),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Transform.scale(
                    scale: 0.25,
                    child: BaseWidget().setImageAsset('logout.png'),
                  ),
                )),
          ]),
          // pageTo: AccountScreen(baseConstraints: baseConstraints),
          // context: context),
        ),
        Container(
          width: constraints.maxWidth,
          height: screenHeight * 0.08,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Căn giữa dọc
            children: [
              Text(
                'App ver 0.1',
                style: TextStyle(color: Color(0xff595959), fontSize: fontFour),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
