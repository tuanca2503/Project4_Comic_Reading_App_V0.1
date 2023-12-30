import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/main.dart';
import 'package:project4/repositories/auth_repository.dart';
import 'package:project4/repositories/user_repository.dart';
import 'package:project4/screens/comic/comic_history_screen.dart';
import 'package:project4/screens/main_screen.dart';
import 'package:project4/screens/user/change_password_screen.dart';
import 'package:project4/screens/user/user_info_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/widgets/app/custom_button_widget.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/loading_dialog.dart';

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
    _darkSwitched = _storage.isDarkMode();
  }

  void _logout() {
    showDialog(context: context, builder: (c) {
      return const LoadingDialog(message: "Đang đăng xuất");
    });

    Timer(const Duration(seconds: 1), () async {
      await AuthRepository.instance.logout();
      if (!mounted) return;
      Helper.navigatorPop(context);
      Helper.navigatorPush(
          context: context, screen: const MainScreen(), isReplace: true);
    });
  }

  void _switchDarkMode(bool value) {
    _storage.setDarkMode(value).then((_) {
      setState(() {
        _darkSwitched = value;
        GetIt.instance<ScreenProvider>().setIsDarkMode(value);
      });
    });
  }

  void _switchNotification(bool _) {
    showDialog(context: context, builder: (c) {
      return const LoadingDialog(message: "Đang cập nhật");
    });
    UserRepository.instance.toggleReceiveNotification().then((value) {
      _storage.setIsNotify(value).then((_) {
        setState(() {
          _notificationsSwitched = value;
          Helper.navigatorPop(context);
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
          _userSettingWidget(),
          _modeSettingWidget(),
          _notificationSettingWidget(),
          const SizedBox(height: AppDimension.dimension8,),
          CustomButtonWidget(
            onTap: _logout,
            text: 'Đăng xuất',
            textColor: Theme.of(context).colorScheme.onBackground,
            bgColor: AppColor.error,
          ),
        ]),
      ),
    );
  }

  Widget _userSettingWidget() {
    return _settingGroupWidget(
        titleGroupWidget: _titleGroupWidget('Cá nhân'),
        settingWidgets: [
          _settingItemWidget(
            avatarWidget: _avatarWidget(),
            prefixIconColor: Colors.redAccent,
            title: Storages.instance.getUser()!.username!,
            suffixIconData: Icons.navigate_next,
            onSetting: () {
              goToScreen(const UserInfoScreen());
            },
          ),
          _settingItemWidget(
            prefixIconData: Icons.vpn_key,
            prefixIconColor: Colors.redAccent,
            title: 'Đổi mật khẩu',
            suffixIconData: Icons.navigate_next,
            onSetting: () {
              goToScreen(const ChangePasswordScreen());
            },
          ),
          _settingItemWidget(
            prefixIconData: Icons.history,
            prefixIconColor: Colors.blueAccent,
            title: 'Lịch sử đọc truyện',
            suffixIconData: Icons.navigate_next,
            onSetting: () {
              goToScreen(const ComicHistoryScreen());
            },
          ),
        ]);
  }

  Widget _modeSettingWidget() {
    return _settingGroupWidget(
        titleGroupWidget: _titleGroupWidget('Thiết lập'),
        settingWidgets: [
          _settingSwitchWidget(
              prefixIconData: Icons.dark_mode,
              prefixIconColor: Colors.black54,
              title: 'Giao diện tối',
              switchValue: _darkSwitched,
              onSetting: _switchDarkMode)
        ]);
  }

  Widget _notificationSettingWidget() {
    return _settingGroupWidget(
        titleGroupWidget: _titleGroupWidget('Thông báo'),
        settingWidgets: [
          _settingSwitchWidget(
            prefixIconData: Icons.notifications,
            prefixIconColor: Colors.green,
            title: 'Thông báo',
            switchValue: _notificationsSwitched,
            onSetting: _switchNotification,
          ),
        ]);
  }

  Widget _settingGroupWidget(
      {required Widget titleGroupWidget,
      required List<Widget> settingWidgets}) {
    return Container(
      padding: const EdgeInsets.only(top: AppDimension.dimension16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleGroupWidget,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppDimension.dimension16, vertical: AppDimension.dimension8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                  Radius.circular(AppDimension.dimension8)),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              children: settingWidgets,
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleGroupWidget(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: AppFontSize.headline2,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _settingItemWidget({
    IconData? prefixIconData,
    Widget? avatarWidget,
    required Color prefixIconColor,
    required String title,
    IconData? suffixIconData,
    required void Function() onSetting,
  }) {
    return GestureDetector(
      onTap: onSetting,
      child: SizedBox(
        height: AppDimension.baseConstraints.maxHeight * 0.08,
        child: Row(children: [
          _userAvatarWidget(
              iconData: prefixIconData,
              avatarWidget: avatarWidget,
              color: prefixIconColor),
          _settingNameWidget(title),
          suffixIconData != null ? BaseWidget.instance.setIcon(iconData: suffixIconData) : Container(),
        ]),
      ),
    );
  }

  Widget _settingSwitchWidget({
    required IconData prefixIconData,
    required Color prefixIconColor,
    required String title,
    required bool switchValue,
    required void Function(bool value) onSetting,
  }) {
    return SizedBox(
      height: AppDimension.baseConstraints.maxHeight * 0.08,
      child: Row(children: [
        _userAvatarWidget(
            iconData: prefixIconData,
            color: prefixIconColor),
        _settingNameWidget(title),
        _suffixSwitchButtonWidget(switchValue, onSetting),
      ]),
    );
  }

  Widget _userAvatarWidget(
      {IconData? iconData, Widget? avatarWidget, required Color color}) {
    return SizedBox(
      child: iconData != null
          ? BaseWidget.instance.setIcon(iconData: iconData, color: color)
          : avatarWidget,
    );
  }

  Widget _settingNameWidget(String title) {
    return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.only(left: AppDimension.dimension16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: AppFontSize.headline4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }

  Widget _suffixSwitchButtonWidget(
      bool switchValue, void Function(bool) onSetting) {
    return Switch(
      value: switchValue,
      activeColor: Theme.of(context).colorScheme.onSurface,
      activeTrackColor: Theme.of(context).colorScheme.surface,
      inactiveThumbColor: Theme.of(context).colorScheme.secondary,
      inactiveTrackColor: Theme.of(context).colorScheme.onSecondary,
      onChanged: (value) {
        onSetting(value);
      },
    );
  }

  Widget _avatarWidget() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(120))),
      child: BaseWidget.instance.getAvatarWidget(),
    );
  }
}
