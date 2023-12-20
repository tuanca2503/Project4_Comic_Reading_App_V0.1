import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/models/app_valid.dart';
import 'package:project4/repositories/auth_repository.dart';
import 'package:project4/repositories/user_repository.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/utils/constants.dart';
import 'package:project4/widgets/base_widget.dart';

import '../utils/util_func.dart';

// ignore: must_be_immutable

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<UserScreen> {
  @override
  _AccountScreenState({
    Key? key,
  });

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
    screenWidth = baseConstraints.maxWidth;
    screenHeight = baseConstraints.maxHeight;
    fontSize = screenWidth * 0.03;
    fontFour = screenWidth * 0.04;
    fontBac = screenWidth * 0.02;
    fontBack = screenWidth * 0.05;
    create = screenWidth * 0.025;
  }

  TextEditingController _username = TextEditingController();
  bool _showUsernameField = false;
  String errMess = '';
  ////
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        chooseBottomIcon: 4,
        setAppBar: 1,
        setBottomBar: true,
        setBody: chooseScreen
            ? _userSettingWidget(key: key, context: context)
            : _userInfoWidget(context: context));
  }

  Widget _userInfoWidget({required BuildContext context, bool key = false}) {
    double heightBackgroundBox = baseConstraints.maxHeight * 0.6;
    double heightContentBox = baseConstraints.maxHeight * 0.37;

    return Container(
      width: baseConstraints.maxWidth,
      height: baseConstraints.maxHeight,
      padding: const EdgeInsets.all(10),
      // color: Colors.black,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              ///
              SizedBox(
                height: heightBackgroundBox,
                width: constraints.maxWidth,
                child: Stack(
                  children: [
                    backgroundDetails(constraints: constraints),
                    blurBottomBackground(constraints: constraints),
                    ////////////////////background
                    boxDetailsComic(constraints: constraints),
                    boxBotomBack(),
                  ],
                ),
              ),

              // SizedBox(
              //   height: heightContentBox,
              //   child: Stack(
              //     children: [
              //       boxBottom(constraints: constraints),
              //     ],
              //   ),
              // ),

              ///
            ],
          );
        },
      ),
    );

    // ignore: dead_code
  }

//////////////////////////////////////
  Widget boxBotomBack() {
    return GestureDetector(
      onTap: () {
        setState(() {
          chooseScreen = true;
        });
      },
      child: SizedBox(
        width: screenWidth * 0.06,
        height: screenHeight * 0.06,
        child: BaseWidget().setIcon(iconData: Icons.navigate_before),
      ),
    );
  }

