import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project4/main.dart';
import 'package:project4/models/notification/notification_page_item.dart';
import 'package:project4/models/page_data.dart';
import 'package:project4/repositories/notification_repository.dart';
import 'package:project4/screens/notification/item_notification_widget.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ScrollPageNotifyWidget extends StatefulWidget {
  const ScrollPageNotifyWidget({
    Key? key,
    this.title,
    required this.hasRead,
    this.updateNotificationState,
  }) : super(key: key);
  final Widget? title;
  final bool hasRead; // true -> all, false -> only unread
  final void Function(String?)? updateNotificationState;

  @override
  State<ScrollPageNotifyWidget> createState() => _ScrollPageNotifyWidgetState();
}

class _ScrollPageNotifyWidgetState extends State<ScrollPageNotifyWidget> {
  int _page = 0;
  final int _pageSize = 10;
  final _scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool? _hasNext;
  bool _isLoading = false;
  late StreamController<List<NotificationPageItem>> _dataStreamController;
  final List<String> _scrollNotificationIds = [];
  final List<NotificationPageItem> _scrollNotifications = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _dataStreamController =
        StreamController<List<NotificationPageItem>>.broadcast();
    fetchData();
  }

  Future<void> refresh() async {
    _page = 0;
    _scrollNotificationIds.clear();
    _scrollNotifications.clear();
    await fetchData();
    _refreshController.refreshCompleted();
  }

  Future<void> fetchData() async {
    try {
      _isLoading = true;
      PageData<NotificationPageItem> pageData =
          await NotificationRepository.instance.getAllNotification(
              page: _page, pageSize: _pageSize, hasRead: widget.hasRead);

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

  void addNotDuplicateNotifications(List<NotificationPageItem> notifications) {
    for (var c in notifications) {
      if (!_scrollNotificationIds.contains(c.id)) {
        _scrollNotificationIds.add(c.id);
        _scrollNotifications.add(c);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenProvider>(builder: (context, provider, child) {
      if (provider.notificationPageItem != null) {
        _scrollNotifications.insert(0, provider.notificationPageItem!);
        _scrollNotificationIds.insert(0, provider.notificationPageItem!.id);
        // has `addNotDuplicateNotifications` -> cannot update page
      }
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
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.title != null ? widget.title! : Container(),
                  BaseWidget.instance.setStreamBuilder(
                    callback: (snapshot) {
                      final List<NotificationPageItem> data = snapshot.data!;
                      addNotDuplicateNotifications(data);
                      return _scrollNotifications.isEmpty
                          ? BaseWidget.instance.emptyWidget()
                          : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        controller: ScrollController(),
                        itemCount: _scrollNotifications.length,
                        itemBuilder: (context, index) {
                          return ItemNotificationWidget(
                              notification:
                              _scrollNotifications[index]);
                        },
                      );
                    },
                    streamController: _dataStreamController,
                  ),
                ],
              )),
        ),
      );
    });
  }
}
