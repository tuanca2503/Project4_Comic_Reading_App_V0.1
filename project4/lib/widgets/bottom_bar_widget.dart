import 'package:flutter/material.dart';
import 'package:project4/main.dart';
import 'package:project4/screens/account_screen.dart';
import 'package:project4/screens/follow_comic_screen.dart';
import 'package:project4/screens/home_screen.dart';
import 'package:project4/screens/search_screen.dart';
import 'package:project4/screens/user_screen.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../utils/util_func.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget(
      {super.key,
      required this.colorTheme,
      required this.padding,
      required this.chooseBottomIcon});

  final double padding;
  final Color colorTheme;
  final int chooseBottomIcon;

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  Map<String, bool> myMap = {
    'home': false,
    'search': false,
    'follow': false,
    'user': false,
  };

  @override
  void initState() {
    myMap.updateAll((key, value) => false);

    switch (widget.chooseBottomIcon) {
      case 1:
        myMap["home"] = true;
        break;
      case 2:
        myMap["search"] = true;
        break;
      case 3:
        myMap["follow"] = true;
        break;
      case 4:
        myMap["user"] = true;
        break;
      default:
        myMap.updateAll((key, value) => false);

        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: baseConstraints.maxWidth,
      color: widget.colorTheme,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          itemBottom(
            pageTo: const HomeScreen(),
            iconData: Icons.home,
            choose: myMap["home"] ?? false,
            txt: 'Trang chủ',
          ),
          itemBottom(
            pageTo: const SearchScreen(),
            iconData: Icons.search,
            choose: myMap["search"] ?? false,
            txt: 'Tìm kiếm',
          ),
          itemBottom(
            pageTo: const FollowScreen(),
            iconData: Icons.favorite_outlined,
            choose: myMap["follow"] ?? false,
            txt: 'Theo dõi',
          ),
          Consumer<ScreenProvider>(
            builder: (BuildContext context, myProvider, Widget? child) {
              bool checkUserLogin = checkStringIsNotEmpty(myProvider.email);

              return itemBottom(
                itemUser: true,
                pageTo: checkStringIsNotEmpty(myProvider.email)
                    ? const UserScreen()
                    : const AccountScreen(),
                iconData: Icons.manage_accounts_outlined,
                choose: myMap["user"] ?? false,
                txt: checkUserLogin
                    ? sharedPreferences
                            .getString(SharedPreferencesEnum.username.name) ??
                        ''
                    : 'Đăng nhập',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget itemBottom(
      {required IconData iconData,
      bool itemUser = false,
      required bool choose,
      required String txt,
      required Widget pageTo}) {
    Color colorChoose = Colors.orange;

    Color color = choose ? Colors.white : Colors.grey;
    return Expanded(
      child: BaseWidget().handleEventNavigation(
          child: SizedBox(
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // double a = constraints.maxHeight * 2;
                      return Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        padding: const EdgeInsets.all(3),
                        alignment: Alignment.center,
                        decoration: choose
                            ? BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: colorChoose,
                                    // Màu sắc của bóng
                                    offset:
                                        Offset(0, constraints.maxHeight * 2),
                                    // Độ dịch chuyển (đặt 0 cho trục x để không có dịch chuyển ngang)
                                    blurRadius: 40.0,
                                    // Độ mờ của bóng
                                    spreadRadius:
                                        6, // Khoảng cách mở rộng của bóng (0 cho bóng bao quanh phần tử)
                                  )
                                ],
                              )
                            : null,
                        child: itemUser
                            ? IntrinsicWidth(
                                child: Container(
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: getAvatarWidget(),
                                ),
                              )
                            : BaseWidget().handleEventNavigation(
                                child: BaseWidget()
                                    .setIcon(iconData: iconData, color: color),
                                pageTo: pageTo,
                                context: context),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return BaseWidget().setText(
                          color: color,
                          txt: txt,
                          fontWeight: FontWeight.w100,
                          fontSize: 13);
                    },
                  ),
                )
              ],
            ),
          ),
          pageTo: pageTo,
          context: context),
    );
  }
}
