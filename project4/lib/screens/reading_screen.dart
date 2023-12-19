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
      required this.chapterComicBook});

  final ChapterComicBook chapterComicBook;

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
  }

  double? fontSize;
  double? fontFour;
  double? fontBac;
  double? fontBack;
  double? create;

  bool showBars = true;

////////////////////////////////////////
////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      setBody: BaseWidget().setFutureBuilder(
        callback: (snapshot) {
          return bodyReadingScreen(chapterComicBook: snapshot.data);
        },
        repo: GetIt.instance<ChapterRepository>().getChapterComic(chapter: widget.chapterComicBook),
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
                // context.read<VisibilityProvider>().toggleVisibility();
                // setState(() {
                //   showBars = !showBars;
                // });
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
                        chapterName: chapterComicBook.name),
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
  Widget headerBar({required heightHeadBott, required String chapterName}) {
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
                      scale: 0.5,
                      child: BaseWidget().setIcon(iconData: Icons.navigate_before),
                    ),
                  ),
                  context: context)),
          Expanded(
            flex: 8,
            child: Text(
              chapterName,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontFour,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
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
    return Container(
      color: BaseWidget().setColorBlack(),
      height: heightHeadBott,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: heightHeadBott,
              child: Transform.scale(
                scale: 0.5,
                child: BaseWidget().setIcon(iconData: Icons.arrow_back),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Text(
              'Trước',
              style: TextStyle(
                color: Colors.white,
                fontSize: fontFour,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
