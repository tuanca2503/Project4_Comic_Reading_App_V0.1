import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/main.dart';
import 'package:project4/models/comic/comic_book.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/screens/reading_screen.dart';
import 'package:project4/screens/search_screen.dart';
import 'package:project4/utils/util_func.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:provider/provider.dart';

import '../repositories/comics_repository.dart';
import '../utils/constants.dart';

class DetailsComicScreen extends StatefulWidget {
  const DetailsComicScreen(
      {super.key, required this.comicBook, this.showButton = 0});

  final ComicBook comicBook;
  final int showButton;

  @override
  State<DetailsComicScreen> createState() => _DetailsComicScreenState();
}

class _DetailsComicScreenState extends State<DetailsComicScreen> {
  ///////////////////////////////////
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setSwitchEvent(showButton: widget.showButton);
    partComic = 'Danh sách chương';
  }

  String partComic = '';

  //////////////////////////////////////////

  // void setSwitchEvent({required int showButton}) {
  //   //0 chapter||||||||||||||||1 details
  //   switch (showButton) {
  //     case 0:
  //       return setState(() {
  //         showBoxChapter = true;
  //         showBoxDetail = false;
  //       });
  //     case 1:
  //       return setState(() {
  //         showBoxChapter = false;
  //         showBoxDetail = true;
  //       });
  //   }
  // }

  Widget handleEventSwitchWidget(
      {required Widget child,
      required ScreenProvider screenProvider,
      required int showButton}) {
    return GestureDetector(
      onTap: () {
        // setSwitchEvent(showButton: showButton);
        screenProvider.toggleDetailsScreen(showButton: showButton);
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(setAppBar: 2, setBody: bodyDetailsComicScreen());
  }

  Widget bodyDetailsComicScreen() {
    double heightBackgroundBox = baseConstraints.maxHeight * 0.6;
    double heightContentBox = baseConstraints.maxHeight * 0.6;

    return BaseWidget().setFutureBuilder(
        callback: (snapshot) {
          debug(snapshot);
          return Column(
            children: [
              backgroundBox(
                  heightBackgroundBox: heightBackgroundBox,
                  comicBook: snapshot.data),
              contentBox(
                  heightContentBox: heightContentBox, comicBook: snapshot.data)
            ],
          );
        },
        repo: GetIt.instance<ComicsRepository>()
            .getDetailsComics(thisComicBook: widget.comicBook));
  }

  Widget contentBox(
      {required double heightContentBox, required ComicBook comicBook}) {
    Color borderColor = const Color(0xff1A1114);
    double ourRadius = 10;
    double scalePadding = 7;
    BorderRadius borderRadius = BorderRadius.all(Radius.circular(ourRadius));
    return Container(
      padding: BaseWidget().setLefRightPadding(pLR: 20),
      height: heightContentBox,
      child: LayoutBuilder(
        builder: (context, constraints) {
          int i = -1;
          return Consumer<ScreenProvider>(
              builder: (context, myProvider, child) {
            i++;
            if (i == 0) {
              myProvider.showPartDetailsScreen = partComic;

              switch (widget.showButton) {
                case 0:
                  myProvider.boxChapterDetailsScreen = true;
                  myProvider.boxDetailDetailsScreen = false;
                  break;

                case 1:
                  myProvider.boxChapterDetailsScreen = false;
                  myProvider.boxDetailDetailsScreen = true;
                  break;
              }
            }
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
                            screenProvider: myProvider,
                            txt: "Danh sách",
                            scalePadding: scalePadding,
                            ourRadius: ourRadius,
                            showButton: 0),
                        //
                        buttonSwitch(
                            screenProvider: myProvider,
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
                  padding: const EdgeInsets.only(top: 20),
                  height: constraints.maxHeight * 0.84,

                  ///
                  child: myProvider.boxDetailDetailsScreen
                      ? ListView(
                          children: [
                            Container(
                              padding:
                                  BaseWidget().setTopBottomPadding(pTB: 10),
                              alignment: Alignment.centerLeft,
                              child: BaseWidget().setText(txt: "Tóm tắt"),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                comicBook.description,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w100),
                              ),
                            ),
                          ],
                        )
                      : myProvider.boxChapterDetailsScreen
                          ? Column(
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        return ListView(
                                          children: [
                                            //-------------------------------

                                            // for (PartComicBook valuePartComic
                                            //     in comicBook.partComicBook)
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // print(myProvider
                                                    //     .showPartDetailsScreen);
                                                    myProvider.toggleShowPart(
                                                        partComic);
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 0),
                                                    clipBehavior: Clip.hardEdge,
                                                    height:
                                                        constraints.maxHeight *
                                                            0.25,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                '${Environment.apiUrl}/${comicBook.coverImage}'),
                                                            fit: BoxFit.cover),
                                                        borderRadius:
                                                            borderRadius),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      color:
                                                          const Color.fromARGB(
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
                                                                                partComic),
                                                                  ),
                                                                ),
                                                                /*comicBook.currentReadChapterId != null ?
                                                                Expanded(
                                                                  child:
                                                                  BaseWidget()
                                                                      .handleEventNavigation(
                                                                      child:
                                                                      Container(
                                                                        padding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                        height: constraints
                                                                            .maxHeight *
                                                                            0.25,
                                                                        child:
                                                                        Column(
                                                                          children: [
                                                                            Expanded(
                                                                              // width: double.infinity,
                                                                              // height: double.infinity,
                                                                              child:
                                                                              Row(
                                                                                children: [
                                                                                  Column(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          alignment: Alignment.centerLeft,
                                                                                          child: BaseWidget().setText(txt: 'Chapter đang đọc: ${comicBook.currentReadChapterName ?? ''}', color: Colors.white, fontSize: 15),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width:
                                                                              double.infinity,
                                                                              height:
                                                                              2,
                                                                              decoration:
                                                                              const BoxDecoration(
                                                                                color: Color(0xff16120F),
                                                                                borderRadius: BorderRadius.all(
                                                                                  Radius.circular(2),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      pageTo: ReadingScreen(
                                                                        chapterComicBook:
                                                                        comicBook
                                                                            .listChapters.firstWhere((c) => c.id == comicBook.currentReadChapterId),),
                                                                      context:
                                                                      context),
                                                                ) : Container(),*/
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: BaseWidget().setText(
                                                                        txt:
                                                                            "${comicBook.totalChapters} chương",
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
                                                              child: (myProvider
                                                                          .showPartDetailsScreen ==
                                                                      partComic)
                                                                  ? BaseWidget().setIcon(iconData: Icons.arrow_drop_up, color: Colors.orange)
                                                                  : BaseWidget().setIcon(iconData: Icons.arrow_drop_down, color: Colors.orange),
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

                                                (myProvider.showPartDetailsScreen ==
                                                        partComic)
                                                    ? Column(
                                                        children: [
                                                          for (ChapterComicBook valueChapterComic
                                                              in comicBook
                                                                  .listChapters)
                                                            BaseWidget()
                                                                .handleEventNavigation(
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          10),
                                                                      height: constraints
                                                                              .maxHeight *
                                                                          0.25,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Expanded(
                                                                            // width: double.infinity,
                                                                            // height: double.infinity,
                                                                            child:
                                                                                Container(
                                                                              child: Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    flex: 7,
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: Container(
                                                                                            alignment: Alignment.centerLeft,
                                                                                            child: BaseWidget().setText(txt: valueChapterComic.name, color: Colors.white, fontSize: 15),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    flex: 3,
                                                                                    child: Container(
                                                                                      child: BaseWidget().setText(txt: valueChapterComic.lastUpdatedDate.toString(), color: Colors.white, fontSize: 10),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                2,
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              color: Color(0xff16120F),
                                                                              borderRadius: BorderRadius.all(
                                                                                Radius.circular(2),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    pageTo:
                                                                        ReadingScreen(
                                                                      chapterComicBook:
                                                                          valueChapterComic,
                                                                    ),
                                                                    context:
                                                                        context)
                                                          ////////////////////////////
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
                ),
                /////
              ],
            );
          });
        },
      ),
    );
  }

  Widget buttonSwitch(
      {required String txt,
      required ScreenProvider screenProvider,
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
            screenProvider: screenProvider,
            showButton: showButton,
            child: Container(
              alignment: Alignment.center,

              /// here

/////
              //////////
              decoration: (showButton == 0)
                  ? screenProvider.boxChapterDetailsScreen
                      ? BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(ourRadius / 2),
                          ),
                          color: const Color(0xffD0480A),
                        )
                      : const BoxDecoration()
                  : screenProvider.boxDetailDetailsScreen
                      ? BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(ourRadius / 2),
                          ),
                          color: const Color(0xffD0480A),
                        )
                      : const BoxDecoration(),

              //
              child: BaseWidget().setText(txt: txt, fontSize: scalePadding * 2),
            ),
          ),
        ),
      ),
    );
  }

  backgroundBox(
      {required double heightBackgroundBox, required ComicBook comicBook}) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: heightBackgroundBox,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              backgroundDetails(constraints: constraints, comicBook: comicBook),
              blurBottomBackground(constraints: constraints),
              ////////////////////background
              buttonShowRank(constraints: constraints),
              boxDetailsComic(constraints: constraints, comicBook: comicBook),
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
                    color: const Color.fromARGB(255, 197, 197, 197)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: BaseWidget().setText(
                    txt:
                        "Thời gian tải lên - ${formatDateFromTs(comicBook.createdDate)}",
                    fontWeight: FontWeight.w100,
                    fontSize: 15,
                    color: const Color.fromARGB(255, 116, 116, 116)),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  width: constraints.maxWidth / 2,
                  padding: const EdgeInsets.all(3),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
//
                      for (Genre value in comicBook.genres)
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Container(
                            // height: constraints.maxHeight / 2 - 5,
                            margin: const EdgeInsets.only(right: 2),
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
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xffA2DCF7),
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: BaseWidget().setText(
                  txt: "Top ${1} bảng xếp hạng",
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w200,
                  fontSize: 12),
            ),
            pageTo: const SearchScreen()));
  }

  Widget backgroundDetails(
      {required BoxConstraints constraints, required ComicBook comicBook}) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image.network('${Environment.apiUrl}/${comicBook.coverImage}'),
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
              const Color(0xFF080401).withOpacity(1),
            ],
          ),
        ),
      ),
    );
  }
}
