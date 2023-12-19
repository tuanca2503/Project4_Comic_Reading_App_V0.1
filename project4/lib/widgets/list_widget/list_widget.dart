
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/models/comic/comic_book.dart';
import 'package:project4/utils/constants.dart';
import 'package:project4/widgets/list_widget/util_list_widget.dart';

import '../../repositories/comics_repository.dart';
import '../../repositories/interact_comic_repository.dart';
import '../../utils/util_func.dart';

class ListWidget extends StatefulWidget {
  ListWidget({super.key, required this.comicBooks});

  final List<ComicBook> comicBooks;
  final bool isLogin =
      checkStringIsNotEmpty(sharedPreferences.getString('email'));

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.95);
  final comicsRepository = GetIt.instance<ComicsRepository>();
  final interactComicRepository = GetIt.instance<InteractComicRepository>();
  

  @override
  Widget build(BuildContext context) {
    return _myPageView(myList: widget.comicBooks);
  }

  Widget _myPageView({required List myList, int limit = 10}) {
    List<List<dynamic>> chunks = [];
    for (var i = 0;
        i < ((limit > myList.length) ? myList.length : limit);
        i += 3) {
      chunks.add(
          myList.sublist(i, i + 3 > myList.length ? myList.length : i + 3));
    }
    return PageView.builder(
      controller: _pageController,
      itemCount: chunks.length,
      itemBuilder: (context, index) {
        // final comicBook = comicBooks[index];
        return Container(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
            children: [
              for (var comicBook in chunks[index])
                itemPageView(context: context, comicBook: comicBook),
              if (chunks[index].length < 3)
                for (int i = chunks[index].length; i < 3; i++)
                  Expanded(child: Container()),
            ],
          ),
        );
      },
    );
  }

}
