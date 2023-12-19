import 'package:flutter/material.dart';
import 'package:project4/models/comic/comic_book.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/list_widget/util_list_widget.dart';

class ScrollHorizontalWidget extends StatefulWidget {
  const ScrollHorizontalWidget({Key? key, required this.comicBooks}) : super(key: key);
  final List<ComicBook> comicBooks;
  @override
  State<ScrollHorizontalWidget> createState() => _ScrollHorizontalWidgetState();
}

class _ScrollHorizontalWidgetState extends State<ScrollHorizontalWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.comicBooks.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemListView(
              constraints: constraints, comicBook: widget.comicBooks[index]);
        },
      );
      //////////////////////////////////
      ///
    });
  }

  Widget _itemListView(
      {required BoxConstraints constraints, required ComicBook comicBook}) {
    return Container(
      padding: BaseWidget().setLefRightPadding(pLR: 10),
      width: constraints.maxWidth / 2 - 10,
      height: constraints.maxHeight,
      child: Column(
        children: [
          Expanded(
            flex: 11,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.cover,
                child: myEventHandler(context: context,
                    child: BaseWidget()
                        .setImageNetwork(link: comicBook.coverImage),
                    comicBook: comicBook),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: BaseWidget().setText(
                  txt: "${comicBook.title} ",
                  fontSize: 18,
                  fontWeight: FontWeight.w100),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (Genre value in comicBook.genres)
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Container(
                          // height: constraints.maxHeight / 2 - 5,
                          padding: const EdgeInsets.all(3),
                          child: Align(
                            alignment: Alignment.center,
                            child: BaseWidget().setText(
                                color: const Color(0xffD8d8d8),
                                txt: value.genresName,
                                fontSize: 6,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
