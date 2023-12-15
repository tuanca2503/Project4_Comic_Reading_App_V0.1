import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project4/models/comic_book.dart';
import 'package:project4/models/handle_response_api.dart';
import 'package:project4/repositories/base_repository.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/custom_slide_widget.dart';
import 'package:project4/widgets/list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.baseConstraints, required this.baseRepository});
  final BoxConstraints baseConstraints;
  final BaseRepository baseRepository;

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
        baseConstraints: widget.baseConstraints,
        setAppBar: 1,
        setBottomBar: true,
        chooseBottomicon: 1,
        setBody: bodyHomeScreen());
  }

  Widget bodyHomeScreen() {
    double thisPadding = 10;

    return SizedBox(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(thisPadding),
                alignment: Alignment.centerLeft,
                child: BaseWidget().setText(
                    txt: "" /*"Mới cập nhật"*/,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              BaseWidget().setFutureBuilder(
                callback: (snapshot) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: CustomSlideWidget(
                      baseRepository: widget.baseRepository,
                      comicBooks: snapshot.data!.data,
                      baseConstraints: widget.baseConstraints,
                    ),
                  );
                },
                repo: widget.baseRepository.comicsRepository.getAllComics(),
              ),

              //end slide
              //list
              Container(
                padding: EdgeInsets.all(thisPadding),
                alignment: Alignment.centerLeft,
                child: BaseWidget().setText(txt: "Mới cập nhật", fontSize: 15),
              ),
              BaseWidget().setFutureBuilder(
                callback: (snapshot) {
                  return Container(
                    height: 300,
                    child: ListWidget(
                      baseRepository: widget.baseRepository,
                      setList: 0,
                      comicBooks: snapshot.data!.data,
                      baseConstraints: widget.baseConstraints,
                    ),
                  );
                },
                repo: widget.baseRepository.comicsRepository
                    .getAllComics(filter: 'LAST_UPDATED_DATE'),
              ),
              // Container(
              //   height: 300,
              //   child: ListWidget(
              //     baseConstraints: widget.baseConstraints,
              //     setList: 0,
              //     comicBooks: ComicBook().Seed(),
              //   ),
              // ),
              //end list
              //list
              Container(
                padding: EdgeInsets.all(thisPadding),
                alignment: Alignment.centerLeft,
                child: BaseWidget().setText(txt: "Được ưa thích", fontSize: 15),
              ),
              BaseWidget().setFutureBuilder(
                callback: (snapshot) {
                  return Container(
                    height: 300,
                    child: ListWidget(
                      baseRepository: widget.baseRepository,
                      setList: 1,
                      comicBooks: snapshot.data!.data,
                      baseConstraints: widget.baseConstraints,
                    ),
                  );
                },
                repo: widget.baseRepository.comicsRepository
                    .getAllComics(filter: 'TOP_FAVOURITE'),
              ),

              //////////////////////////////////
              Container(
                padding: EdgeInsets.all(thisPadding),
                alignment: Alignment.centerLeft,
                child: BaseWidget().setText(txt: "Xem thêm", fontSize: 15),
              ),
              BaseWidget().setFutureBuilder(
                callback: (snapshot) {
                  return Container(
                    height: 500,
                    child: ListWidget(
                      baseRepository: widget.baseRepository,
                      setList: 2,
                      comicBooks: snapshot.data!.data,
                      baseConstraints: widget.baseConstraints,
                    ),
                  );
                },
                repo: widget.baseRepository.comicsRepository
                    .getAllComics(filter: 'TOP_LIKE'),
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
