import 'package:flutter/material.dart';
import 'package:project4/main.dart';
import 'package:project4/repositories/base_repository.dart';
import 'package:project4/repositories/user_repository.dart';
import 'package:project4/screens/account_screen.dart';
import 'package:project4/screens/home_screen.dart';
import 'package:project4/screens/rank_screen.dart';
import 'package:project4/screens/search_screen.dart';
import 'package:project4/screens/user_screen.dart';
import 'package:project4/widgets/base_widget.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget(
      {super.key,
      required this.baseConstraints,
      required this.colorTheme,
      required this.padding,
      required this.chooseBottomicon,
      required this.baseRepository,
      required this.constraints});
  final BoxConstraints constraints;
  final double padding;
  final BoxConstraints baseConstraints;
  final Color colorTheme;
  final int chooseBottomicon;
  final BaseRepository baseRepository;

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

    switch (widget.chooseBottomicon) {
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
      color: widget.colorTheme,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          itemBottom(
            pageTo: HomeScreen(
              baseConstraints: widget.baseConstraints,
              baseRepository: widget.baseRepository,
            ),
            link: 'home',
            choose: myMap["home"] ?? false,
            txt: 'Trang chủ',
          ),
          itemBottom(
            pageTo: SearchScreen(baseConstraints: widget.baseConstraints),
            link: 'loupe',
            choose: myMap["search"] ?? false,
            txt: 'Tìm kiếm',
          ),
          itemBottom(
            pageTo: RankScreen(baseConstraints: widget.baseConstraints),
            link: 'heart',
            choose: myMap["follow"] ?? false,
            txt: 'Theo dõi',
          ),
          itemBottom(
            itemUser: true,
            pageTo: (widget.baseRepository.userRepository
                    .fetchUserData()
                    .refreshToken
                    .isNotEmpty)
                ? UserScreen(baseConstraints: widget.baseConstraints)
                : AccountScreen(
                    baseConstraints: widget.baseConstraints,
                    baseRepository: widget.baseRepository,
                  ),
            link: 'th.jpg',
            choose: myMap["user"] ?? false,
            txt: 'User',
          ),
        ],
      ),
    );
  }

  Widget itemBottom(
      {required String link,
      bool itemUser = false,
      required bool choose,
      required String txt,
      required Widget pageTo}) {
    Color colorChoose = Colors.orange;

    Color color = choose ? Colors.white : Colors.grey;
    String thislink = itemUser
        ? link
        : choose
            ? link += '_white.png'
            : link += '_grey.png';
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
                        padding: EdgeInsets.all(3),
                        alignment: Alignment.center,
                        decoration: choose
                            ? BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: colorChoose, // Màu sắc của bóng
                                    offset: Offset(
                                        0,
                                        constraints.maxHeight *
                                            2), // Độ dịch chuyển (đặt 0 cho trục x để không có dịch chuyển ngang)
                                    blurRadius: 40.0, // Độ mờ của bóng
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
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: BaseWidget().setImageAsset(thislink),
                                ),
                              )
                            : BaseWidget().handleEventNavigation(
                                child: BaseWidget().setImageAsset(thislink),
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
