import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project4/config.dart';
import 'package:project4/models/comic_book.dart';
import 'package:project4/repositories/base_repository.dart';
import 'package:project4/screens/details_comic_screen.dart';
import 'package:project4/widgets/base_widget.dart';

class CustomSlideWidget extends StatefulWidget {
  final List<ComicBook> comicBooks;

  final BoxConstraints baseConstraints;
  final BaseRepository baseRepository;

  const CustomSlideWidget(
      {required this.comicBooks,
      required this.baseConstraints,
      required this.baseRepository});

  @override
  _CustomSlideWidgetState createState() => _CustomSlideWidgetState();
}

class _CustomSlideWidgetState extends State<CustomSlideWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.comicBooks.map(
        (comicBook) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double widthBox = constraints.maxWidth * 0.7;
                double center = constraints.maxWidth / 2 - (widthBox / 2);

                return Stack(
                  children: [
                    Image.network(
                      "${AppConfig.apiIP}${AppConfig.apiPort}${comicBook.coverImage}",
                      fit: BoxFit.cover,
                      width: constraints.maxWidth,
                      height: constraints.maxWidth * 2,
                    ),
                    Positioned(
                      bottom: 20,
                      left: center,
                      child: SizedBox(
                        width: widthBox,
                        height: 40,
                        child: Row(
                          children: [
                            itemButtonSlide(
                                color: const Color(0xffD0480A),
                                txt: "Đọc",
                                link: "books_white.png",
                                comicBook: comicBook,
                                showButton: 0),
                            Expanded(flex: 1, child: Container()),
                            itemButtonSlide(
                                color: const Color(0xff232220),
                                txt: "Chi tiết",
                                link: "info_white.png",
                                comicBook: comicBook,
                                showButton: 1),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        autoPlay: true, // Enable auto-play
        enlargeCenterPage: true, // Make the current image larger
        aspectRatio: 16 / 9, // Set the aspect ratio
        viewportFraction: 0.8, // Set the fraction of the viewport to show
        // initialPage: 4,   //// anh bat dau
        autoPlayInterval: Duration(seconds: 5),

        height: widget.baseConstraints.maxWidth *
            1.2, // Set the height of the carousel
      ),
    );
  }

//DetailsComicScreen(comicBook: comicBook)
  Widget itemButtonSlide(
      {required Color color,
      required String txt,
      required String link,
      required ComicBook comicBook,
      required int showButton}) {
    return Expanded(
      flex: 5,
      child: BaseWidget().handleEventNavigation(
        context: context,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: color,
          ),
          height: double.infinity,
          padding: BaseWidget().setLefRightPadding(pLR: 15),
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: BaseWidget().setText(
                  txt: txt,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: BaseWidget().setImageAsset(link),
                ),
              ),
            ],
          ),
        ),
        pageTo: DetailsComicScreen(
            baseRepository: widget.baseRepository,
            showButton: showButton,
            baseConstraints: widget.baseConstraints,
            comicBook: comicBook),
      ),
    );
  }
}
