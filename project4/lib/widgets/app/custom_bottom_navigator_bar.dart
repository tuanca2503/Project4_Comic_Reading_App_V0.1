import 'package:flutter/material.dart';
import 'package:project4/main.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigatorBar extends StatefulWidget {
  const CustomBottomNavigatorBar({Key? key, required this.onTabChange})
      : super(key: key);
  final bool Function(int) onTabChange;

  @override
  State<CustomBottomNavigatorBar> createState() =>
      _CustomBottomNavigatorBarState();
}

class _CustomBottomNavigatorBarState extends State<CustomBottomNavigatorBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      if (widget.onTabChange(index)) {
        _selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenProvider>(builder: (context, provider, child) {
      return BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Tìm kiếm',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined),
            label: 'Theo dõi',
          ),
          BottomNavigationBarItem(
            icon: Storages.instance.isLogin()
                ? BaseWidget.instance.getAvatarWidget(size: 24)
                : const Icon(Icons.settings),
            label: Storages.instance.isLogin()
                ? Storages.instance.getUser()?.username ?? 'User'
                : 'Đăng nhập',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      );
    });
  }
}
