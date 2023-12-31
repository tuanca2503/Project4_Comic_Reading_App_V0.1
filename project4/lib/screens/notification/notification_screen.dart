import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/main.dart';
import 'package:project4/repositories/notification_repository.dart';
import 'package:project4/screens/notification/scroll_page_notify_widget.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/widgets/app/custom_app_bar.dart';
import 'package:project4/widgets/loading_dialog.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenScreen();
}

class _NotificationScreenScreen extends State<NotificationScreen> {
  final List<Widget> _tabs = [
    const Tab(text: 'Tất cả'),
    const Tab(text: 'Chưa đọc')
  ];
  final List<Widget> _tabBarView = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabBarView.add(const ScrollPageNotifyWidget(
      hasRead: true,
    ));
    _tabBarView.add(const ScrollPageNotifyWidget(
      hasRead: false,
    ));
  }

  void _markAsReadAll() {
    showDialog(
        context: context,
        builder: (c) {
          return const LoadingDialog(message: "Đang xử lý");
        });
    NotificationRepository.instance.markAllAsRead().then((_) {
      Helper.navigatorPop(context);
      Helper.showSuccessSnackBar(context, 'Đánh dấu đã đọc thành công!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          selectedAppBar: AppBarEnum.back),
      body: DefaultTabController(
        length: _tabs.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(tabs: _tabs),
            Expanded(
              child: TabBarView(children: _tabBarView),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rightActionWidget() {
    return GestureDetector(
        onTap: _markAsReadAll,
        /*onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return const BottomSheetOption();
            },
          );
        },*/
        child: Icon(
          Icons.done_all,
          color: Theme.of(context).colorScheme.primary,
        ));
  }
}
