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
      this.chooseBottomicon = 0});
  final BoxConstraints baseConstraints;
  final int setAppBar;
  final Widget setBody;
  final bool setBottomBar;
  final int chooseBottomicon;
  //send data ->base->bottom
  testapi({required BaseRepository baseRepository}) async {
    ResultCallAPI response =
        await baseRepository.comicsRepository.getAllComics();
    print(response.mess);
  }

  @override
  Widget build(BuildContext context) {
    Color colorTheme = Color(0xFF080401);

    double heightHeadBottom = baseConstraints.maxHeight * 0.09;
    final BaseRepository baseRepository = GetIt.instance<BaseRepository>();
    testapi(baseRepository: baseRepository);

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
            setBody
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
