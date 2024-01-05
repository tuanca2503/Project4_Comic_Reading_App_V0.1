import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/models/comic/chapter/chapter_detail.dart';
import 'package:project4/models/comic/chapter/page_chapter_item.dart';
import 'package:project4/repositories/chapter_repository.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/widgets/app/custom_app_bar.dart';
import 'package:project4/widgets/base_widget.dart';

enum NavigateChapterAction { prev, next }

class ReadingScreen extends StatefulWidget {
  const ReadingScreen(
      {super.key,
      this.chapterIndex,
      this.chapterList,
      this.comicId,
      this.chapterId});
  /* Guide: Use chapterList && chapterIndex (from DetailScreen)
  or comicId && chapterId (from ComicBottomSheet). If chapterId = null => set chapterIndex = 0
  * */
  final String? comicId;
  final String? chapterId;

  final int? chapterIndex;
  final List<PageChapterItem>? chapterList;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen>
    with AutomaticKeepAliveClientMixin<ReadingScreen> {
  @override
  bool get wantKeepAlive => true;

  final _listViewKey = GlobalKey<ScaffoldState>();
  late int _currentChapterIndex;
  final List<DropdownMenuItem> _chapterListMenu = [];
  ChapterDetail? _chapterDetail;
  bool _isShowBar = true;
  late List<PageChapterItem> chapterList;

  @override
  void initState() {
    super.initState();

    if (widget.comicId == null &&
        !(widget.chapterIndex != null && widget.chapterList != null)) {
      throw Exception(
          "Cannot get chapter information, check `Guide` in `ReadingScreen`");
    }

    if (widget.chapterList != null) {
      chapterList = widget.chapterList!;

      _createDropdownChapterList();
      _onSelectChapter(widget.chapterIndex!);
    } else {
      ChapterRepository.instance
          .getChapterListByComicId(comicId: widget.comicId!)
          .then((value) {
        chapterList = value;

        if (widget.chapterId != null) {
          _currentChapterIndex =
              _createDropdownChapterList(chapterId: widget.chapterId)!;
        } else {
          _createDropdownChapterList();
          _currentChapterIndex = 0;
        }
        _onSelectChapter(_currentChapterIndex);
      });
    }
  }

  int? _createDropdownChapterList({String? chapterId}) {
    int? chapterIndex;
    for (int i = 0; i < chapterList.length; i++) {
      PageChapterItem chapter = chapterList[i];
      if (chapterId != null && chapterId == chapter.id) {
        chapterIndex = i;
      }
      _chapterListMenu.add(DropdownMenuItem(
        value: i,
        child: Text(
          chapter.name,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ));
    }
    return chapterIndex;
  }

  void _onSelectChapter(int chapterIndex) {
    _currentChapterIndex = chapterIndex;
    ChapterRepository.instance
        .getChapterComic(id: chapterList[_currentChapterIndex].id)
        .then((value) {
      setState(() {
        _chapterDetail = value;
      });
    });
  }

  void _navigateChapter(NavigateChapterAction action) {
    switch (action) {
      case NavigateChapterAction.prev:
        if (_currentChapterIndex > 0) {
          _currentChapterIndex -= 1;
          _onSelectChapter(_currentChapterIndex);
        }
      case NavigateChapterAction.next:
        if (_currentChapterIndex < chapterList.length) {
          _currentChapterIndex += 1;
          _onSelectChapter(_currentChapterIndex);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _chapterDetail == null
          ? BaseWidget.instance.loadingWidget()
          : _bodyReadingScreen(),
    );
  }

  Widget _bodyReadingScreen() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isShowBar = !_isShowBar;
        });
      },
      child: Stack(
        children: [
          _chapterImagesWidget(),
          !_isShowBar
              ? Container()
              : CustomAppBar(
                  selectedAppBar: AppBarEnum.back,
                  color: AppColor.onOverlay,
                  bgColor: AppColor.overlay,
                ),
          !_isShowBar ? Container() : _bottomBar()
        ],
      ),
    );
  }

  Widget _chapterImagesWidget() {
    return Positioned.fill(
      child: SizedBox(
        height: AppDimension.baseConstraints.maxHeight,
        width: AppDimension.baseConstraints.maxWidth,
        child: ListView.builder(
          key: _listViewKey,
          itemCount: _chapterDetail!.images.length,
          itemBuilder: (context, index) {
            return BaseWidget.instance
                .setImageNetwork(link: _chapterDetail!.images[index]);
          },
        ),
      ),
    );
  }

  Widget _bottomBar() {
    int maxTotalChap = chapterList.length - 1;
    int minTotalChap = chapterList.length - chapterList.length;
    return !_isShowBar
        ? Container()
        : Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColor.overlay,
              height: AppDimension.baseConstraints.maxHeight * 0.08,
              child: Container(
                padding: const EdgeInsets.all(AppDimension.dimension8),
                width: AppDimension.baseConstraints.maxWidth,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: (_currentChapterIndex > minTotalChap)
                            ? _navigateChapterWidget(NavigateChapterAction.prev)
                            : Container(),
                      ),
                    ),
                    Expanded(
                        flex: 6,
                        child: Container(
                          child: _dropdownChapterListWidget(),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                        )),
                    Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: (_currentChapterIndex < maxTotalChap)
                              ? _navigateChapterWidget(
                                  NavigateChapterAction.next)
                              : Container(),
                        )),
                  ],
                ),
              ),
            ),
          );
  }

  Widget _navigateChapterWidget(NavigateChapterAction action) {
    return GestureDetector(
      onTap: () {
        _navigateChapter(action);
      },
      child: Row(
        mainAxisAlignment: (action == NavigateChapterAction.prev)
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          BaseWidget.instance.setIcon(
            iconData: action == NavigateChapterAction.prev
                ? Icons.arrow_back
                : Icons.arrow_forward,
            color: AppColor.onOverlay,
          ),
          Text(
            action == NavigateChapterAction.prev ? ' Trước' : ' Sau',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.onOverlay,
            ),
          )
        ],
      ),
    );
  }

  Widget _dropdownChapterListWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimension.dimension16,
          vertical: AppDimension.dimension8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.onOverlay),
        borderRadius: BorderRadius.circular(AppDimension.dimension8),
      ),
      child: DropdownButton(
        isExpanded: true,
        value: _currentChapterIndex,
        items: _chapterListMenu,
        onChanged: (chapterIndex) {
          setState(() {
            _onSelectChapter(chapterIndex);
          });
        },
        style: TextStyle(
          color: AppColor.onOverlay,
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.centerLeft,
        icon: Icon(
          Icons.arrow_drop_down_circle,
          color: AppColor.onOverlay,
        ),
        underline: const SizedBox(),
        dropdownColor: AppColor.overlay,
        menuMaxHeight: AppDimension.baseConstraints.maxHeight * 0.5,
      ),
    );
  }
}
