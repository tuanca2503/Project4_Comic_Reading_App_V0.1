import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project4/models/comic/page_comic_item.dart';
import 'package:project4/repositories/comic_repository.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/list_widget/item_comic_widget.dart';

import '../../models/page_data.dart';
import '../../utils/app_dimension.dart';

enum QueryType {all, favourite}

class ScrollPageWidget extends StatefulWidget {
  const ScrollPageWidget({
    Key? key,
    this.children = const [],
    this.title,
    required this.filter,
    this.genresId,
    this.mangaName = '',
    this.queryType = QueryType.all,
  }) : super(key: key);
  final List<Widget> children;
  final Widget? title;
  final String filter;
  final List<String>? genresId;
  final String mangaName;
  final QueryType queryType;

  @override
  State<ScrollPageWidget> createState() => _ScrollPageWidgetState();
}

class _ScrollPageWidgetState extends State<ScrollPageWidget>
    with AutomaticKeepAliveClientMixin<ScrollPageWidget> {
  int page = 0;
  final int pageSize = 10;
  final scrollController = ScrollController();
  bool? hasNext;
  bool isLoading = false;
  late StreamController<List<PageComicItem>> _dataStreamController;
  final List<String> scrollComicIds = [];
  final List<PageComicItem> scrollComics = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    _dataStreamController = StreamController<List<PageComicItem>>.broadcast();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading = true;
      PageData<PageComicItem> pageData;
      switch (widget.queryType) {
        case QueryType.all:
          pageData = await ComicRepository.instance
              .getAllComics(filter: widget.filter, page: page, pageSize: pageSize, genresIds: widget.genresId, mangaName: widget.mangaName);
        case QueryType.favourite:
          pageData = await ComicRepository.instance
              .getAllFavouriteComics(page: page, pageSize: pageSize);
      }
      isLoading = false;
      page += 1;
      hasNext = pageData.hasNext;
      _dataStreamController.add(pageData.data);
    } catch (e) {
      // Handle errors
      Helper.debug('Error fetching data: $e');
    }
  }

  void _scrollListener() {
    if (hasNext == true &&
        !isLoading &&
        scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
      fetchData();
    }
  }

  void addNotDuplicateComics(List<PageComicItem> comics) {
    for (var c in comics) {
      if (!scrollComicIds.contains(c.id)) {
        scrollComicIds.add(c.id);
        scrollComics.add(c);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: AppDimension.initPaddingBody(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...widget.children,
          SizedBox(
            height: widget.children.isNotEmpty
                ? AppDimension.baseConstraints.maxHeight * 0.01
                : 0,
          ),
          widget.title != null ? widget.title! : Container(),
          BaseWidget.instance.setStreamBuilder(
            callback: (snapshot) {
              final List<PageComicItem> data = snapshot.data!;
              addNotDuplicateComics(data);
              return scrollComics.isEmpty ? BaseWidget.instance.emptyWidget() : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                controller: ScrollController(),
                itemCount: scrollComics.length,
                itemBuilder: (context, index) {
                  return ItemComicWidget(comic: scrollComics[index]);
                },
              );
            },
            streamController: _dataStreamController,
          ),
        ],
      ),
    );
  }
}
