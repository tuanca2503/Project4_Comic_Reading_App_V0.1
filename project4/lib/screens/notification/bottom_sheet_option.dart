import 'package:flutter/material.dart';
import 'package:project4/utils/app_dimension.dart';

class BottomSheetOption extends StatelessWidget {
  const BottomSheetOption({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          backgroundColor: Theme.of(context).colorScheme.background,
          builder: (BuildContext context) {
            return SizedBox(
              height: AppDimension.baseConstraints.maxHeight * 0.4,
              child: const Padding(
                padding: EdgeInsets.all(AppDimension.dimension16),
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
        padding: EdgeInsets.all(AppDimension.dimension16),
        child: Icon(
          Icons.more_horiz,
          color: Colors.white,
        ),
      ),
    );
  }
}