import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/main.dart';
import 'package:project4/repositories/auth_repository.dart';
import 'package:project4/repositories/user_repository.dart';
import 'package:project4/screens/comic/comic_history_screen.dart';
import 'package:project4/screens/main_screen.dart';
import 'package:project4/screens/user/change_password_screen.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/widgets/base_widget.dart';

import '../utils/app_dimension.dart';

// ignore: must_be_immutable

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _darkSwitched = false;
  bool _notificationsSwitched = false;
  final Storages _storage = Storages.instance;

  double screenHeight = 0;

  @override
  void initState() {
    super.initState();
    screenHeight = AppDimension.baseConstraints.maxHeight;
    _notificationsSwitched = _storage.getIsNotify();
    _darkSwitched = _storage.getDarkMode();
  }

  Future<void> _logout() async {
    await AuthRepository.instance.logout();
    if (!mounted) return;
    Helper.navigatorPush(
        context: context, screen: const MainScreen(), isReplace: true);
  }

  void _switchDarkMode(bool value) {
    _storage.setDarkMode(value).then((_) {
      setState(() {
        _darkSwitched = value;
        GetIt.instance<ScreenProvider>().setIsDarkMode(value);
        print('dark mode = ${_storage.getDarkMode()}');
      });
    });
  }

  void _switchNotification(bool _) {
    UserRepository.instance.toggleReceiveNotification().then((value) {
      _storage.setIsNotify(value).then((_) {
        setState(() {
          _notificationsSwitched = value;
          print('notification = $_notificationsSwitched');
        });
      });
    });
  }

  void goToScreen(Widget screen) {
    Helper.navigatorPush(context: context, screen: screen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: AppDimension.initPaddingBody(),
        child: Column(children: [
          // Thông tin cá nhân, đổi giao diện, thông báo, logout button
          _userSettingWidget(),
          _modeSettingWidget(),
          _notificationSettingWidget(),
          _logoutWidget(),
        ]),
      ),
    );
  }

  Widget _userSettingWidget() {
    return Column(
      children: [
        SizedBox(
          width: AppDimension.baseConstraints.maxWidth,
          height: screenHeight * 0.06,
          child: const Text(
            'Cài đặt',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: AppDimension.baseConstraints.maxWidth,
          height: screenHeight * 0.08,
          child: Row(children: [
            Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: LayoutBuilder(builder: (ct, cs) {
                    return Container(
                      width: cs.maxHeight,
                      height: cs.maxHeight,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(120))),
                      child: BaseWidget.instance.getAvatarWidget(),
                    );
                  }),
                )),
            Expanded(
              flex: 6,
              child: Container(
                width: AppDimension.baseConstraints.maxWidth,
                height: AppDimension.baseConstraints.maxHeight,
                padding: const EdgeInsets.only(left: 20),
                child: ListView(
                  children: [
                    Text(
                      Storages.instance.getUserLogin()!.username!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Sửa thông tin',
                      style: TextStyle(
                        color: Color(0xff575757),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: SizedBox(
                  width: AppDimension.baseConstraints.maxWidth,
                  height: AppDimension.baseConstraints.maxHeight,
                  child: BaseWidget.instance
                      .setIcon(iconData: Icons.navigate_next),
                )),
          ]),
        ),
        _settingItemWidget(
          prefixIconData: Icons.vpn_key,
          prefixIconColor: Colors.redAccent,
          title: 'Đổi mật khẩu',
          suffixIconData: Icons.navigate_next,
          onSetting: (_) {
            goToScreen(const ChangePasswordScreen());
          },
        ),
        _settingItemWidget(
          prefixIconData: Icons.history,
          prefixIconColor: Colors.blueAccent,
          title: 'Lịch sử đọc truyện',
          suffixIconData: Icons.navigate_next,
          onSetting: (_) {
            goToScreen(const ComicHistoryScreen());
          },
        ),
      ],
    );
  }

  Widget _modeSettingWidget() {
    return Column(
      children: [
        SizedBox(
          width: AppDimension.baseConstraints.maxWidth,
          height: screenHeight * 0.06,
          child: const Center(
            child: Stack(
              children: [
                Align(
                  alignment:
                      Alignment.centerLeft, // Đặt vị trí về giữa bên trái
                  child: Text(
                    'Thông tin',
                    style: TextStyle(
                      color: Color(0xff595959),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _settingItemWidget(
            prefixIconData: Icons.dark_mode,
            prefixIconColor: Colors.white,
            title: 'Giao diện tối',
            switchValue: _darkSwitched,
            onSetting: _switchDarkMode),
      ],
    );
  }

  Widget _notificationSettingWidget() {
    return Column(
      children: [
        SizedBox(
          width: AppDimension.baseConstraints.maxWidth,
          height: screenHeight * 0.06,
          child: const Center(
            child: Stack(
              children: [
                Align(
                  alignment:
                      Alignment.centerLeft, // Đặt vị trí về giữa bên trái
                  child: Text(
                    'Thông báo',
                    style: TextStyle(
                      color: Color(0xff595959),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _settingItemWidget(
            prefixIconData: Icons.notifications,
            prefixIconColor: Colors.green,
            title: 'Thông báo',
            switchValue: _notificationsSwitched,
            onSetting: _switchNotification,),
      ],
    );
  }

  Widget _logoutWidget() {
    return _settingItemWidget(
      prefixIconData: Icons.logout,
      prefixIconColor: Colors.orangeAccent,
      title: 'Đăng xuất',
      suffixIconData: Icons.navigate_next,
      onSetting: (_) {
        _logout();
      },
    );
  }

  Widget _settingItemWidget({
    required IconData prefixIconData,
    required Color prefixIconColor,
    required String title,
    IconData? suffixIconData,
    bool? switchValue,
    required void Function(bool value) onSetting,
  }) {
    return Row(children: [
      _iconWidget(prefixIconData, prefixIconColor),
      _titleWidget(title),
      switchValue != null
          ? _suffixSwitchButtonWidget(switchValue, onSetting)
          : (suffixIconData != null
              ? _suffixIconWidget(suffixIconData, onSetting)
              : Expanded(
                  flex: 1,
                  child: Container(),
                )),
    ]);
  }

  Widget _iconWidget(IconData iconData, Color color) {
    return Expanded(
        flex: 1,
        child: SizedBox(
          child:
              // Icons.dark_mode
              BaseWidget.instance.setIcon(iconData: iconData, color: color),
        ));
  }

  Widget _titleWidget(String title) {
    return Expanded(
        flex: 3,
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          child: Center(
            child: Stack(
              children: [
                Align(
                  alignment:
                      Alignment.centerLeft, // Đặt vị trí về giữa bên trái
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _suffixIconWidget(IconData suffixIcon, void Function(bool) onSetting) {
    return GestureDetector(
      onTap: () { onSetting(false); },
      child: Expanded(
        flex: 2,
        child: BaseWidget.instance.setIcon(iconData: suffixIcon),
      ),
    );
  }

  Widget _suffixSwitchButtonWidget(
      bool switchValue, void Function(bool) onSetting) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        child: Center(
          child: Switch(
            value: switchValue,
            activeColor: Theme.of(context).colorScheme.onSurface,
            activeTrackColor: Theme.of(context).colorScheme.surface,
            inactiveThumbColor: Theme.of(context).colorScheme.secondary,
            inactiveTrackColor: Theme.of(context).colorScheme.onSecondary,
            onChanged: (value) {
              onSetting(value);
            },
          ),
        ),
      ),
    );
  }
}
