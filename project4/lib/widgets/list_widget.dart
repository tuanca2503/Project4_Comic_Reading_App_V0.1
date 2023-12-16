import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project4/config.dart';
import 'package:project4/models/comic_book.dart';
import 'package:project4/models/handle_response_api.dart';
import 'package:project4/repositories/base_repository.dart';
import 'package:project4/screens/details_comic_screen.dart';
import 'package:project4/widgets/base_widget.dart';

class ListWidget extends StatefulWidget {
  ListWidget(
      {super.key,
      required this.setList,
      required this.comicBooks,
      required this.baseConstraints,
      required this.baseRepository});
  final BaseRepository baseRepository;
  final int setList;
  final List<ComicBook> comicBooks;
  final BoxConstraints baseConstraints;

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.95);

  @override
  Widget build(BuildContext context) {
    switch (widget.setList) {
      case 0:
        return myPageView(myList: widget.comicBooks);

      case 1:
        return mylistView(myList: widget.comicBooks);
      case 2:
        return myPaging(myList: widget.comicBooks);
      default:
        return Container(
          child: BaseWidget().setText(
              txt: "0 is Pageview,1 is list view not ${widget.setList}"),
        );
    }
  }

//////////////-------------------------------------------
  Widget itemListView(
      {required BoxConstraints constraints, required ComicBook comicBook}) {
    return Container(
      padding: BaseWidget().setLefRightPadding(pLR: 10),
      width: constraints.maxWidth / 2 - 10,
      height: constraints.maxHeight,
      child: Column(
        children: [
          Expanded(
            flex: 11,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.cover,
                child: myEventHandler(
                    child: BaseWidget()
                        .setImageNetwork(link: comicBook.coverImage),
                    comicBook: comicBook),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: BaseWidget().setText(
                    txt: "${comicBook.title} ",
                    fontSize: 18,
                    fontWeight: FontWeight.w100),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (Genre value in comicBook.genres)
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Container(
                          // height: constraints.maxHeight / 2 - 5,

                          padding: const EdgeInsets.all(3),

                          //
                          child: Align(
                            alignment: Alignment.center,
                            child: BaseWidget().setText(
                                color: Color(0xffD8d8d8),
                                txt: value.genresName,
                                fontSize: 6,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

/////////////-------------------------------------------
  Widget mylistView(
      {required List myList, Axis axis = Axis.horizontal, int limit = 10}) {
    return LayoutBuilder(builder: (context, constraints) {
      // return ListView(
      //   scrollDirection: axis,
      //   children: [
      //     for (var value in myList)
      //       itemListView(constraints: constraints, comicBook: value),

      //     //

      //     //
      //     ///
      //   ],
      // );
      return ListView.builder(
        scrollDirection: axis,
        itemCount: (limit > myList.length)
            ? myList.length
            : limit, // Giới hạn số lượng item hiển thị
        itemBuilder: (BuildContext context, int index) {
          return itemListView(
              constraints: constraints, comicBook: myList[index]);
        },
      );
      //////////////////////////////////
      ///
    });
  }

/////////////-------------------------------------------
  final int itemsPerPage = 7;
  int currentPage = 1;

  //

//////////////////////////////////////

  List<ComicBook> getCurrentPageItems({required List<ComicBook> itemList}) {
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = currentPage * itemsPerPage;
    endIndex = endIndex > itemList.length ? itemList.length : endIndex;
    return itemList.sublist(startIndex, endIndex);
  }

  ///
  Widget myPaging({required List<ComicBook> myList}) {
    return LayoutBuilder(builder: (cont, cons) {
      double heightBottomPaging = cons.maxHeight * 0.08;
      double heightBodyPaging = cons.maxHeight - heightBottomPaging;

      return Container(
        padding: BaseWidget().setLefRightPadding(pLR: 10),
        width: cons.maxWidth,
        height: cons.maxHeight,
        child: Column(
          children: [
            // Content for the current page
            Container(
                height: heightBodyPaging,
                child: Column(
                  children: [
                    for (ComicBook item
                        in getCurrentPageItems(itemList: myList))
                      itemPageView(
                          comicBook: item, setBack: false, setBackBlur: false),
                    if (getCurrentPageItems(itemList: myList).length <
                        itemsPerPage)
                      for (int i = getCurrentPageItems(itemList: myList).length;
                          i < itemsPerPage;
                          i++)
                        Expanded(child: Container()),
                  ],
                )

                // SizedBox(height: 20),,
                ),

            // Pagination controls

            Container(
              width: cons.maxWidth,
              height: heightBottomPaging,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (currentPage > 1) {
                            setState(() {
                              currentPage--;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: BaseWidget().setText(
                        txt:
                            '$currentPage/${(myList.length / itemsPerPage).ceil()}',
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          int totalPages =
                              (myList.length / itemsPerPage).ceil();
                          // In a real application, you would check if there are more pages
                          // before incrementing the currentPage.
                          if (currentPage < totalPages) {
                            setState(() {
                              currentPage++;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  ///
  Widget buildLoadMoreButton() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          currentPage++;
          // Refresh the UI to load the next page
          // This can be done using setState in a StatefulWidget
        },
        child: Text('Load More'),
      ),
    );
  }
/////////////-------------------------------------------

  Widget myPageView({required List myList, int limit = 10}) {
    List<List<dynamic>> chunks = [];
    for (var i = 0;
        i < ((limit > myList.length) ? myList.length : limit);
        i += 3) {
      chunks.add(
          myList.sublist(i, i + 3 > myList.length ? myList.length : i + 3));
    }
    return PageView.builder(
      controller: _pageController,
      itemCount: chunks.length,
      itemBuilder: (context, index) {
        // final comicBook = comicBooks[index];
        return Container(
          padding: EdgeInsets.only(right: 10),
          child: Column(
            children: [
              for (var comicBook in chunks[index])
                itemPageView(comicBook: comicBook),
              if (chunks[index].length < 3)
                for (int i = chunks[index].length; i < 3; i++)
                  Expanded(child: Container()),
            ],
          ),
        );
      },
    );
  }

/////////////-------------------------------------------
  Widget itemPageView(
      {required ComicBook comicBook, setBackBlur = true, setBack = true}) {
    BorderRadius borderRadius = BorderRadius.all(Radius.circular(10));
    /*child: myEventHandler(
                    child: BaseWidget().setImageAsset(comicBook.linkImage),
                    comicBook: comicBook), */
    return Expanded(
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: BaseWidget().setTopBottomPadding(pTB: 5),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: setBack
              ? DecorationImage(
                  image: NetworkImage(
                      '${AppConfig.apiIP}${AppConfig.apiPort}${comicBook.coverImage}',
                      headers: {
                        'ngrok-skip-browser-warning': 'true',
                      }),
                  fit: BoxFit.cover)
              : null,
        ),
        child: Stack(
          children: [
            setBackBlur
                ? BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 8, sigmaY: 8), // Adjust the blur intensity
                    child: Container(
                      color: Colors.black
                          .withOpacity(0.3), // Adjust the opacity of the blur
                    ),
                  )
                : Container(),
            //

            ////////////////////////////////////////////////////
            myEventHandler(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration:
                                BoxDecoration(borderRadius: borderRadius),
                            child: BaseWidget()
                                .setImageNetwork(link: comicBook.coverImage)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 8,
                        child: SizedBox(
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: BaseWidget().setText(
                                      txt: comicBook.title, fontSize: 10),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      double spacingWrap = 3;
                                      return Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(),
                                        child: Wrap(
                                          spacing: spacingWrap,
                                          runSpacing: spacingWrap,
                                          children: [
                                            for (Genre value
                                                in comicBook.genres)
                                              FittedBox(
                                                fit: BoxFit.cover,
                                                child: Container(
                                                  height:
                                                      constraints.maxHeight /
                                                              2 -
                                                          spacingWrap,

                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          2)),
                                                          color: Color(
                                                              0xFF080401)),
                                                  //
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: BaseWidget().setText(
                                                        color:
                                                            Color(0xffD8d8d8),
                                                        txt: value.genresName,
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w100),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: BaseWidget().setText(
                                      txt: "${comicBook.totalChapters} Chương",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w100,
                                      color: Color(0xFFd8d8d8)),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return Row(
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            alignment: Alignment.bottomLeft,
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: BaseWidget().setImageIcon(
                                                      link:
                                                          'eye_full_grey.png'),
                                                ),
                                                Container(
                                                  child: BaseWidget().setText(
                                                    txt:
                                                        "${comicBook.totalRead}",
                                                    fontSize: 8.3,
                                                    fontWeight: FontWeight.w100,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            alignment: Alignment.bottomLeft,
                                            child: Row(
                                              children: [
                                                BaseWidget().setImageIcon(
                                                    link:
                                                        'heart_full_grey.png'),
                                                BaseWidget().setText(
                                                  txt:
                                                      "${comicBook.totalFavourite}",
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            alignment: Alignment.bottomLeft,
                                            child: Row(
                                              children: [
                                                BaseWidget().setImageIcon(
                                                    link: 'like_full_grey.png'),
                                                BaseWidget().setText(
                                                  txt: "${comicBook.totalLike}",
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                comicBook: comicBook),
            ////////////////////////////////////////////////
          ],
        ),
      ),
    );
  }
  /////////////-------------------------------------------
  ///
  ///
  ///
  ///
  ///
  ///
  ///

  /////////////-------------------------------------------handle when i touch
  Widget myEventHandler({required Widget child, required ComicBook comicBook}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsComicScreen(
                baseRepository: widget.baseRepository,
                comicBook: comicBook,
                baseConstraints: widget.baseConstraints),
          ),
        );
      },
      onLongPress: () async {
        ResultCallAPI response = await widget.baseRepository.comicsRepository
            .getDetailsComics(thisComicBook: comicBook);

        comicBook = response.data;
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          // backgroundColor: Color(0xff22211F),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(20),
          //       topRight: Radius.circular(20)),
          // ),

          context: context,
          builder: (BuildContext context) {
            return FractionallySizedBox(
              heightFactor: 1.3,
              child: Container(
                padding: BaseWidget().setLefRightPadding(pLR: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 34, 33, 31),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                // width: MediaQuery.of(context).size.width,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    //30 425 0.07
                    //160 425 82
                    //100 425 82
                    double heightRow1 = constraints.maxHeight * 0.05;
                    double heightRow2 = constraints.maxHeight * 0.33; //0.35 -10
                    double heightRow3 = constraints.maxHeight * 0.24; //0.3 - 30
                    double heightRow4 = constraints.maxHeight * 0.24; //0.3 -30
                    //146 116 02 024 -- 170 160 26 487
                    ////////////////////----------------------
                    return ListView(
                      children: [
                        ////////////----------------- row1
                        Container(
                          padding: EdgeInsets.all(heightRow1 / 2),
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
                                  height: heightRow1 * 0.15,
                                ),
                              ),
                              Expanded(flex: 6, child: Container()),
                            ],
                          ),
                        ),
                        ////////////-----------------row2
                        Container(
                          height: heightRow2,
                          // padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: double.infinity,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: BaseWidget().setImageNetwork(
                                        link: comicBook.coverImage),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      /////////////////////
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: BaseWidget().setText(
                                                txt: comicBook.title,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      ),
                                      //////////////////////////
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: BaseWidget().setText(
                                              txt:
                                                  "${comicBook.totalChapters} Chương ",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w100,
                                              color: Color(0xFFd8d8d8)),
                                        ),
                                      ),
                                      ///////////////////////////////////////////
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              double spacingWrap = 3;
                                              return Container(
                                                child: ListView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: [
                                                    for (Genre value
                                                        in comicBook.genres)
                                                      FittedBox(
                                                        fit: BoxFit.cover,
                                                        child: Container(
                                                          height: constraints
                                                                  .maxHeight -
                                                              spacingWrap,

                                                          margin: EdgeInsets.only(
                                                              top: spacingWrap,
                                                              bottom:
                                                                  spacingWrap,
                                                              right:
                                                                  spacingWrap),

                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration: const BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              2)),
                                                              color: Color(
                                                                  0xFF080401)),
                                                          //
                                                          child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: BaseWidget().setText(
                                                                color: Color(
                                                                    0xffD8d8d8),
                                                                txt: value
                                                                    .genresName,
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w100),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      ////////////////////////////////
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          padding: EdgeInsets.only(top: 10),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            comicBook.description,
                                            style: TextStyle(
                                                color: Color(0xffd8d8d8),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w100),
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //////////////////////////////
                        Container(
                          height: heightRow3,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: constraints.maxHeight * 0.6,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              width: double.infinity,
                                              height: double.infinity,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Colors.black),
                                              child: BaseWidget().setImageIcon(
                                                  link: "like_full_grey.png"),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: BaseWidget().setText(
                                              txt:
                                                  "${comicBook.totalLike} lượt thích",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w100,
                                              color: Color(0xffd8d8d8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: constraints.maxHeight * 0.6,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              width: double.infinity,
                                              height: double.infinity,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Colors.black),
                                              child: BaseWidget().setImageIcon(
                                                  link: "eye_full_grey.png"),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: BaseWidget().setText(
                                                txt:
                                                    "${comicBook.totalRead} lượt xem",
                                                fontSize: 13,
                                                fontWeight: FontWeight.w100,
                                                color: Color(0xffd8d8d8)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: BaseWidget().handleEventShare(
                                        child: Container(
                                          height: constraints.maxHeight * 0.6,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 8,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 5),
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: Colors.black),
                                                  child: BaseWidget()
                                                      .setImageIcon(
                                                          link:
                                                              "share_grey.png"),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: BaseWidget().setText(
                                                    txt: "Chia sẻ",
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w100,
                                                    color: Color(0xffd8d8d8)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        context: context,
                                        comicBook: comicBook),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Container(
                          height: heightRow4,
                          child: Column(
                            children: [
                              Expanded(
                                //IntrinsicWidth
                                child: BaseWidget().handleEventNavigation(
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Color(0xffD0480A),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: IntrinsicWidth(
                                        child: Row(
                                          children: [
                                            BaseWidget().setText(
                                                txt: "Đọc ngay", fontSize: 15),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            BaseWidget().setImageIcon(
                                                link: "books_white.png")
                                          ],
                                        ),
                                      ),
                                    ),
                                    pageTo: DetailsComicScreen(
                                        baseRepository: widget.baseRepository,
                                        comicBook: comicBook,
                                        baseConstraints:
                                            widget.baseConstraints),
                                    context: context),
                              ),
                              Container(
                                height: 5,
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: IntrinsicWidth(
                                    child: Row(
                                      children: [
                                        BaseWidget().setText(
                                            txt: true
                                                ? "Theo dõi ngay"
                                                : "Hủy theo dõi",
                                            fontSize: 15),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        BaseWidget().setImageIcon(
                                            link: true
                                                ? "heart_white.png"
                                                : "heart_full_white.png"),
                                      ],
                                    ),
                                  ),
                                ),
                              )
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
}
