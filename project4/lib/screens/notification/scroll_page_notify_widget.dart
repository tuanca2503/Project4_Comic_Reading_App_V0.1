import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project4/models/comic/page_comic_item.dart';
import 'package:project4/models/page_data.dart';
import 'package:project4/repositories/comic_repository.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/comic/list_widget/item_comic_widget.dart';

class ScrollPageNotifyWidget extends StatefulWidget {
  const ScrollPageNotifyWidget({
    Key? key,
    this.title,
  }) : super(key: key);
  final Widget? title;

  @override
  State<ScrollPageNotifyWidget> createState() => _ScrollPageNotifyWidgetState();
}

class _ScrollPageNotifyWidgetState extends State<ScrollPageNotifyWidget>
    with AutomaticKeepAliveClientMixin<ScrollPageNotifyWidget> {
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
        case QueryType.read:
          pageData = await ComicRepository.instance
              .getAllHistoryComics(page: page, pageSize: pageSize, action: QueryType.read.name.toUpperCase());
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
        // crossAxisAlignment: CrossAxisAlignment.start,
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
                  return ItemComicWidget(comic: scrollComics[index], itemComicType: widget.itemComicType,);
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
