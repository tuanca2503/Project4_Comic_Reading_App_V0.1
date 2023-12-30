import 'package:flutter/material.dart';
import 'package:project4/models/comic/filter_comic.dart';
import 'package:project4/widgets/app/custom_app_bar.dart';
import 'package:project4/widgets/comic/list_widget/item_comic_widget.dart';
import 'package:project4/widgets/comic/list_widget/scroll_page_widget.dart';
import 'package:project4/widgets/title_app_widget.dart';

class ComicHistoryScreen extends StatefulWidget {
  const ComicHistoryScreen({super.key});

  @override
  State<ComicHistoryScreen> createState() => _RankComicHistoryScreen();
}

class _RankComicHistoryScreen extends State<ComicHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        selectedAppBar: AppBarEnum.back,
        bgColor: Theme.of(context).colorScheme.surface,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      body: ScrollPageWidget(
        filter: FilterComicType.LAST_UPDATED_DATE.value,
        title: const TitleAppWidget(
          title: 'Lịch sử đọc',
          // crossAxisAlignment: CrossAxisAlignment.start,
        ),
        queryType: QueryType.read,
        itemComicType: ItemComicType.history,
      ),
    );
  }
}
