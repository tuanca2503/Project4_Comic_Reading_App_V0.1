import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/repositories/auth_repository.dart';
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

  ////
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        chooseBottomIcon: 4,
        setAppBar: 3,
        setBottomBar: true,
        setBody: chooseScreen
            ? _userSettingWidget(key: key, context: context)
            : _userInfoWidget(context: context));
  }

  Widget _userInfoWidget({required BuildContext context, bool key = false}) {
    double heightBackgroundBox = baseConstraints.maxHeight * 0.6;
    double heightContentBox = baseConstraints.maxHeight * 0.37;

    return Container(
      width: screenWidth,
      height: screenHeight,
      padding: const EdgeInsets.all(10),
      color: Colors.black,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              ///
              SizedBox(
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

              SizedBox(
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
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            width: baseConstraints.maxWidth,
            height: baseConstraints.maxHeight,
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
                      color: const Color(0xffd1480b),
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
        // hidden code
        // Expanded(
        //   flex: 8,
        //   child: SizedBox(
        //     height: 300,
        //     child: ListWidget(
        //       setList: 1,
        //       comicBooks: ComicBook().Seed(),
        //     ),
        //   ),
        // )
      ],
    );
  }

//////////////////////////////////////
  Widget boxDetailsComic({
    required BoxConstraints constraints,
  }) {
    return Positioned(
      bottom: 5,
      child: SizedBox(
        width: baseConstraints.maxWidth,
        height: baseConstraints.maxHeight * 0.4,
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
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(120))),
                    child: getAvatarWidget(),
                  );
                }),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                sharedPreferences
                    .getString(SharedPreferencesEnum.username.name)!,
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
                      const Text(
                        'Người đăng ký',
                        style: TextStyle(
                          color: Color(0xff736b68),
                        ),
                      )
                    ],
                  )),
                ),
                Expanded(
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
                      const Text(
                        ' Manga đã đọc',
                        style: TextStyle(
                          color: Color(0xff736b68),
                        ),
                      )
                    ],
                  ),
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
                      const Text(
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
        width: baseConstraints.maxWidth,
        height: baseConstraints.maxHeight,
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
      height: screenHeight * 0.91,
      padding: EdgeInsets.all(screenHeight * 0.03),
      decoration: const BoxDecoration(
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
                  child: BaseWidget()
                      .setIcon(iconData: Icons.history, color: Colors.blueAccent),
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
