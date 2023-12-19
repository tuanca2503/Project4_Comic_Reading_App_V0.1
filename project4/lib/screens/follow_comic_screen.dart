import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/screens/account_screen.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/widgets/base_widget.dart';

import '../repositories/comics_repository.dart';
import '../utils/constants.dart';
import '../utils/util_func.dart';
import '../widgets/custom_slide_widget.dart';

class FollowScreen extends StatefulWidget {
  const FollowScreen({super.key});

  @override
  State<FollowScreen> createState() => _RankFollowScreen();
}

class _RankFollowScreen extends State<FollowScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      setBottomBar: true,
      chooseBottomIcon: 3,
      setBody: bodyFollowScreen(),
    );
  }

  Widget bodyFollowScreen() {
    double heightFollowHBox = baseConstraints.maxHeight * 0.9;
    bool checkUserLogin = checkStringIsNotEmpty(sharedPreferences.getString('email'));
    return Column(
      children: [
        Container(
          width: baseConstraints.maxWidth,
          height: heightFollowHBox * 0.08,
          alignment: Alignment.center,
          child: BaseWidget().setText(
            txt: 'Danh sách theo dõi',
          ),
        ),
        SizedBox(
          width: baseConstraints.maxWidth,
          height: heightFollowHBox * 0.92,
          child: !checkUserLogin
              ? screenNonUser()
              : screenListComic(),
        ),
      ],
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
      return Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
              width: baseConstraints.maxWidth,
              height: cons.maxHeight,
              child: ListView(),
            ),
          ),
          BaseWidget().setFutureBuilder(
            callback: (snapshot) {
              if (snapshot.data!.data.length == 0) {
                return screenEmpty();
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: CustomSlideWidget(
                  comicBooks: snapshot.data!.data,
                ),
              );
            },
            repo: GetIt.instance<ComicsRepository>().getAllFavouriteComics(),
          ),
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: baseConstraints.maxWidth,
              height: cons.maxHeight * 0.08,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: BaseWidget().setIcon(iconData: Icons.navigate_before),
                  ),
                  Expanded(
                    flex: 8,
                    child: BaseWidget().setText(
                      txt: '1/6',
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: BaseWidget().setIcon(iconData: Icons.navigate_next),
                  ),
                ],
              ),
            ),
          ),
        ],
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
          SizedBox(
            width: baseConstraints.maxWidth * 0.5,
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
                        pageTo: const AccountScreen(
                            chooseScreen: true, keyAS: false),
                        context: context),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
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
                            color: const Color(0xFF181c1f),
                            border:
                                Border.all(width: 3, color: const Color(0xFF242830)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: BaseWidget().setText(
                            fontWeight: FontWeight.w400,
                            txt: 'Đăng ký',
                          ),
                        ),
                        pageTo: const AccountScreen(chooseScreen: true, keyAS: true),
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
