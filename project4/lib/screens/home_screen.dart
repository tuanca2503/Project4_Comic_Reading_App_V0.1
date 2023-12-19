import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/custom_slide_widget.dart';
import 'package:project4/widgets/list_widget/list_widget.dart';
import 'package:project4/widgets/list_widget/scroll_horizontal_widget.dart';
import 'package:project4/widgets/list_widget/scroll_page_widget.dart';

import '../repositories/comics_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        setAppBar: 1,
        setBottomBar: true,
        chooseBottomIcon: 1,
        setMoveUp: true,
        setBody: bodyHomeScreen());
  }

  Widget bodyHomeScreen() {
    double thisPadding = 10;

    return SizedBox(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
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
                  return SizedBox(
                    height: 300,
                    child: ListWidget(
                      comicBooks: snapshot.data!.data,
                    ),
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
              BaseWidget().setFutureBuilder(
                callback: (snapshot) {
                  return SizedBox(
                    height: 800,
                    child: ScrollPageWidget(
                      comicBooks: snapshot.data!.data,
                    ),
                  );
                },
                repo: GetIt.instance<ComicsRepository>()
                    .getAllComics(filter: 'LAST_UPDATED_DATE'),
              ),

              Container(
                height: 100,
                padding: EdgeInsets.all(thisPadding),
                alignment: Alignment.bottomCenter,
                // child: BaseWidget().setText(txt: "move up"),
              ),
            ],
          );
        },
      ),
      //
    );
  }
}
