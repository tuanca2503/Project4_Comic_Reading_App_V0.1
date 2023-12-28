import 'package:flutter/material.dart';
import 'package:project4/models/comic/page_comic_item.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/widgets/list_widget/item_comic_widget.dart';

class ListWidget extends StatefulWidget {
  ListWidget({super.key, required this.comics});

  final List<PageComicItem> comics;
  final bool isLogin = Storages.instance.isLogin();

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.comics.length,
      itemBuilder: (context, index) {
        return ItemComicWidget(comic: widget.comics[index]);
      },
    );
  }
}
