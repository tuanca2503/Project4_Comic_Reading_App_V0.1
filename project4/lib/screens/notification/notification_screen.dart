import 'package:flutter/material.dart';
import 'package:project4/screens/notification/bottom_sheet_option.dart';
import 'package:project4/screens/notification/scroll_page_notify_widget.dart';
import 'package:project4/widgets/app/custom_app_bar.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(selectedAppBar: AppBarEnum.back),
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
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return const BottomSheetOption();
            },
          );
        },
        child: Icon(
          Icons.more_vert,
          color: Theme.of(context).colorScheme.primary,
        ));
  }
}
