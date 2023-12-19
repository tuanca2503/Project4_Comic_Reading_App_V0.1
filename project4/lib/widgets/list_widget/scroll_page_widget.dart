import 'package:flutter/material.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/list_widget/util_list_widget.dart';

import '../../models/comic/comic_book.dart';

class ScrollPageWidget extends StatefulWidget {
  const ScrollPageWidget({Key? key, required this.comicBooks})
      : super(key: key);
  final List<ComicBook> comicBooks;

  @override
  State<ScrollPageWidget> createState() => _ScrollPageWidgetState();
}

class _ScrollPageWidgetState extends State<ScrollPageWidget> {
  final int _itemsPerPage = 7;
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (cont, cons) {
      double heightBottomPaging = cons.maxHeight * 0.08;
      double heightBodyPaging = cons.maxHeight - heightBottomPaging;

      return Container(
        padding: BaseWidget().setLefRightPadding(pLR: 10),
        width: cons.maxWidth,
        height: cons.maxHeight,
        child: Column(
          children: [
            // Content for the current page
            SizedBox(
                height: heightBodyPaging,
                child: Column(
                  children: [
                    for (ComicBook item
                        in _getCurrentPageItems(itemList: widget.comicBooks))
                      itemPageView(
                          context: context,
                          comicBook: item,
                          setBack: false,
                          setBackBlur: false),
                    if (_getCurrentPageItems(itemList: widget.comicBooks)
                            .length <
                        _itemsPerPage)
                      for (int i =
                              _getCurrentPageItems(itemList: widget.comicBooks)
                                  .length;
                          i < _itemsPerPage;
                          i++)
                        Expanded(child: Container()),
                  ],
                )

                // SizedBox(height: 20),,
                ),

            // Pagination controls

            SizedBox(
              width: cons.maxWidth,
              height: heightBottomPaging,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (_currentPage > 1) {
                            setState(() {
                              _currentPage--;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: BaseWidget().setText(
                        txt:
                            '$_currentPage/${(widget.comicBooks.length / _itemsPerPage).ceil()}',
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          int totalPages =
                              (widget.comicBooks.length / _itemsPerPage).ceil();
                          // In a real application, you would check if there are more pages
                          // before incrementing the currentPage.
                          if (_currentPage < totalPages) {
                            setState(() {
                              _currentPage++;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  List<ComicBook> _getCurrentPageItems({required List<ComicBook> itemList}) {
    int startIndex = (_currentPage - 1) * _itemsPerPage;
    int endIndex = _currentPage * _itemsPerPage;
    endIndex = endIndex > itemList.length ? itemList.length : endIndex;
    return itemList.sublist(startIndex, endIndex);
  }
}
