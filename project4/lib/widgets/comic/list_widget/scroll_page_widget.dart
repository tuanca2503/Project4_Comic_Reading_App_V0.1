import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project4/models/comic/page_comic_item.dart';
import 'package:project4/models/page_data.dart';
import 'package:project4/repositories/comic_repository.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/comic/list_widget/item_comic_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum QueryType {all, favourite, read}

class ScrollPageWidget extends StatefulWidget {
  const ScrollPageWidget({
    Key? key,
    this.children = const [],
    this.title,
    required this.filter,
    this.genresId,
    this.mangaName = '',
    this.itemComicType = ItemComicType.normal,
    this.queryType = QueryType.all,
  }) : super(key: key);
  final List<Widget> children;
  final Widget? title;
  final String filter;
  final List<String>? genresId;
  final String mangaName;
  final ItemComicType itemComicType;
  final QueryType queryType;

  @override
  State<ScrollPageWidget> createState() => _ScrollPageWidgetState();
}

class _ScrollPageWidgetState extends State<ScrollPageWidget>
    with AutomaticKeepAliveClientMixin<ScrollPageWidget> {
  int _page = 0;
  final int _pageSize = 10;
  final _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool? _hasNext;
  bool _isLoading = false;
  late StreamController<List<PageComicItem>> _dataStreamController;
  final List<String> _scrollComicIds = [];
  final List<PageComicItem> _scrollComics = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _dataStreamController = StreamController<List<PageComicItem>>.broadcast();
    fetchData();
  }

  Future<void> refresh() async {
    _page = 0;
    _scrollComicIds.clear();
    _scrollComics.clear();
    await fetchData();
    _refreshController.refreshCompleted();
  }

  Future<void> fetchData() async {
    try {
      _isLoading = true;
      PageData<PageComicItem> pageData;
      switch (widget.queryType) {
        case QueryType.all:
          pageData = await ComicRepository.instance
              .getAllComics(filter: widget.filter, page: _page, pageSize: _pageSize, genresIds: widget.genresId, mangaName: widget.mangaName);
        case QueryType.favourite:
        case QueryType.read:
          pageData = await ComicRepository.instance
              .getAllHistoryComics(page: _page, pageSize: _pageSize, action: QueryType.read.name.toUpperCase());
      }
      _page += 1;
      _hasNext = pageData.hasNext;
      _dataStreamController.add(pageData.data);
    } catch (e) {
      // Handle errors
      Helper.debug('Error fetching data: $e');
    } finally {
      _isLoading = false;
    }
  }

  void _scrollListener() {
    if (_hasNext == true &&
        !_isLoading &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      fetchData();
    }
  }

  void _scrollListenerWithSmartRefresh(ScrollNotification scrollController) {
    if (_hasNext == true &&
        !_isLoading &&
        scrollController.metrics.pixels ==
            scrollController.metrics.maxScrollExtent) {
      fetchData();
    }
  }

  void addNotDuplicateComics(List<PageComicItem> comics) {
    for (var c in comics) {
      if (!_scrollComicIds.contains(c.id)) {
        _scrollComicIds.add(c.id);
        _scrollComics.add(c);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        _scrollListenerWithSmartRefresh(scrollInfo);
        return true;
      },
      child: SmartRefresher(
        controller: _refreshController,
        onRefresh: refresh,
        enablePullDown: true,
        child: SingleChildScrollView(
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
                  return _scrollComics.isEmpty ? BaseWidget.instance.emptyWidget() : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    controller: ScrollController(),
                    itemCount: _scrollComics.length,
                    itemBuilder: (context, index) {
                      return ItemComicWidget(comic: _scrollComics[index], itemComicType: widget.itemComicType,);
                    },
                  );
                },
                streamController: _dataStreamController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
