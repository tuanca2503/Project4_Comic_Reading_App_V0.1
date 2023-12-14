import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/repositories/base_repository.dart';
import 'package:project4/screens/account_screen.dart';
import 'package:project4/screens/base_screen.dart';

import 'package:project4/widgets/base_widget.dart';

class FollowScreen extends StatefulWidget {
  const FollowScreen({super.key, required this.baseConstraints});
  final BoxConstraints baseConstraints;

  @override
  State<FollowScreen> createState() => _RankFollowScreen();
}

class _RankFollowScreen extends State<FollowScreen> {
  int keyFS = 2;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      setBottomBar: true,
      chooseBottomicon: 3,
      baseConstraints: widget.baseConstraints,
      setBody: bodyFollowScreen(),
    );
  }

  Widget bodyFollowScreen() {
    double heightFollowhBox = widget.baseConstraints.maxHeight * 0.9;
    return Container(
      child: Column(
        children: [
          Container(
            width: widget.baseConstraints.maxWidth,
            height: heightFollowhBox * 0.08,
            alignment: Alignment.center,
            child: BaseWidget().setText(
              txt: 'Danh sách theo dõi',
            ),
          ),
          Container(
            width: widget.baseConstraints.maxWidth,
            height: heightFollowhBox * 0.92,
            child: (keyFS == 0)
                ? screenEmpty()
                : (keyFS == 1)
                    ? screenListComic()
                    : screenNonUser(),
          ),
        ],
      ),
    );
  }

/////////////////////////////////
////////////////////////////////
  Widget screenEmpty() {
    return Container(
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.insert_drive_file,
            size: 48.0,
            color: Colors.grey,
          ),
          SizedBox(height: 8.0),
          Text(
            'Danh sách trống',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  //////////////////////////////////////////////
  Widget screenListComic() {
    // double heightscreenListComic = widget.baseConstraints.maxHeight * 0.82;
    return LayoutBuilder(builder: (cont, cons) {
      return Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: widget.baseConstraints.maxWidth,
                height: cons.maxHeight,
                child: ListView(),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: widget.baseConstraints.maxWidth,
                height: cons.maxHeight * 0.08,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: BaseWidget().setImageIcon(link: 'back_white.png'),
                    ),
                    Expanded(
                      flex: 8,
                      child: BaseWidget().setText(
                        txt: '1/6',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: BaseWidget().setImageIcon(link: 'next_white.png'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  ////////////////////////////////////
  Widget screenNonUser() {
    // double heightscreenListComic = widget.baseConstraints.maxHeight * 0.82;
    return LayoutBuilder(builder: (cont, cons) {
      return Container(
        alignment: Alignment.center,
        child: Stack(children: [
          Container(
            width: widget.baseConstraints.maxWidth * 0.5,
            height: cons.maxHeight * 0.22,
            child: LayoutBuilder(builder: (cont, cons) {
              return Column(
                children: [
                  Expanded(
                    child: BaseWidget().handleEventNavigation(
                        child: Container(
                          width: cons.maxWidth,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: BaseWidget().setText(
                            fontWeight: FontWeight.w400,
                            txt: 'Đăng nhập',
                          ),
                        ),
                        pageTo: AccountScreen(
                            chooseScreen: true,
                            keyAS: false,
                            baseConstraints: widget.baseConstraints,
                            baseRepository: GetIt.instance<BaseRepository>()),
                        context: context),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: BaseWidget().setText(
                      color: Colors.grey,
                      fontSize: 14,
                      txt: 'Hoặc',
                    ),
                  ),
                  Expanded(
                    child: BaseWidget().handleEventNavigation(
                        child: Container(
                          width: cons.maxWidth,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xFF181c1f),
                            border:
                                Border.all(width: 3, color: Color(0xFF242830)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: BaseWidget().setText(
                            fontWeight: FontWeight.w400,
                            txt: 'Đăng ký',
                          ),
                        ),
                        pageTo: AccountScreen(
                            chooseScreen: true,
                            keyAS: true,
                            baseConstraints: widget.baseConstraints,
                            baseRepository: GetIt.instance<BaseRepository>()),
                        context: context),
                  ),
                ],
              );
            }),
          )
        ]),
      );
    });
  }
}
