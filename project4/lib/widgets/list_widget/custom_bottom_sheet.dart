import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/models/comic/comic_book.dart';
import 'package:project4/utils/constants.dart';

import '../../repositories/interact_comic_repository.dart';
import '../../screens/details_comic_screen.dart';
import '../../utils/util_func.dart';
import '../base_widget.dart';

class CustomBottomSheet extends StatefulWidget {
  final ComicBook comicBook;

  const CustomBottomSheet({Key? key, required this.comicBook})
      : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  bool checkUserLogin =
      checkStringIsNotEmpty(sharedPreferences.getString('email'));

  Future<void> likeOrFavourite(String action, String id) async {
    if (!checkUserLogin) return;
    try {
      bool result = await GetIt.instance<InteractComicRepository>()
          .interactComic(action, widget.comicBook.id);
      setState(() {
        if (action == 'LIKE') {
          widget.comicBook.like = result;
          widget.comicBook.totalLike += (result ? 1 : -1);
        } else if (action == 'FAVOURITE') {
          widget.comicBook.favourite = result;
        }
      });
    } catch (e) {
      debug(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1.3,
      child: Container(
        padding: BaseWidget().setLefRightPadding(pLR: 20),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 34, 33, 31),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        // width: MediaQuery.of(context).size.width,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double heightRow1 = constraints.maxHeight * 0.05;
            double mangaInfoWidgetHeight = constraints.maxHeight * 0.33;
            double likeViewWidgetHeight = constraints.maxHeight * 0.24;
            double readFavouriteWidgetHeight = constraints.maxHeight * 0.24;
            return ListView(
              children: [
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: heightRow1 * 0.15,
                        ),
                      ),
                      Expanded(flex: 6, child: Container()),
                    ],
                  ),
                ),
                ////////////-----------------row2
                _mangaInfoWidget(mangaInfoWidgetHeight, widget.comicBook),
                _likeViewWidget(
                    likeViewWidgetHeight, widget.comicBook, checkUserLogin),
                _readAndFavouriteBtn(context, readFavouriteWidgetHeight,
                    widget.comicBook, checkUserLogin),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _mangaInfoWidget(double height, ComicBook comicBook) {
    return SizedBox(
      height: height,
      // padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: FittedBox(
                fit: BoxFit.cover,
                child: BaseWidget().setImageNetwork(link: comicBook.coverImage),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  /////////////////////
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BaseWidget().setText(
                          txt: comicBook.title, fontWeight: FontWeight.w900),
                    ),
                  ),
                  //////////////////////////
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BaseWidget().setText(
                          txt: "${comicBook.totalChapters} Chương",
                          fontSize: 10,
                          fontWeight: FontWeight.w100,
                          color: const Color(0xFFd8d8d8)),
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
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (Genre value in comicBook.genres)
                                FittedBox(
                                  fit: BoxFit.cover,
                                  child: Container(
                                    height: constraints.maxHeight - spacingWrap,

                                    margin: EdgeInsets.only(
                                        top: spacingWrap,
                                        bottom: spacingWrap,
                                        right: spacingWrap),

                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2)),
                                        color: Color(0xFF080401)),
                                    //
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: BaseWidget().setText(
                                          color: const Color(0xffD8d8d8),
                                          txt: value.genresName,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  ////////////////////////////////
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        comicBook.description,
                        style: const TextStyle(
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
    );
  }

  Widget _likeViewWidget(double height, ComicBook comicBook, bool isLogin) {
    IconData iconData = Icons.thumb_up;
    Color iconColor = comicBook.like ? Colors.blue : Colors.white;

    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: GestureDetector(
                          onTap: () {
                            likeOrFavourite('LIKE', comicBook.id);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.black),
                            child: BaseWidget()
                                .setIcon(iconData: iconData, color: iconColor),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: BaseWidget().setText(
                          txt: "${widget.comicBook.totalLike} lượt thích",
                          fontSize: 13,
                          fontWeight: FontWeight.w100,
                          color: const Color(0xffd8d8d8),
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
                child: SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.black),
                          child: BaseWidget().setIcon(
                              iconData: Icons.remove_red_eye_outlined),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: BaseWidget().setText(
                            txt: "${comicBook.totalRead} lượt xem",
                            fontSize: 13,
                            fontWeight: FontWeight.w100,
                            color: const Color(0xffd8d8d8)),
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
                    child: SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              width: double.infinity,
                              height: double.infinity,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.black),
                              child: BaseWidget().setIcon(
                                  iconData: Icons.share),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: BaseWidget().setText(
                                txt: "Chia sẻ",
                                fontSize: 13,
                                fontWeight: FontWeight.w100,
                                color: const Color(0xffd8d8d8)),
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
    );
  }

  Widget _readAndFavouriteBtn(
      BuildContext context, double height, ComicBook comicBook, bool isLogin) {
    String text = comicBook.favourite ? 'Hủy theo dõi' : 'Theo dõi ngay';
    IconData iconData = Icons.favorite;
    Color iconColor = comicBook.favourite ? Colors.red : Colors.white;
    return SizedBox(
      height: height,
      child: Column(
        children: [
          !isLogin
              ? SizedBox(
                  height: height / 2,
                )
              : Container(),
          Expanded(
            //IntrinsicWidth
            child: BaseWidget().handleEventNavigation(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Color(0xffD0480A),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: IntrinsicWidth(
                    child: Row(
                      children: [
                        BaseWidget().setText(txt: "Đọc ngay", fontSize: 15),
                        const SizedBox(
                          width: 5,
                        ),
                        BaseWidget().setIcon(
                            iconData: Icons.local_library),
                      ],
                    ),
                  ),
                ),
                pageTo: DetailsComicScreen(comicBook: comicBook),
                context: context),
          ),
          Container(
            height: 5,
          ),
          isLogin
              ? Expanded(
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: IntrinsicWidth(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              likeOrFavourite('FAVOURITE', comicBook.id);
                            },
                            child:
                                BaseWidget().setText(txt: text, fontSize: 15),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          BaseWidget()
                              .setIcon(iconData: iconData, color: iconColor),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
