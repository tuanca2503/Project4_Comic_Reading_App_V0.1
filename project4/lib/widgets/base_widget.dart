import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project4/config/environment.dart';

// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:project4/models/comic/comic_book.dart';

typedef void CallbackColor(Color color);
typedef void CallBackConstraints(BoxConstraints constraints);

class BaseWidget {
  Color color;
  Radius radius;
  String txt;
  double width;
  double height;
  FontWeight fontWeight;
  double fontSize;
  String imageAsset;
  Alignment alignment;

  BaseWidget({
    this.color = const Color(0xFF080401),
    this.radius = const Radius.circular(20.0),
    this.txt = "",
    this.width = 0,
    this.height = 0,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 18,
    this.imageAsset = 'assets/images/',
    this.alignment = Alignment.center,
  });

  EdgeInsets setLefRightPadding({required double pLR}) {
    return EdgeInsets.symmetric(horizontal: pLR);
  }

  EdgeInsets setTopBottomPadding({required double pTB}) {
    return EdgeInsets.symmetric(vertical: pTB);
  }

  Image setImageAsset(String link) {
    return Image.asset('assets/images/$link');
  }

  Image setImageNetwork({required String link, BoxFit fit = BoxFit.cover}) {
    return Image.network(
      link.startsWith('http') ? link : '${Environment.apiUrl}/$link',
      headers: const {
        'ngrok-skip-browser-warning': 'true',
      },
      fit: fit,
    );
  }

  Icon setIcon(
      {required IconData iconData, Color color = Colors.white, size = 24}) {
    return Icon(
      iconData,
      color: color,
      size: size,
    );
  }

  Container setImageIcon(
      {double iconWH = 20.0,
      double padding = 0.0,
      required String link,
      Alignment alignment = Alignment.topCenter}) {
    return Container(
      padding: EdgeInsets.all(padding),
      alignment: alignment,
      width: iconWH,
      height: iconWH,
      child: Image.asset('assets/images/$link'),
    );
  }

  ///

