import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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

  @override
  Widget build(BuildContext context) {
    Color colorTheme = Color(0xFF080401);

    double heightHeadBottom = baseConstraints.maxHeight * 0.09;
    final UserRepository userRepository = GetIt.instance<UserRepository>();
    // userRepository.registerUser(
    //     email: "abc@a.a", password: "aaaa", userName: "aaaa");
    // userRepository.loginUser(email: "abc@a.a", password: "aaaa");
    // userRepository.getInforUser();
    // print(userRepository.token);
    ////////////////////
    // final response = userRepository
    //     .loginUser(email: "abc@a.a", password: "aaaa")
    //     .then((value) {
    //   if (value is String) {
    //     userRepository.getInforUser(token: value);

    //     return value;
    //   }
    // });

    // print(userRepository.loginUser(email: "abc@a.a", password: "aaaa"));

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
                    userRepository: userRepository,
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
