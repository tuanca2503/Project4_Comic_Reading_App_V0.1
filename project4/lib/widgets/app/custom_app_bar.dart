import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/main.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/widgets/base_widget.dart';

enum AppBarEnum { logo, back }

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key, required this.selectedAppBar, this.color, this.bgColor})
      : super(key: key);
  final AppBarEnum selectedAppBar;
  final Color? color;
  final Color? bgColor;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(_getPreferredHeight());

  double _getPreferredHeight() {
    switch (selectedAppBar) {
      case AppBarEnum.logo:
        return AppDimension.baseConstraints.maxHeight * 0.09;
      case AppBarEnum.back:
        return AppDimension.baseConstraints.maxHeight * 0.08;
    }
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
  void _onChangeDarkMode(bool isDarkMode) {
    Storages.instance.setDarkMode(isDarkMode).then((_) {
      setState(() {
        GetIt.instance<ScreenProvider>().setIsDarkMode(isDarkMode);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return _getAppBar();
  }

  Widget _getAppBar() {
    switch (widget.selectedAppBar) {
      case AppBarEnum.logo:
        return _appBarLogo();
      case AppBarEnum.back:
        return _appBarBack();
    }
  }

  Widget _appBarLogo() {
    return Container(
      padding: EdgeInsets.all(AppDimension.baseConstraints.maxWidth * 0.02),
      height: widget.preferredSize.height,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomLeft,
              child: BaseWidget.instance.getLogoApp(context: context, scale: 1),
            ),
          ),
          Storages.instance.isLogin() ? BaseWidget.instance.setIcon(iconData: Icons.notifications_outlined)
              : _toggleDarkModeWidget(),
        ],
      ),
    );
  }

  Widget _toggleDarkModeWidget() {
    return Storages.instance.isDarkMode() ? _toLightModeWidget() : _toDarkModeWidget();
  }

  Widget _toDarkModeWidget() {
    return GestureDetector(
      onTap: () {
        _onChangeDarkMode(true);
      },
      child: BaseWidget.instance.setIcon(iconData: Icons.dark_mode, color: AppColor.darkMode),
    );
  }

  Widget _toLightModeWidget() {
    return GestureDetector(
      onTap: () {
        _onChangeDarkMode(false);
      },
      child: BaseWidget.instance.setIcon(iconData: Icons.sunny, color: AppColor.lightMode),
    );
  }

  Widget _appBarBack() {
    Color? backgroundColor = widget.bgColor;
    backgroundColor ??= AppColor.transparent;
    return Stack(
      children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.centerLeft,
              color: backgroundColor,
              height: widget.preferredSize.height,
              padding: const EdgeInsets.all(AppDimension.dimension8),
              child: GestureDetector(
                onTap: () {
                  Navigator.maybePop(context);
                },
                child: Icon(
                  Icons.navigate_before,
                  size: AppFontSize.headline1,
                  color: widget.color,
                ),
              ),
            )),
      ],
    );
  }
}
