import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/comic/comic_book.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/list_widget/custom_bottom_sheet.dart';

import '../../repositories/comics_repository.dart';
import '../../repositories/interact_comic_repository.dart';
import '../../screens/details_comic_screen.dart';

final comicsRepository = GetIt.instance<ComicsRepository>();
final interactComicRepository = GetIt.instance<InteractComicRepository>();

Widget myEventHandler(
    {required BuildContext context,
    required Widget child,
    required ComicBook comicBook}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsComicScreen(comicBook: comicBook),
        ),
      );
    },
    onLongPress: () async {
      comicBook =
          await comicsRepository.getDetailsComics(thisComicBook: comicBook);
      // ignore: use_build_context_synchronously
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return CustomBottomSheet(comicBook: comicBook);
        },
      );
    },
    child: child,
  );
}

Widget itemPageView(
    {required BuildContext context,
    required ComicBook comicBook,
    setBackBlur = true,
    setBack = true}) {
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10));
  return Expanded(
    child: Container(
      clipBehavior: Clip.hardEdge,
      margin: BaseWidget().setTopBottomPadding(pTB: 5),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: setBack
            ? DecorationImage(
                image: NetworkImage(
                  '${Environment.apiUrl}/${comicBook.coverImage}',
                ),
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
          myEventHandler(
              context: context,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(borderRadius: borderRadius),
                          child: BaseWidget()
                              .setImageNetwork(link: comicBook.coverImage)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 8,
                      child: SizedBox(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: BaseWidget().setText(
                                    txt: comicBook.title, fontSize: 12),
                              ),
                            ),
                            // scroll horizontal categories
                            Expanded(
                              flex: 2,
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
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: BaseWidget().setText(
                                                  color: const Color(0xffD8d8d8),
                                                  txt: value.genresName,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w100),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // wrap categories
                            /*Expanded(
                              flex: 6,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    double spacingWrap = 3;
                                    return Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(),
                                      child: Wrap(
                                        spacing: spacingWrap,
                                        runSpacing: spacingWrap,
                                        children: [
                                          for (Genre value in comicBook.genres)
                                            FittedBox(
                                              fit: BoxFit.cover,
                                              child: Container(
                                                height:
                                                    constraints.maxHeight / 2 -
                                                        spacingWrap,

                                                padding:
                                                    const EdgeInsets.all(3),
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(2)),
                                                    color: Color(0xFF080401)),
                                                //
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: BaseWidget().setText(
                                                      color: const Color(
                                                          0xffD8d8d8),
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
                            ),*/
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: BaseWidget().setText(
                                    txt: "${comicBook.totalChapters} Chương",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w100,
                                    color: const Color(0xFFd8d8d8)),
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
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          alignment: Alignment.bottomLeft,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: BaseWidget().setIcon(
                                                    iconData: Icons
                                                        .remove_red_eye_outlined,
                                                    size: 12),
                                              ),
                                              Container(
                                                child: BaseWidget().setText(
                                                  txt: " ${comicBook.totalRead}",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          alignment: Alignment.bottomLeft,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              BaseWidget().setIcon(
                                                  iconData: Icons.favorite,
                                                  size: 12),
                                              BaseWidget().setText(
                                                txt:
                                                    " ${comicBook.totalFavourite}",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w100,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          alignment: Alignment.bottomLeft,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              BaseWidget().setIcon(
                                                  iconData: Icons.thumb_up,
                                                  size: 12),
                                              BaseWidget().setText(
                                                txt: " ${comicBook.totalLike}",
                                                fontSize: 12,
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
