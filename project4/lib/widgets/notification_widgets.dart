import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/utils/app_dimension.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _RankFollowScreen();
}

class _RankFollowScreen extends State<NotificationWidget> {
  bool isRead = false;
  bool hasBeenPressed = false;
  int selectedIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyNotification(),
    );
  }

  Widget bodyNotification() {
    double heightNotification = AppDimension.baseConstraints.maxHeight * 0.9;

    return Container(
      height: heightNotification,
      padding: EdgeInsets.all(15),
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
                    child:
                        MyListItem(0, selectedIdx, 'Tất cả', onTap: handleTap),
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
                              padding: EdgeInsets.all(6),
                              child: const CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage('assets/user.png')),
                            ),
                          ),
                          SizedBox(width: 20),
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
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  BottomSheetExample(),
                                  SizedBox(height: 5),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: CircleAvatar(
                                      backgroundColor: isRead
                                          ? Colors.transparent
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
                  Divider(),
                ],
              ),
            ),
          ),

          //    Navigator.of(context).pop();
          //
        ],
      ),
    );
  }

  void handleTap(int index) {
    setState(() {
      selectedIdx = index;
    });
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
          padding: EdgeInsets.all(16.0),
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

class BottomSheetExample extends StatelessWidget {
  double screenHeight = AppDimension.baseConstraints.maxHeight;
  BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            backgroundColor: Color(0xff212224),
            builder: (BuildContext context) {
              return SizedBox(
                height: screenHeight * 0.4,
                child: const Padding(
                  padding: EdgeInsets.all(16.0), // Thêm padding vào nội dung
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('assets/user.png'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Tên nội dung của thông báo',
                          style:
                              TextStyle(color: Color(0xffd7d8da), fontSize: 20),
                        ),
                        SizedBox(height: 20),
                        Divider(
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Icon(Icons.cancel, size: 30.0),
                            ),
                            Expanded(
                              flex: 8,
                              child: Text(
                                'Gỡ thông báo này',
                                style: TextStyle(
                                    color: Color(0xffd7d8da), fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Icon(Icons.notifications_off, size: 30.0),
                            ),
                            Expanded(
                              flex: 8,
                              child: Text(
                                'Tắt thông báo về nội dung này',
                                style: TextStyle(
                                    color: Color(0xffd7d8da), fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Icon(Icons.warning, size: 30.0),
                            ),
                            Expanded(
                              flex: 8,
                              child: Text(
                                'Báo cáo sự cố ',
                                style: TextStyle(
                                    color: Color(0xffd7d8da), fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Icon(Icons.settings, size: 30.0),
                            ),
                            Expanded(
                              flex: 8,
                              child: Text(
                                'Quản lý cài đặt thông báo ',
                                style: TextStyle(
                                    color: Color(0xffd7d8da), fontSize: 18),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.all(16),
          child: Icon(
            Icons.more_horiz,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

// Widget buildContent(BuildContext context) {
//   return Column(
//     children: [
//       Expanded(
//         flex: 3,
//         child: Container(
//           height: screenHeight * 0.1,
//           decoration: BoxDecoration(
//             border: Border.all(width: 1, color: Colors.white),
//           ),
//         ),
//       ),
//       Expanded(
//         flex: 7,
//         child: Container(
//           height: screenHeight * 0.2,
//           decoration: BoxDecoration(
//             border: Border.all(width: 1, color: Colors.white),
//           ),
//         ),
//       ),
//     ],
//   );
// }
}
