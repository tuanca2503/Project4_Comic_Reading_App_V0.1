import 'package:flutter/material.dart';
import 'package:project4/config.dart';
import 'package:project4/models/chapter_comic_book.dart';
import 'package:project4/models/comic_book.dart';
import 'package:project4/models/part_comic_book.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/screens/rank_screen.dart';
import 'package:project4/widgets/base_widget.dart';

class DetailsComicScreen extends StatefulWidget {
  const DetailsComicScreen(
      {super.key,
      required this.comicBook,
      required this.baseConstraints,
      this.showButton = 0});
  final ComicBook comicBook;
  final BoxConstraints baseConstraints;
  final int showButton;

  @override
  State<DetailsComicScreen> createState() => _DetailsComicScreenState();
}

class _DetailsComicScreenState extends State<DetailsComicScreen> {
  bool showBoxChapter = true;

  bool showBoxDetail = false;
  int countClick = 0;

  String showPartComic = "";
  _DetailsComicScreenState();

  ///////////////////////////////////
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSwitchEvent(showButton: widget.showButton);
    showPartComic = widget.comicBook.partComicBook.first.partName;
  }

  void setSwitchEvent({required int showButton}) {
    //0 chapter||||||||||||||||1 details
    switch (showButton) {
      case 0:
        return setState(() {
          showBoxChapter = true;
          showBoxDetail = false;
        });
      case 1:
        return setState(() {
          showBoxChapter = false;
          showBoxDetail = true;
        });
    }
  }

  Widget handleEventSwitchWidget({required Widget child, required showButton}) {
    return GestureDetector(
      onTap: () {
        setSwitchEvent(showButton: showButton);
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        setAppBar: 2,
        baseConstraints: widget.baseConstraints,
        setBody: bodyDetailsComicScreen());
  }

  Widget bodyDetailsComicScreen() {
    double heightBackgroundBox = widget.baseConstraints.maxHeight * 0.6;
    double heightContentBox = widget.baseConstraints.maxHeight * 0.6;

    return Column(
      // child: ListView(
      children: [
        backgroundBox(heightBackgroundBox: heightBackgroundBox),
        contentBox(heightContentBox: heightContentBox)
      ],
      // ),
    );
  }

  Widget contentBox({required double heightContentBox}) {
    Color borderColor = Color(0xff1A1114);
    double ourRadius = 10;
    double scalePadding = 7;
    BorderRadius borderRadius = BorderRadius.all(Radius.circular(ourRadius));
    return Container(
      padding: BaseWidget().setLefRightPadding(pLR: 20),
      height: heightContentBox,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              ///////////////////////////
              Container(
                // margin: BaseWidget().setTopBottomPadding(pTB: 20),
                height: constraints.maxHeight * 0.16,
                padding: EdgeInsets.all(scalePadding),
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  border: Border.all(
                    width: 2,
                    color: borderColor,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(ourRadius / 2)),
                    color: borderColor,
                  ),
                  //transform.scale
                  child: Row(
                    children: [
                      //
                      buttonSwitch(
                          txt: "Danh sách",
                          scalePadding: scalePadding,
                          ourRadius: ourRadius,
                          showButton: 0),
                      //
                      buttonSwitch(
                          txt: "Thông tin",
                          scalePadding: scalePadding,
                          ourRadius: ourRadius,
                          showButton: 1)
                      //
                    ],
                  ),
                ),
              ),
              ////////////////////////////////////////
              Container(
                padding: EdgeInsets.only(top: 20),
                height: constraints.maxHeight * 0.84,

                ///
                child: showBoxDetail
                    ? ListView(
                        children: [
                          Container(
                            padding: BaseWidget().setTopBottomPadding(pTB: 10),
                            alignment: Alignment.centerLeft,
                            child: BaseWidget().setText(txt: "tóm tắt"),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.comicBook.description,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                        ],
                      )
                    : showBoxChapter
                        ? Column(
                            children: [
                              Expanded(
                                flex: 10,
                                child: Container(
                                  padding: EdgeInsets.only(top: 0),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return ListView(
                                        children: [
                                          //-------------------------------

                                          for (PartComicBook valuePartComic
                                              in widget.comicBook.partComicBook)
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (showPartComic ==
                                                          valuePartComic
                                                              .partName) {
                                                        showPartComic = "";
                                                      } else {
                                                        showPartComic =
                                                            valuePartComic
                                                                .partName;
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 0),
                                                    clipBehavior: Clip.hardEdge,
                                                    height:
                                                        constraints.maxHeight *
                                                            0.3,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                '${AppConfig.apiIP}${AppConfig.apiPort}${widget.comicBook.coverImage}'),
                                                            fit: BoxFit.cover),
                                                        borderRadius:
                                                            borderRadius),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      color: Color.fromARGB(
                                                          200, 0, 0, 0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 9,
                                                            child: Column(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: BaseWidget()
                                                                        .setText(
                                                                            txt:
                                                                                valuePartComic.partName),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: BaseWidget().setText(
                                                                        txt:
                                                                            "${valuePartComic.chapter.length} chuong",
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              child: (showPartComic ==
                                                                      valuePartComic
                                                                          .partName)
                                                                  ? BaseWidget()
                                                                      .setImageIcon(
                                                                          link:
                                                                              "up_orange.png")
                                                                  : BaseWidget()
                                                                      .setImageIcon(
                                                                          link:
                                                                              "down_orange.png"),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //////
                                                ///
                                                /// true show false null
                                                /////
                                                (showPartComic ==
                                                        valuePartComic.partName)
                                                    ? Column(
                                                        children: [
                                                          for (ChapterComicBook valueChapterComic
                                                              in valuePartComic
                                                                  .chapter)
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              height: constraints
                                                                      .maxHeight *
                                                                  0.25,
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                    // width: double.infinity,
                                                                    // height: double.infinity,
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                9,
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Container(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: BaseWidget().setText(txt: valueChapterComic.chapterName, color: Colors.white, fontSize: 15),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Container(
                                                                              child: BaseWidget().setText(txt: valueChapterComic.chapterDate, color: Colors.white, fontSize: 12),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height: 2,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Color(
                                                                          0xff16120F),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            2),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                        ],
                                                      )
                                                    : Container()

                                                //////////////
                                              ],
                                            ),

                                          //--------------------------------
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : null,

                ///
              )
              /////
            ],
          );
        },
      ),
    );
  }

  Widget buttonSwitch(
      {required String txt,
      required double scalePadding,
      required double ourRadius,
      required int showButton}) {
    //0 = chapter || 1 = details

    return Expanded(
      child: Container(
        margin:
            EdgeInsets.only(left: scalePadding / 2, right: scalePadding / 2),
        child: Transform.scale(
          scale: double.tryParse("1.0${scalePadding.toInt()}"),
          child: handleEventSwitchWidget(
            showButton: showButton,
            child: Container(
              alignment: Alignment.center,
              decoration: (showButton == 0)
                  ? showBoxChapter
                      ? BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(ourRadius / 2),
                          ),
                          color: Color(0xffD0480A),
                        )
                      : BoxDecoration()
                  : showBoxDetail
                      ? BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(ourRadius / 2),
                          ),
                          color: Color(0xffD0480A),
                        )
                      : BoxDecoration(),
              child: BaseWidget().setText(txt: txt, fontSize: scalePadding * 2),
            ),
          ),
        ),
      ),
    );
  }

  backgroundBox({required double heightBackgroundBox}) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: heightBackgroundBox,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              backgroundDetails(constraints: constraints),
              blurBottomBackground(constraints: constraints),
              ////////////////////background
              buttonShowRank(constraints: constraints),
              boxDetailsComic(
                  constraints: constraints, comicBook: widget.comicBook),
            ],
          );
        },
      ),
    );
  }

  Widget boxDetailsComic(
      {required BoxConstraints constraints, required ComicBook comicBook}) {
    return Positioned(
      bottom: 5,
      child: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight * 0.4,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: BaseWidget().setText(
                    txt: comicBook.title,
                    fontWeight: FontWeight.w900,
                    fontSize: 25),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: BaseWidget().setText(
                    txt: comicBook.author,
                    fontWeight: FontWeight.w100,
                    fontSize: 18,
                    color: Color.fromARGB(255, 197, 197, 197)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: BaseWidget().setText(
                    txt:
                        "${widget.comicBook.createdDate} - En course de publication",
                    fontWeight: FontWeight.w100,
                    fontSize: 15,
                    color: Color.fromARGB(255, 116, 116, 116)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  width: constraints.maxWidth / 2,
                  padding: EdgeInsets.all(3),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
//
                      for (Genre value in comicBook.genres)
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Container(
                            // height: constraints.maxHeight / 2 - 5,
                            margin: EdgeInsets.only(right: 2),
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2)),
                                color: Colors.black),
                            //
                            child: Align(
                              alignment: Alignment.center,
                              child: BaseWidget().setText(
                                  color: Colors.white,
                                  txt: value.genresName,
                                  fontSize: 3,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                        ),
                      //
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonShowRank({required BoxConstraints constraints}) {
    return Positioned(
        top: 10,
        right: 10,
        child: BaseWidget().handleEventNavigation(
            context: context,
            child: Container(
              // height: constraints.maxHeight * 0.1,
              padding: EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xffA2DCF7),
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: BaseWidget().setText(
                  txt: "Top ${1} bảng xếp hạng",
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w200,
                  fontSize: 12),
            ),
            pageTo: RankScreen(baseConstraints: widget.baseConstraints)));
  }

  Widget backgroundDetails({required BoxConstraints constraints}) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image.network(
            '${AppConfig.apiIP}${AppConfig.apiPort}${widget.comicBook.coverImage}'),
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
              Color(0xFF080401).withOpacity(1),
            ],
          ),
        ),
      ),
    );
  }
}
