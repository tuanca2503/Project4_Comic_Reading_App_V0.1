
import 'package:flutter/material.dart';
import 'package:project4/widgets/list_widget/util_list_widget.dart';

import '../../models/comic/comic_book.dart';

class ScrollPageWidget extends StatefulWidget {
  const ScrollPageWidget({Key? key, required this.comicBooks, required this.isScrollInfinitive})
      : super(key: key);
  final List<ComicBook> comicBooks;
  final bool isScrollInfinitive;

  @override
  State<ScrollPageWidget> createState() => _ScrollPageWidgetState();
}

class _ScrollPageWidgetState extends State<ScrollPageWidget> {
  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isScrollInfinitive) {
      scrollController.addListener(_scrollListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (cont, cons) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        controller: scrollController,
        itemCount: widget.comicBooks.length,
        itemBuilder: (context, index) {
          return itemPageView(
            context: context,
            comicBook: widget.comicBooks[index],
            setBack: false,
            setBackBlur: false,
          );
        },
      );
    });
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      print('12222222scroll');
    }
  }
}
