import 'package:flutter/material.dart';
import 'package:project4/main.dart';
import 'package:project4/screens/follow/follow_comic_screen.dart';
import 'package:project4/screens/home/home_screen.dart';
import 'package:project4/screens/search/search_screen.dart';
import 'package:project4/screens/setting/auth/auth_screen.dart';
import 'package:project4/screens/setting/setting_screen.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/widgets/app/custom_app_bar.dart';
import 'package:project4/widgets/app/custom_bottom_navigator_bar.dart';
import 'package:provider/provider.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _storage = Storages.instance;
  late int _selectedIndex;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  bool onBottomTabChange(int index) {
    // check if auth screen
    if (index == 3 && !_storage.isLogin()) {
      Helper.navigatorPush(context: context, screen: const AuthScreen());
      return false;
    } else {
      setState(() {
        _selectedIndex = index;
        _pageController.jumpToPage(_selectedIndex);
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppBar(selectedAppBar: AppBarEnum.logo),
      body: Consumer<ScreenProvider>(builder: (context, provider, child) {
        return PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            const HomeScreen(),
            const SearchScreen(),
            const FollowScreen(),
            Storages.instance.isLogin() ? const SettingScreen() : const AuthScreen(),
          ],
        );
      }),
      bottomNavigationBar: CustomBottomNavigatorBar(
        onTabChange: onBottomTabChange,
      ),
    );
  }
}
