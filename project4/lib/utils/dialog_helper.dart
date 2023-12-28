import 'package:flutter/material.dart';

class DialogHelper extends StatelessWidget {

  const DialogHelper({Key? key, required this.message, required this.bgColor}) : super(key: key);

  final String message;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: [
        ElevatedButton(
          onPressed: () { Navigator.pop(context); },
          style: ElevatedButton.styleFrom(backgroundColor: bgColor,),
          child: const Center(
            child: Text("OK"),
          ),
        )
      ],
    );
  }
}