//////////////////////////////////////
  Widget boxBottom({
    required BoxConstraints constraints,
  }) {
    return Container(
      width: constraints.maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tên',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xffd6dbe2),
              fontSize: fontFour,
            ),
          ),
          const SizedBox(height: 8.0), // Add some vertical space
          TextField(
            controller: _username,
            style: TextStyle(
              color: const Color(0xffd6dbe2),
              fontSize: fontSize,
            ),
            decoration: InputDecoration(
              fillColor: const Color(0xff1f1b19),
              filled: true,
              hintStyle: TextStyle(
                color: const Color(0xff49575e),
                fontSize: fontSize,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF242830),
                  width: 1,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF3b4149), width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

//////////////////////////////////////
  Widget boxDetailsComic({
    required BoxConstraints constraints,
  }) {
    return Positioned(
      bottom: 5,
      child: SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight * 0.4,
        child: Column(
          children: [
            // Padding(
            //     padding: EdgeInsets.only(bottom: constraints.maxWidth * 0.15)),
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                child: LayoutBuilder(builder: (ct, cs) {
                  double iconInAvatar = cs.maxHeight * 0.2;
                  return GestureDetector(
                    onTap: () {
                      ///update avatar
                      print('update avatar');
                    },
                    child: Container(
                      width: cs.maxHeight,
                      height: cs.maxHeight,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Stack(
                        children: [
                          getAvatarWidget(),
                          Positioned(
                            bottom: 0,
                            // left: cs.maxHeight / 2 - (iconInAvatar / 2),
                            child: Container(
                              color: Colors.black,
                              width: cs.maxHeight,
                              height: iconInAvatar,
                              child: const Center(
                                child: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            Expanded(
              flex: 1,
              child: BaseWidget().setText(
                  txt:
                      'Email: ${sharedPreferences.getString(SharedPreferencesEnum.email.name)!.replaceRange(6, sharedPreferences.getString(SharedPreferencesEnum.email.name)!.length, '*' * (sharedPreferences.getString(SharedPreferencesEnum.email.name)!.length - 6))}',
                  fontSize: 12,
                  fontWeight: FontWeight.w100),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Visibility(
                    visible: !_showUsernameField,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BaseWidget().setText(
                            txt: sharedPreferences.getString(
                                SharedPreferencesEnum.username.name)!),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showUsernameField = !_showUsernameField;
                            });
                          },
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
//
                  Visibility(
                    visible: _showUsernameField,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          child: TextField(
                            controller: _username,
                            style: TextStyle(
                              color: const Color(0xffd6dbe2),
                              fontSize: fontSize,
                            ),
                            decoration: InputDecoration(
                              hintText: sharedPreferences.getString(
                                  SharedPreferencesEnum.username.name)!,
                              fillColor: const Color(0xff1f1b19),
                              filled: true,
                              hintStyle: TextStyle(
                                color: const Color(0xff49575e),
                                fontSize: fontSize,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF242830),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF3b4149), width: 2),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 20,
                              ),
                              suffixIcon: TextButton(
                                onPressed: () async {
                                  if (AppValid(data: _username.text)
                                      .isValidName) {
                                    try {
                                      await GetIt.instance<UserRepository>()
                                          .updateUserInfo(
                                              userName: _username.text);
                                      setState(() {
                                        _showUsernameField =
                                            !_showUsernameField;
                                      });
                                    } catch (e) {
                                      setState(() {
                                        errMess = 'Hay nhap dung ten (5-50)';
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      errMess = 'Hay nhap dung ten (5-50)';
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  padding: const EdgeInsets.all(5),
                                  child: Transform(
                                    transform: Matrix4.identity(),
                                    // ..rotateZ(-20 *
                                    //     (3.14159265358979323846 /
                                    //         180)) // Xoay 45 độ
                                    // ..translate(-5, 0),
                                    child: const Icon(
                                      Icons.send, // Mã biểu tượng email
                                      size: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          child: BaseWidget().setText(
                              txt: errMess, color: Colors.red, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
      width: baseConstraints.maxWidth,
      height: baseConstraints.maxHeight,
      child: FittedBox(
        fit: BoxFit.cover,
        child: getAvatarWidget(),
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
              const Color(0xFF080401).withOpacity(1),
            ],
          ),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////

  Widget _userSettingWidget({required BuildContext context, bool key = false}) {
    return Container(
      width: baseConstraints.maxWidth,
      height: screenHeight,
      padding: EdgeInsets.all(screenHeight * 0.03),
      color: const Color(0xFF080401),
      child: Column(children: [
        SizedBox(
          width: baseConstraints.maxWidth,
          height: screenHeight * 0.06,
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.white),
          // ),
          child: Text(
            'Cài đặt',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontBack),
          ),
        ),
        SizedBox(
          width: baseConstraints.maxWidth,
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
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(120))),
                      child: getAvatarWidget(),
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
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView(
                    children: [
                      Text(
                        sharedPreferences
                            .getString(SharedPreferencesEnum.username.name)!,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontBack),
                      ),
                      Text(
                        'Sửa thông tin',
                        style: TextStyle(
                            color: const Color(0xff575757), fontSize: fontFour),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: SizedBox(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  child: BaseWidget().setIcon(iconData: Icons.navigate_next),
                )),
          ]),
        ),
        SizedBox(
          width: baseConstraints.maxWidth,
          height: screenHeight * 0.04,
        ),
        SizedBox(
          width: baseConstraints.maxWidth,
          height: screenHeight * 0.07,
          child: Row(children: [
            Expanded(
                flex: 2,
                child: SizedBox(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  child: BaseWidget().setIcon(iconData: Icons.dark_mode),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  padding: const EdgeInsets.only(left: 20),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Đặt vị trí về giữa bên trái
                          child: Text(
                            'Đổi giao diện',
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
              child: SizedBox(
                width: baseConstraints.maxWidth,
                height: baseConstraints.maxHeight,
                child: Center(
                  child: Switch(
                    value: DarkSwitched,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.black,
                    inactiveThumbColor: Colors.black,
                    inactiveTrackColor: Colors.white,
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
        SizedBox(
          width: baseConstraints.maxWidth,
          height: screenHeight * 0.06,
          child: Center(
            child: Stack(
              children: [
                Align(
                  alignment:
                      Alignment.centerLeft, // Đặt vị trí về giữa bên trái
                  child: Text(
                    'Thông tin',
                    style: TextStyle(
                        color: const Color(0xff595959),
                        fontWeight: FontWeight.bold,
                        fontSize: fontFour),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: baseConstraints.maxWidth,
          height: screenHeight * 0.07,
          child: Row(children: [
            Expanded(
                flex: 2,
                child: SizedBox(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  child: BaseWidget().setIcon(
                      iconData: Icons.history, color: Colors.blueAccent),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  padding: const EdgeInsets.only(left: 20),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Đặt vị trí về giữa bên trái
                          child: Text(
                            'Lịch sử đọc truyện',
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
                child: SizedBox(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  child: BaseWidget().setIcon(iconData: Icons.navigate_next),
                )),
          ]),
        ),
        SizedBox(
          width: baseConstraints.maxWidth,
          height: screenHeight * 0.07,
          child: Row(children: [
            Expanded(
                flex: 2,
                child: SizedBox(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  child: BaseWidget().setIcon(
                      iconData: Icons.vpn_key, color: Colors.redAccent),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  padding: const EdgeInsets.only(left: 20),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Đặt vị trí về giữa bên trái
                          child: Text(
                            'Thay mật khẩu',
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
                child: SizedBox(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  child: BaseWidget().setIcon(iconData: Icons.navigate_next),
                )),
          ]),
        ),
        SizedBox(
          width: baseConstraints.maxWidth,
          height: screenHeight * 0.06,
          child: Center(
            child: Stack(
              children: [
                Align(
                  alignment:
                      Alignment.centerLeft, // Đặt vị trí về giữa bên trái
                  child: Text(
                    'Thông báo',
                    style: TextStyle(
                        color: const Color(0xff595959),
                        fontWeight: FontWeight.bold,
                        fontSize: fontFour),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: baseConstraints.maxWidth,
          height: screenHeight * 0.07,
          child: Row(children: [
            Expanded(
                flex: 2,
                child: SizedBox(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  child: BaseWidget().setIcon(
                      iconData: Icons.notifications, color: Colors.green),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  padding: const EdgeInsets.only(left: 20),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Đặt vị trí về giữa bên trái
                          child: Text(
                            'Thông báo',
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
                child: SizedBox(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  child: Center(
                    child: Switch(
                      activeColor: Colors.white,
                      activeTrackColor: Colors.black,
                      inactiveThumbColor: Colors.black,
                      inactiveTrackColor: Colors.white,
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
        SizedBox(
          width: baseConstraints.maxWidth,
          height: screenHeight * 0.06,
          child: Center(
            child: Stack(
              children: [
                Align(
                  alignment:
                      Alignment.centerLeft, // Đặt vị trí về giữa bên trái
                  child: Text(
                    'Tương tác',
                    style: TextStyle(
                        color: const Color(0xff595959),
                        fontWeight: FontWeight.bold,
                        fontSize: fontFour),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: baseConstraints.maxWidth,
          height: screenHeight * 0.07,
          child: Row(children: [
            Expanded(
                flex: 2,
                child: SizedBox(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  child: BaseWidget().setIcon(
                      iconData: Icons.language, color: Colors.purpleAccent),
                )),
            Expanded(
                flex: 6,
                child: Container(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  padding: const EdgeInsets.only(left: 20),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Đặt vị trí về giữa bên trái
                          child: Text(
                            'Ngôn ngữ',
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
                child: SizedBox(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  child: BaseWidget().setIcon(iconData: Icons.navigate_next),
                )),
          ]),
        ),
        SizedBox(
          width: baseConstraints.maxWidth,
          height: screenHeight * 0.07,
          // child: BaseWidget().handleEventNavigation(
          child: Row(children: [
            Expanded(
                flex: 2,
                child: SizedBox(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  child: BaseWidget().setIcon(
                      iconData: Icons.logout, color: Colors.orangeAccent),
                )),
            Expanded(
                flex: 6,
                child: GestureDetector(
                  onTap: () async {
                    await GetIt.instance<AuthRepository>().logout();
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Container(
                    width: baseConstraints.maxWidth,
                    height: baseConstraints.maxHeight,
                    padding: const EdgeInsets.only(left: 20),
                    child: Center(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment
                                .centerLeft, // Đặt vị trí về giữa bên trái
                            child: Text(
                              'Đăng xuất',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontFour),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: SizedBox(
                  width: baseConstraints.maxWidth,
                  height: baseConstraints.maxHeight,
                  child: BaseWidget().setIcon(iconData: Icons.navigate_next),
                )),
          ]),
          // pageTo: AccountScreen(baseConstraints: baseConstraints),
          // context: context),
        ),
        SizedBox(
          width: baseConstraints.maxWidth,
          height: screenHeight * 0.08,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Căn giữa dọc
            children: [
              Text(
                'App ver 0.1',
                style: TextStyle(
                    color: const Color(0xff595959), fontSize: fontFour),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
