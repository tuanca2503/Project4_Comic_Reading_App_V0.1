import 'package:flutter/material.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/widgets/base_widget.dart';

enum AppBarEnum { logo, back }

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.selectedAppBar, this.color})
      : super(key: key);
  final AppBarEnum selectedAppBar;
  final Color? color;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(_getPreferredHeight());

  double _getPreferredHeight() {
    switch (selectedAppBar) {
      case AppBarEnum.logo:
        return AppDimension.baseConstraints.maxHeight * 0.09;
      case AppBarEnum.back:
        return AppDimension.baseConstraints.maxHeight * 0.1;
    }
  }
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return _getAppBar();
  }

  Widget _getAppBar() {
    switch (widget.selectedAppBar) {
      case AppBarEnum.logo:
        return _appBarLogo();
      case AppBarEnum.back:
        return _appBarBack(widget.color);
    }
  }

  Widget _appBarLogo() {
    return Container(
      padding: EdgeInsets.all(AppDimension.baseConstraints.maxWidth * 0.02),
      height: widget.preferredSize.height,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.bottomLeft,
              child: BaseWidget.instance.getLogoApp(context: context, scale: 1),
            ),
          ),
          BaseWidget.instance.setIcon(iconData: Icons.qr_code_scanner),
          BaseWidget.instance.setIcon(iconData: Icons.notifications_outlined)
        ],
      ),
    );
  }

  Widget _appBarBack(Color? color) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.navigate_before,
          size: Theme.of(context).textTheme.headlineLarge?.fontSize,
          color: color,
        ),
        onPressed: () {
          Navigator.maybePop(context);
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
