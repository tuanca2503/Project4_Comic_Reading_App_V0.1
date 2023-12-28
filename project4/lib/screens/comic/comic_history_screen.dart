import 'package:flutter/material.dart';

class ComicHistoryScreen extends StatefulWidget {
  const ComicHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ComicHistoryScreen> createState() => _ComicHistoryScreenState();
}

class _ComicHistoryScreenState extends State<ComicHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('history'),
    );
  }
}
