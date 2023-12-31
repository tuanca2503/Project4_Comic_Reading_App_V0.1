import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project4/models/comment/page_comment_item.dart';
import 'package:project4/models/page_data.dart';
import 'package:project4/repositories/comment_repository.dart';
import 'package:project4/screens/comic/item_comment_widget.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum QueryType { all, favourite, read }

class ScrollPageCommentWidget extends StatefulWidget {
  ScrollPageCommentWidget({
    Key? key,
    required this.mangaId,
    required this.isNeedGetNewData,
  }) : super(key: key);
  final String mangaId;
  bool isNeedGetNewData;

  @override
  State<ScrollPageCommentWidget> createState() =>
      _ScrollPageCommentWidgetState();
}

class _ScrollPageCommentWidgetState extends State<ScrollPageCommentWidget>
    with AutomaticKeepAliveClientMixin<ScrollPageCommentWidget> {
  int _page = 0;
  final int _pageSize = 10;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool? _hasNext;
  bool _isLoading = false;
  late StreamController<List<PageCommentItem>> _dataStreamController;
  final List<String> _scrollCommentIds = [];
  final List<PageCommentItem> _scrollComments = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _dataStreamController = StreamController<List<PageCommentItem>>.broadcast();
    fetchData();
  }

  Future<void> refresh() async {
    _page = 0;
    _scrollCommentIds.clear();
    _scrollComments.clear();
    await fetchData();
    _refreshController.refreshCompleted();
  }

  Future<void> fetchData() async {
    try {
      _isLoading = true;
      PageData<PageCommentItem> pageData;
      pageData = await CommentRepository.instance.getAllComment(
          mangaId: widget.mangaId, pageSize: _pageSize, page: _page);

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

  void _scrollListenerWithSmartRefresh(ScrollNotification scrollController) {
    if (_hasNext == true &&
        !_isLoading &&
        scrollController.metrics.pixels ==
            scrollController.metrics.maxScrollExtent) {
      fetchData();
    }
  }

  void addNotDuplicateComments(List<PageCommentItem> comments) {
    if (widget.isNeedGetNewData) {
      widget.isNeedGetNewData = false;
      refresh();
      return;
    }
    for (var c in comments) {
      if (!_scrollCommentIds.contains(c.id)) {
        _scrollCommentIds.add(c.id);
        _scrollComments.add(c);
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
          child: BaseWidget.instance.setStreamBuilder(
            callback: (snapshot) {
              final List<PageCommentItem> data = snapshot.data!;
              addNotDuplicateComments(data);
              return _scrollComments.isEmpty
                  ? BaseWidget.instance.emptyWidget()
                  : Column(
                      children: [
                        for (int i = 0; i < _scrollComments.length; i++)
                          ItemCommentWidget(
                            comment: _scrollComments[i],
                          )
                      ],
                    );
              // ERROR: has padding top
              /*: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      controller: ScrollController(),
                      itemCount: _scrollComments.length,
                      itemBuilder: (context, index) {
                        return ItemCommentWidget(
                          comment: _scrollComments[index],
                        );
                      },
                    );*/
            },
            streamController: _dataStreamController,
          ),
        ),
      ),
    );
  }
}
