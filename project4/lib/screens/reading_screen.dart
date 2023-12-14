import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project4/config.dart';
import 'package:project4/main.dart';
import 'package:project4/models/comic_book.dart';
import 'package:project4/repositories/base_repository.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:provider/provider.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen(
      {super.key,
      required this.baseConstraints,
      required this.baseRepository,
      required this.chapterComicBook});
  final BoxConstraints baseConstraints;
  final BaseRepository baseRepository;
  final ChapterComicBook chapterComicBook;

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  @override
  void initState() {
    double screenWidth = widget.baseConstraints.maxWidth;
    double screenHeight = widget.baseConstraints.maxHeight;
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
      baseConstraints: widget.baseConstraints,
      setBody: BaseWidget().setFutureBuilder(
        callback: (snapshot) {
          return bodyReadingScreen(chapterComicBook: snapshot.data!.data);
        },
        repo: widget.baseRepository.comicsRepository
            .getChapterComic(chapter: widget.chapterComicBook),
      ),
    );
  }

  Widget bodyReadingScreen({required ChapterComicBook chapterComicBook}) {
    double heightHeadBott = widget.baseConstraints.maxHeight * 0.08;
    // print(chapterComicBook.images.length);
    // final visibilityProvider = context.read<VisibilityProvider>();

    return Consumer<VisibilityProvider>(
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
            child: Container(
              height: widget.baseConstraints.maxHeight,
              width: widget.baseConstraints.maxWidth,
              child: ListView.builder(
                itemCount: chapterComicBook.images.length,
                itemBuilder: (context, index) {
                  return IntrinsicHeight(
                    child: Image.network(
                        '${AppConfig.apiIP}${AppConfig.apiPort}${chapterComicBook.images[index]}'),
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
    });
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
                  child: Container(
                    height: heightHeadBott,
                    child: Transform.scale(
                      scale: 0.5,
                      child: BaseWidget().setImageAsset('back_white.png'),
                    ),
                  ),
                  context: context)),
          Expanded(
            flex: 8,
            child: Container(
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
            child: Container(
              height: heightHeadBott,
              child: Transform.scale(
                scale: 0.5,
                child: BaseWidget().setImageAsset('left_arrow.png'),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              child: Text(
                'Trước',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontFour,
                  fontWeight: FontWeight.bold,
                ),
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
