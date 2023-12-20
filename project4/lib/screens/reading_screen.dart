import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/main.dart';
import 'package:project4/models/comic/comic_book.dart';
import 'package:project4/repositories/chapter_repository.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen(
      {super.key,
      required this.chapterComicBook,
      required this.listChapterComicBook});

  final ChapterComicBook chapterComicBook;
  final List<ChapterComicBook> listChapterComicBook;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  @override
  void initState() {
    super.initState();
    double screenWidth = baseConstraints.maxWidth;
    fontSize = screenWidth * 0.03;
    fontFour = screenWidth * 0.04;
    fontBac = screenWidth * 0.02;
    fontBack = screenWidth * 0.05;
    create = screenWidth * 0.025;
    _chapterComicBook = widget.chapterComicBook;
  }

  double? fontSize;
  double? fontFour;
  double? fontBac;
  double? fontBack;
  double? create;

  bool showBars = true;

  ChapterComicBook _chapterComicBook = ChapterComicBook();
  final ScrollController _readingScroll = ScrollController();

////////////////////////////////////////
  void scrollToItem({required int index}) {
    try {
      if (_readingScroll.hasClients && _readingScroll.position != null) {
        _readingScroll.animateTo(index * 21.9,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    } catch (e) {
      print(e);
    }
  }

//scrollToItem(index: currentChapter);
////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      setBody: BaseWidget().setFutureBuilder(
        callback: (snapshot) {
          return bodyReadingScreen(chapterComicBook: snapshot.data);
        },
        repo: GetIt.instance<ChapterRepository>()
            .getChapterComic(chapter: _chapterComicBook),
      ),
    );
  }

  Widget bodyReadingScreen({required ChapterComicBook chapterComicBook}) {
    double heightHeadBott = baseConstraints.maxHeight * 0.08;
    // print(chapterComicBook.images.length);
    // final visibilityProvider = context.read<VisibilityProvider>();

    return Consumer<ScreenProvider>(
      builder: (context, visibilityProvider, child) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                visibilityProvider.toggleVisibility();
              },
              child: SizedBox(
                height: baseConstraints.maxHeight,
                width: baseConstraints.maxWidth,
                child: ListView.builder(
                  itemCount: chapterComicBook.images.length,
                  itemBuilder: (context, index) {
                    return IntrinsicHeight(
                      child: Image.network(
                          '${Environment.apiUrl}/${chapterComicBook.images[index]}'),
                    );
                  },
                ),
              ),
            ),

            visibilityProvider.isVisible
                ? Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: headerBar(
                      heightHeadBott: heightHeadBott,
                    ),
                  )
                : Container(),

            /////

            visibilityProvider.isVisible
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: bottomBar(heightHeadBott: heightHeadBott),
                  )
                : Container(),
          ],
        );
      },
    );
  }

//

//
  Widget headerBar({
    required heightHeadBott,
  }) {
    return Container(
      color: BaseWidget().setColorBlack(),
      height: heightHeadBott,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: BaseWidget().handleEventBackNavigation(
                child: SizedBox(
                  height: heightHeadBott,
                  child: Transform.scale(
                    scale: 1,
                    child:
                        BaseWidget().setIcon(iconData: Icons.navigate_before),
                  ),
                ),
                context: context),
          ),
          Expanded(
            flex: 8,
            child: Container(),
          ),
///////

          /////
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget bottomBar({required heightHeadBott}) {
    int currentChapter = widget.listChapterComicBook
        .indexWhere((item) => item.id == _chapterComicBook.id);
    int totalChapter = widget.listChapterComicBook.length - 1;
    double heightListChapter = heightHeadBott * 6;
    double heightItemChapter = heightListChapter * 0.12;

    ///
    ////
    return Consumer<ScreenProvider>(builder: (context, provider, child) {
      return Container(
        color: Colors.transparent,
        height: provider.showAllChapter
            ? heightHeadBott + heightListChapter
            : heightHeadBott,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(5),
                color: BaseWidget().setColorBlack(),
                height: heightHeadBott,
                width: baseConstraints.maxWidth,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: (currentChapter > 0 && currentChapter != 0)
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _chapterComicBook =
                                        widget.listChapterComicBook[
                                            currentChapter - 1];
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: BaseWidget()
                                          .setIcon(iconData: Icons.arrow_back),
                                    ),
                                    Text(
                                      'Trước',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontFour,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: GestureDetector(
                        onTap: () {
                          provider.toggleShowAllChapter();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _chapterComicBook.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fontFour,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Icon(
                              provider.showAllChapter
                                  ? Icons.arrow_drop_down_outlined
                                  : Icons.arrow_drop_up_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: (currentChapter < totalChapter &&
                                currentChapter != totalChapter)
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _chapterComicBook =
                                        widget.listChapterComicBook[
                                            currentChapter + 1];
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Sau',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontFour,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 0.8,
                                      child: BaseWidget().setIcon(
                                          iconData: Icons.arrow_forward),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            provider.showAllChapter
                ? Positioned(
                    left: baseConstraints.maxWidth / 2 -
                        (baseConstraints.maxWidth / 4),
                    top: 1,
                    child: Container(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(heightListChapter * 0.02),
                              topRight:
                                  Radius.circular(heightListChapter * 0.02))),
                      width: baseConstraints.maxWidth / 2,
                      height: heightListChapter,
                      child: ListView.builder(
                        controller: _readingScroll,
                        itemCount: widget.listChapterComicBook.length,
                        itemBuilder: (cont, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _chapterComicBook =
                                    widget.listChapterComicBook[index];
                              });
                              scrollToItem(index: currentChapter);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: (widget.listChapterComicBook[index].id ==
                                        _chapterComicBook.id)
                                    ? Colors.orange
                                    : null,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(heightListChapter * 0.02)),
                                border:
                                    (widget.listChapterComicBook[index].id ==
                                            _chapterComicBook.id)
                                        ? null
                                        : const Border(
                                            bottom: BorderSide(
                                                width: 1, color: Colors.white),
                                          ),
                              ),
                              height: heightItemChapter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BaseWidget().setText(
                                      txt: widget
                                          .listChapterComicBook[index].name,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w100)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      );
    });
  }
}
