import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project4/repositories/user_repository.dart';
import 'package:project4/screens/qrscan_screen.dart';
import 'package:project4/widgets/base_widget.dart';

class HeaderBarWidget extends StatefulWidget {
  const HeaderBarWidget({
    super.key,
    required this.baseConstraints,
    required this.colorTheme,
    required this.padding,
    required this.typeHeader,
    required this.heightHead,
  });
  final Color colorTheme;
  final double padding;
  final int typeHeader;
  final double heightHead;

  final BoxConstraints baseConstraints;

  @override
  State<HeaderBarWidget> createState() => _HeaderBarWidgetState();
}

class _HeaderBarWidgetState extends State<HeaderBarWidget> {
  @override
  Widget build(BuildContext context) {
    // BoxConstraints constraints = widget.constraints;

    return LayoutBuilder(
      builder: (context, constraints) {
        switch (widget.typeHeader) {
          case 1:
            return typeParent(heightHead: widget.heightHead);
          case 2:
            return typeChildren(heightHead: widget.heightHead);
          default:
            return Container();
        }
      },
    );
  }

  Widget typeChildren({required heightHead}) {
    return Container(
      padding: EdgeInsets.all(widget.padding),
      color: widget.colorTheme,
      child: Row(
        children: [
          headerIcon(
            image: LayoutBuilder(
              builder: (context, constraints) {
                return myEventHandler(
                  child: BaseWidget().setIcon(iconData: Icons.navigate_before),
                );
              },
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(),
          ),
          headerIcon(
            image: LayoutBuilder(
              builder: (context, constraints) {
                return BaseWidget().setIcon(iconData: Icons.menu);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget myEventHandler({
    required Widget child,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: child,
    );
  }

  Widget typeParent({required heightHead}) {
    return Container(
      padding: EdgeInsets.all(widget.padding),
      height: heightHead,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
                alignment: Alignment.bottomLeft,
                child: BaseWidget().setImageAsset("logo_white.png")),
          ),
          //
          //
          headerIcon(
            image: LayoutBuilder(
              builder: (context, constraints) {
                return myEventHandler(
                  child: BaseWidget().setIcon(iconData: Icons.qr_code_scanner),
                );
              },
            ),
          ),
          headerIcon(
            image: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    myHandelNotification(
                      child: BaseWidget().setIcon(iconData: Icons.notifications_outlined),
                    ),
                    //
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget myHandelNotification({required Widget child}) {
    return GestureDetector(
      onTap: () {
//
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (BuildContext buildContext, Animation animation,
              Animation secondaryAnimation) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            // bottomRight: Radius.circular(10),
                          ),
                        ),
                        width: constraints.maxWidth * 0.5,
                        height: constraints.maxHeight * 0.5,
                        padding: BaseWidget().setLefRightPadding(pLR: 20),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              "Notification",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: BaseWidget().setText(
                                                txt: "New", fontSize: 10),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child:
                                                BaseWidget().setText(txt: "c"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    padding: BaseWidget()
                                        .setTopBottomPadding(pTB: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    child: Row(
                                      children: [
                                        Expanded(flex: 6, child: Container()),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: 5,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                        ),
                                        Expanded(flex: 6, child: Container()),
                                      ],
                                    ),
                                  ),
                                ),

                                //    Navigator.of(context).pop();
                                //
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          },
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ).drive(Tween<Offset>(
                begin: Offset(0, -1.0),
                end: Offset(0, 0),
              )),
              child: child,
            );
          },
        );

//
      },
      child: child,
    );
  }

  Widget myHandelEventQRScan({required Widget child}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                QRScanScreen(baseConstraints: widget.baseConstraints),
          ),
        );
      },
      child: child,
    );
  }

  //

  //

  Widget headerIcon({required Widget image}) {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        child: image,
      ),
    );
  }
}
