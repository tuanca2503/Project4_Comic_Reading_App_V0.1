import 'package:flutter/material.dart';
import 'package:project4/widgets/base_widget.dart';

import '../utils/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key}) : super(key: key);

  final Color colorTheme = const Color(0xFF080401);
  final double height = baseConstraints.maxHeight * 0.09;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.colorTheme,
      padding: EdgeInsets.all(baseConstraints.maxWidth * 0.02),
      height: widget.height,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
                alignment: Alignment.bottomLeft,
                child: BaseWidget().setImageAsset("logo_white.png")),
          ),
          BaseWidget().setIcon(iconData: Icons.qr_code_scanner),
          BaseWidget().setIcon(iconData: Icons.notifications_outlined)
        ],
      ),
    );
  }
}
