import 'package:flutter/material.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/main.dart';
import 'package:project4/models/comic/chapter/chapter_detail.dart';
import 'package:project4/models/comic/chapter/page_chapter_item.dart';
import 'package:project4/repositories/chapter_repository.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:provider/provider.dart';

import '../utils/app_dimension.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen(
      {super.key, required this.chapterId, required this.chapterList});

  final String chapterId;
  final List<PageChapterItem> chapterList;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  ChapterDetail? chapterDetail;

  @override
  void initState() {
    super.initState();
    ChapterRepository.instance.getChapterComic(id: widget.chapterId).then((value) {
      setState(() {
        chapterDetail = value;
      });
    });
  }

  bool showBars = true;

  final ScrollController _readingScroll = ScrollController();

  void scrollToItem({required int index}) {
    try {
      if (_readingScroll.hasClients) {
        _readingScroll.animateTo(index * 21.9,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chapterDetail == null
          ? BaseWidget.instance.loadingWidget()
          : bodyReadingScreen(),
    );
  }

  Widget bodyReadingScreen() {
    double heightHeadBott = AppDimension.baseConstraints.maxHeight * 0.08;

    return Consumer<ScreenProvider>(
      builder: (context, visibilityProvider, child) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                visibilityProvider.toggleVisibility();
              },
              child: SizedBox(
                height: AppDimension.baseConstraints.maxHeight,
                width: AppDimension.baseConstraints.maxWidth,
                child: ListView.builder(
                  itemCount: chapterDetail!.images.length,
                  itemBuilder: (context, index) {
                    return IntrinsicHeight(
                      child: Image.network(
                          '${Environment.apiUrl}/${chapterDetail!.images[index]}'),
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
    return SizedBox(
      height: heightHeadBott,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Helper.navigatorPop(context);
              },
              child: SizedBox(
                height: heightHeadBott,
                child: Transform.scale(
                  scale: 1,
                  child: BaseWidget.instance
                      .setIcon(iconData: Icons.navigate_before),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget bottomBar({required heightHeadBott}) {
    // TODO update current chapter
    int currentChapter = 1;
    int totalChapter = widget.chapterList.length - 1;
    double heightListChapter = heightHeadBott * 6;
    double heightItemChapter = heightListChapter * 0.12;

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
                padding: const EdgeInsets.all(AppDimension.dimension8),
                height: heightHeadBott,
                width: AppDimension.baseConstraints.maxWidth,
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
                                    // TODO
                                    // _chapterComicBook =
                                    //     widget.chapters[
                                    //         currentChapter - 1];
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Transform.scale(
                                      scale: 0.8,
                                      child: BaseWidget.instance
                                          .setIcon(iconData: Icons.arrow_back),
                                    ),
                                    Text(
                                      'Trước',
                                      style: TextStyle(
                                        color: Colors.white,
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
                              chapterDetail!.chapterName,
                              style: TextStyle(
                                color: Colors.white,
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
                                    // TODO
                                    // _chapterComicBook =
                                    //     widget.chapters[
                                    //         currentChapter + 1];
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Sau',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 0.8,
                                      child: BaseWidget.instance.setIcon(
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
                    left: AppDimension.baseConstraints.maxWidth / 2 -
                        (AppDimension.baseConstraints.maxWidth / 4),
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
                      width: AppDimension.baseConstraints.maxWidth / 2,
                      height: heightListChapter,
                      child: ListView.builder(
                        controller: _readingScroll,
                        itemCount: widget.chapterList.length,
                        itemBuilder: (cont, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                // TODO
                                // _chapterComicBook =
                                //     widget.chapters[index];
                              });
                              scrollToItem(index: currentChapter);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: (widget.chapterList[index].id ==
                                        chapterDetail!.id)
                                    ? Colors.orange
                                    : null,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(heightListChapter * 0.02)),
                                border: (widget.chapterList[index].id ==
                                        chapterDetail!.id)
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
                                  BaseWidget.instance.setText(
                                      txt: widget.chapterList[index].name,
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