  ///
  Widget setFutureBuilder(
      {required Function(dynamic) callback, required repo}) {
    return FutureBuilder(
      future: repo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('hasError: $snapshot');
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.done) {
          return callback(snapshot);

          // Using await here is allowed because it's inside an async function
        } else {
          print('ELSE: $snapshot');
          return const Text('Unexpected ConnectionState');
        }
      },
    );
  }

  ///
  /////event
  Widget handleEventNavigation(
      {required Widget child,
      required Widget pageTo,
      required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pageTo,
          ),
        );
      },
      child: child,
    );
  }

  ///
  ///

  ///
  ///
  ///
  Widget handleEventBackNavigation(
      {required Widget child, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: child,
    );
  }

  ///
  ///
  ///
  ///

  Text setText(
      {required String txt,
      double fontSize = 18,
      FontWeight fontWeight = FontWeight.bold,
      Color color = Colors.white,
      TextOverflow? textOverflow,
      double letterSpacing = 0,
      TextAlign textAlign = TextAlign.center,
      String fontFamily = ''}) {
    return Text(
      txt,
      maxLines: 1,
      style: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          overflow: TextOverflow.ellipsis,
          letterSpacing: letterSpacing,
          fontFamily: fontFamily),
      textAlign: textAlign,
    );
  }

  BoxDecoration setBorderBlack() {
    return BoxDecoration(border: Border.all(width: 1, color: Colors.black));
  }

  Color setColorBlack() {
    return Colors.black;
  }

  ///////////////////////////////
  Widget handleEventShare(
      {required Widget child,
      required BuildContext context,
      required ComicBook comicBook}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return FractionallySizedBox(
              heightFactor: 0.5,
              child: Container(
                padding: BaseWidget().setLefRightPadding(pLR: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 34, 33, 31),
                  // color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    //
                    double heightRow1 = constraints.maxHeight * 0.05;
                    double heightRow2 = constraints.maxHeight * 0.4;
                    double heightRow3 = constraints.maxHeight * 0.4;

                    return ListView(
                      children: [
                        ////////////----------------- row1
                        Container(
                          padding: EdgeInsets.all(heightRow1),
                          child: Row(
                            children: [
                              Expanded(flex: 6, child: Container()),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xffC4B2A8),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  height: heightRow1 * 0.2,
                                ),
                              ),
                              Expanded(flex: 6, child: Container()),
                            ],
                          ),
                        ),
                        /////////////////////////////

                        Container(
                          decoration: const BoxDecoration(
                              color: Color(0xff323436),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding: EdgeInsets.all(10),
                          height: heightRow2,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return handleEventShowQR(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: comicBook.toQrImage(
                                              color: Colors.white,
                                              size: constraints.maxWidth),
                                        ),
                                        qrcode: comicBook.toQrImage(
                                            color: Colors.white,
                                            size: constraints.maxWidth),
                                        context: context);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 9,
                                          child: Container(
                                            padding: EdgeInsets.only(right: 20),
                                            child: BaseWidget().setText(
                                                txt:
                                                    "http://metaphobius.epizy.com/?id=${comicBook.id}",
                                                fontWeight: FontWeight.w100),
                                          )),
                                      // Expanded(
                                      //   flex: 1,
                                      //   child: Container(
                                      //       child: handleEventCopyClipboard(
                                      //           child: BaseWidget()
                                      //               .setImageAsset("copy.png"),
                                      //           data:
                                      //               "http://metaphobius.epizy.com/?id=${comicBook.idComicBook}")),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ///////////////////////////////////
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: heightRow3,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              itemBoxShare(
                                  linkIMG: "copy_white.png",
                                  txt: "Sao chép liên kết",
                                  handleEvent: Clipboard.setData(ClipboardData(
                                      text:
                                          "http://metaphobius.epizy.com/?id=${comicBook.id}")),
                                  showToast: true,
                                  msg: "Sao chép thành công"),
                              itemBoxShare(
                                  linkIMG: "download_white.png",
                                  txt: "SaveQRCode",
                                  comicBook: comicBook,
                                  saveQr: true,
                                  showToast: true,
                                  msg: "Lưu thành công"),
                              itemBoxShare(
                                  linkIMG: "facebook_white.png",
                                  txt: "Facebook"),
                              itemBoxShare(
                                  linkIMG: "instagram_white.png",
                                  txt: "Instagram"),
                              itemBoxShare(
                                  linkIMG: "twitch_white.png", txt: "Twtitch"),
                              itemBoxShare(
                                  linkIMG: "instagram_white.png",
                                  txt: "Linkdn"),
                              itemBoxShare(
                                  linkIMG: "instagram_white.png",
                                  txt: "Messenger"),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      child: child,
    );
  }

  Widget itemBoxShare({
    required String linkIMG,
    required String txt,
    handleEvent,
    bool showToast = false,
    String msg = "",
    bool saveQr = false,
    ComicBook? comicBook,
  }) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                flex: 9,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GestureDetector(
                      onTap: saveQr
                          ? () async {
                              await handleSaveQrImage(
                                  qrImageData: comicBook!.toQrImage(
                                      color: Colors.white, size: 320),
                                  context: context);
                            }
                          : () {
                              showToast
                                  ? Fluttertoast.showToast(
                                      msg: msg,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      fontSize: 16,
                                    )
                                  : Fluttertoast();

                              handleEvent;
                            },
                      child: Container(
                        height: constraints.maxHeight,
                        width: constraints.maxHeight,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xff323436),
                          borderRadius: BorderRadius.all(
                            Radius.circular(constraints.maxHeight / 2),
                          ),
                        ),
                        child: BaseWidget().setImageIcon(
                            link: linkIMG, iconWH: constraints.maxHeight / 2),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: constraints.maxHeight,
                  child: BaseWidget()
                      .setText(txt: txt, fontWeight: FontWeight.w100),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget handleEventCopyClipboard(
      {required Widget child, required String data}) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: data));
      },
      child: child,
    );
  }

  Widget handleEventShowQR(
      {required Widget child, required qrcode, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Transform.scale(scale: 3, child: qrcode),
              ),
            );
          },
        );
      },
      child: child,
    );
  }

  //////////////////////////////////////////////
  ///
  ///
  ///
  ///
  Future<void> handleSaveQrImage(
      {qrImageData, required BuildContext context}) async {
    try {
      // Generate the QR code image
      final ByteData byteData =
          await qrImageData.toByteData(format: ui.ImageByteFormat.png);
      final buffer = byteData.buffer.asUint8List();

      // final result = await ImageGallerySaver.saveImage(buffer, quality: 100);

      // // Display a message based on the result
      // if (result['isSuccess']) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('QR code saved to gallery')),
      //   );
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Failed to save QR code')),
      //   );
      // }
    } catch (e) {
      print('Error saving QR code: $e');
    }
  }
}
