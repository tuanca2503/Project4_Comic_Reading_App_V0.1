import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/models/comic/comic_book.dart';
import 'package:project4/models/page_data.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/utils/util_func.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/custom_slide_widget.dart';
import 'package:project4/widgets/list_widget/scroll_horizontal_widget.dart';
import 'package:project4/widgets/list_widget/scroll_page_widget.dart';

import '../repositories/comics_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double thisPadding = 10;
  int page = 0;
  final int pageSize = 1;
  final scrollController = ScrollController();
  bool? hasNext;
  bool isLoading = false;
  late StreamController<List<ComicBook>> _dataStreamController;
  final List<String> scrollComicBookIds = [];
  final List<ComicBook> scrollComicBooks = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
    _dataStreamController = StreamController<List<ComicBook>>.broadcast();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading = true;
      PageData<ComicBook> pageData = await GetIt.instance<ComicsRepository>()
          .getAllComics(
              filter: 'LAST_UPDATED_DATE', page: page, pageSize: pageSize);
      isLoading = false;
      page += 1;
      hasNext = pageData.hasNext;
      _dataStreamController.add(pageData.data);
    } catch (e) {
      // Handle errors
      debug('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        setAppBar: 1,
        setBottomBar: true,
        chooseBottomIcon: 1,
        setMoveUp: true,
        setBody: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              /*BaseWidget().setFutureBuilder(
            callback: (snapshot) {
              return Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: CustomSlideWidget(
                      comicBooks: (snapshot.data as ComicHome).topLikeMangas,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(thisPadding),
                    alignment: Alignment.centerLeft,
                    child: BaseWidget().setText(txt: "Bảng xếp hạng", fontSize: 15),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListWidget(
                      setList: 0,
                      comicBooks: (snapshot.data as ComicHome).topViewMangas,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(thisPadding),
                    alignment: Alignment.centerLeft,
                    child: BaseWidget().setText(txt: "Được ưa thích", fontSize: 15),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListWidget(
                      setList: 1,
                      comicBooks: (snapshot.data as ComicHome).topFavouriteMangas,
                    ),
                  )
                ],
              );
            },
            repo: GetIt.instance<ComicsRepository>().getAllComicsForHome(),
          ),*/
              // Old home page Slide + top view + top like
              Container(
                padding: EdgeInsets.all(thisPadding),
                alignment: Alignment.centerLeft,
                child: BaseWidget().setText(
                    txt: "" "Mới cập nhật",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              BaseWidget().setFutureBuilder(
                callback: (snapshot) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: CustomSlideWidget(
                      comicBooks: snapshot.data!.data,
                    ),
                  );
                },
                repo: GetIt.instance<ComicsRepository>().getAllComics(),
              ),

              //end slide
              //list
              Container(
                padding: EdgeInsets.all(thisPadding),
                alignment: Alignment.centerLeft,
                child: BaseWidget().setText(txt: "Bảng xếp hạng", fontSize: 15),
              ),
              BaseWidget().setFutureBuilder(
                callback: (snapshot) {
                  return ScrollPageWidget(
                    comicBooks: snapshot.data!.data,
                    isScrollInfinitive: false,
                  );
                },
                repo: GetIt.instance<ComicsRepository>()
                    .getAllComics(filter: 'TOP_ALL'),
              ),
              Container(
                padding: EdgeInsets.all(thisPadding),
                alignment: Alignment.centerLeft,
                child: BaseWidget().setText(txt: "Được ưa thích", fontSize: 15),
              ),
              BaseWidget().setFutureBuilder(
                callback: (snapshot) {
                  return SizedBox(
                    height: 300,
                    child: ScrollHorizontalWidget(
                      comicBooks: snapshot.data!.data,
                    ),
                  );
                },
                repo: GetIt.instance<ComicsRepository>()
                    .getAllComics(filter: 'TOP_FAVOURITE'),
              ),

              ////////////////////////////////// Scroll page view
              Container(
                padding: EdgeInsets.all(thisPadding),
                alignment: Alignment.centerLeft,
                child: BaseWidget()
                    .setText(txt: "Truyện mới cập nhật", fontSize: 15),
              ),
              BaseWidget().setStreamBuilder(
                callback: (snapshot) {
                  final List<ComicBook> data = snapshot.data!;
                  addNotDuplicateComicBooks(data);
                  return ScrollPageWidget(
                    comicBooks: scrollComicBooks,
                    isScrollInfinitive: true,
                  );
                },
                streamController: _dataStreamController,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          //
        ));
  }

  void _scrollListener() {
    if (hasNext == true &&
        !isLoading &&
        scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
      fetchData();
    } else if (hasNext == false) {
      debug('last page');
    }
  }

  void addNotDuplicateComicBooks(List<ComicBook> comics) {
    for (var c in comics) {
      if (!scrollComicBookIds.contains(c.id)) {
        scrollComicBookIds.add(c.id);
        scrollComicBooks.add(c);
      }
    }
  }
}
