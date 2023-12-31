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

class ScrollPageNotifyWidget extends StatefulWidget {
  const ScrollPageNotifyWidget({
    Key? key,
    this.title,
    required this.hasRead, this.updateNotificationState,
  }) : super(key: key);
  final Widget? title;
  final bool hasRead; // true -> all, false -> only unread
  final void Function(String?)? updateNotificationState;

  @override
  State<ScrollPageNotifyWidget> createState() => _ScrollPageNotifyWidgetState();
}

class _ScrollPageNotifyWidgetState extends State<ScrollPageNotifyWidget> {
  int page = 0;
  final int pageSize = 10;
  final scrollController = ScrollController();
  bool? hasNext;
  bool isLoading = false;
  late StreamController<List<NotificationPageItem>> _dataStreamController;
  final List<String> scrollComicIds = [];
  final List<NotificationPageItem> scrollNotifications = [];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    _dataStreamController =
        StreamController<List<NotificationPageItem>>.broadcast();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading = true;
      PageData<NotificationPageItem> pageData =
          await NotificationRepository.instance.getAllNotification(
              page: page, pageSize: pageSize, hasRead: widget.hasRead);

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

  void addNotDuplicateNotifications(List<NotificationPageItem> notifications) {
    for (var c in notifications) {
      if (!scrollComicIds.contains(c.id)) {
        scrollComicIds.add(c.id);
        scrollNotifications.add(c);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenProvider>(builder: (context, provider, child) {
      if (provider.notificationPageItem != null) {
        scrollNotifications.insert(0, provider.notificationPageItem!);
        scrollComicIds.insert(0, provider.notificationPageItem!.id);
        // has `addNotDuplicateNotifications` -> cannot update page
      }
      return SingleChildScrollView(
        padding: AppDimension.initPaddingBody(),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.title != null ? widget.title! : Container(),
            BaseWidget.instance.setStreamBuilder(
              callback: (snapshot) {
                final List<NotificationPageItem> data = snapshot.data!;
                addNotDuplicateNotifications(data);
                return scrollNotifications.isEmpty
                    ? BaseWidget.instance.emptyWidget()
                    : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  controller: ScrollController(),
                  itemCount: scrollNotifications.length,
                  itemBuilder: (context, index) {
                    return ItemNotificationWidget(
                        notification: scrollNotifications[index]);
                  },
                );
              },
              streamController: _dataStreamController,
            ),
          ],
        ),
      );
    });
  }
}
