import 'package:flutter/material.dart';
import 'package:project4/models/comic_book.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/custom_slide_widget.dart';
import 'package:project4/widgets/list_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.baseConstraints});
  final BoxConstraints baseConstraints;
  List<ComicBook> comicBooks = ComicBook().Seed();

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        baseConstraints: baseConstraints,
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
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: CustomSlideWidget(
                  comicBooks: comicBooks,
                  baseConstraints: baseConstraints,
                ),
              ),

              //end slide
              //list
              Container(
                padding: EdgeInsets.all(thisPadding),
                alignment: Alignment.centerLeft,
                child: BaseWidget().setText(txt: "Mới cập nhật", fontSize: 15),
              ),
              Container(
                height: 300,
                child: ListWidget(
                  baseConstraints: baseConstraints,
                  setList: 0,
                  comicBooks: comicBooks,
                ),
              ),
              //end list
              //list
              Container(
                padding: EdgeInsets.all(thisPadding),
                alignment: Alignment.centerLeft,
                child: BaseWidget().setText(txt: "Được ưa thích", fontSize: 15),
              ),
              Container(
                height: 300,
                child: ListWidget(
                  baseConstraints: baseConstraints,
                  setList: 1,
                  comicBooks: comicBooks,
                ),
              ),
              //
              // Container(
              //   padding: EdgeInsets.all(thisPadding),
              //   alignment: Alignment.centerLeft,
              //   child: BaseWidget().setText(txt: "Được ưa thích", fontSize: 15),
              // ),
              // Container(
              //   height: 500,
              //   child: ListWidget(
              //     baseConstraints: baseConstraints,
              //     setList: 2,
              //     comicBooks: comicBooks,
              //   ),
              // ),
              //
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
