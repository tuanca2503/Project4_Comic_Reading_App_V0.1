import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/screens/notification/bottom_sheet_option.dart';
import 'package:project4/utils/app_dimension.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _RankFollowScreen();
}

class _RankFollowScreen extends State<NotificationScreen> {
  bool isRead = false;
  bool hasBeenPressed = false;
  int selectedIdx = 0;

  final List<Widget> _tabs = [const Tab(text: 'Tất cả'), const Tab(text: 'Chưa đọc')];
  final List<Widget> _tabBarView = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: AppDimension.initPaddingBody(),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Thông báo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      child: MyListItem(0, selectedIdx, 'Tất cả',
                          onTap: handleTap),
                    ),
                    Container(
                      width: 100,
                      child: MyListItem(1, selectedIdx, 'Chưa đọc',
                          onTap: handleTap),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 8,
              child: Container(
                child: ListView(
                  children: [
                    Column(children: [
                      ListTile(
                        onTap: () {
                          setState(() {
                            if (!hasBeenPressed) {
                              isRead = !isRead;
                              hasBeenPressed = true;
                            }
                          });
                        },
                        title: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                child: const CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/user.png')),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 7,
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Column(
                                    children: [
                                      Text(
                                        'Text withouundr',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration
                                              .none, // Tắt dấu gạch dưới
                                        ),
                                      ),
                                      Text(
                                        'Text withouundr',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          decoration: TextDecoration
                                              .none, // Tắt dấu gạch dưới
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.only(top: 5, bottom: 5),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const BottomSheetOption(),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      child: CircleAvatar(
                                        backgroundColor: isRead
                                            ? AppColor.transparent
                                            : Colors.blue,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
                    const Divider(),
                  ],
                ),
              ),
            ),

            //    Navigator.of(context).pop();
            //
          ],
        ),
      ),
    );
  }

  void handleTap(int index) {
    setState(() {
      selectedIdx = index;
    });
  }

  Widget _allNotifyWidget() {

  }
}

class MyListItem extends StatelessWidget {
  final int index;
  final int selectedIdx;
  final String itemName;
  final Function(int) onTap;

  MyListItem(this.index, this.selectedIdx, this.itemName,
      {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap(index);
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            itemName,
            style: TextStyle(
              color: selectedIdx == index ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
