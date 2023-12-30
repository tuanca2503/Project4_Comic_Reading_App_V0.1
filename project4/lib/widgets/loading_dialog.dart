import 'package:flutter/material.dart';
import 'package:project4/widgets/base_widget.dart';

class LoadingDialog extends StatelessWidget {
  final String message;

  const LoadingDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseWidget.instance.loadingWidget(),
          const SizedBox(
            height: 10,
          ),
          Text("$message ..."),
        ],
      ),
    );
  }
}
