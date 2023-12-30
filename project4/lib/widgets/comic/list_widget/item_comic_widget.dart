import 'package:flutter/material.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/models/comic/page_comic_item.dart';
import 'package:project4/screens/comic/details_comic_screen.dart';
import 'package:project4/screens/comic/reading_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/comic/comic_bottom_sheet.dart';
import 'package:project4/widgets/comic/list_widget/list_genres_horizontal.dart';

enum ItemComicType { normal, history }

class ItemComicWidget extends StatelessWidget {
  const ItemComicWidget({Key? key, required this.comic, this.itemComicType = ItemComicType.normal}) : super(key: key);

  final PageComicItem comic;
  final ItemComicType itemComicType;

  void _onPress(BuildContext context) {
    switch (itemComicType) {
      case ItemComicType.normal:
        Helper.navigatorPush(
            context: context, screen: DetailsComicScreen(id: comic.id));
        case ItemComicType.history:
          Helper.navigatorPush(
              context: context, screen: ReadingScreen(comicId: comic.id, chapterId: comic.currentReadChapterId,));
    }

  }

  void _onLongPress(BuildContext context, String id) {
    // ignore: use_build_context_synchronously
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return ComicBottomSheet(id: id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? lastUpdated = Helper.showTimeUpdatedComic(comic.lastUpdatedDate);
    // Expanded
    return Container(
      height: AppFontSize.headline1 * 4.5,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: AppDimension.dimension8),
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.all(Radius.circular(AppDimension.dimension8)),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: GestureDetector(
        onTap: () {
          _onPress(context);
        },
        onLongPress: () {
          _onLongPress(context, comic.id);
        },
        child: Container(
          padding: const EdgeInsets.all(AppDimension.dimension8),
          child: Row(
            children: [
              Expanded(flex: 1, child: _comicImageWidget()),
              const SizedBox(
                width: AppDimension.dimension8,
              ),
              Expanded(flex: 3, child: _comicInfoWidget(context, lastUpdated)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _comicImageWidget() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimension.dimension8),
        ),
      ),
      child: BaseWidget.instance.setImageNetwork(link: comic.coverImage),
    );
  }

  Widget _comicInfoWidget(BuildContext context, String? lastUpdated) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          comic.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppFontSize.headline3),
        ),
        ListGenresHorizontal(
          genres: comic.genres,
          fontSize: AppFontSize.label,
          height: AppDimension.baseConstraints.maxHeight * 0.04,
          bgColor: Theme.of(context).colorScheme.surfaceVariant,
          textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        Text(
          "${comic.totalChapters} Chương",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: AppFontSize.label),
        ),
        itemComicType == ItemComicType.history ? Text(
          "Đang đọc: ${comic.currentReadChapterName}",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: AppFontSize.label,
          ),
        ) : Container(),
        lastUpdated != null
            ? Text(
                "Cập nhật: $lastUpdated",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: AppFontSize.label,
                  color: Theme.of(context).colorScheme.tertiary
                ),
              )
            : Container(),
        _comicInteractGroupWidget(context),
      ],
    );
  }

  Widget _comicInteractGroupWidget(BuildContext context) {
    return Row(
      children: [
        _comicInteractWidget(
            context, Icons.remove_red_eye_outlined, comic.totalRead),
        _comicInteractWidget(context, Icons.thumb_up, comic.totalLike),
        _comicInteractWidget(context, Icons.favorite, comic.totalFavourite),
      ],
    );
  }

  Widget _comicInteractWidget(
      BuildContext context, IconData iconData, int text) {
    return Container(
      padding: const EdgeInsets.only(right: AppDimension.dimension8),
      child: Row(
        children: [
          Container(
            child: BaseWidget.instance.setIcon(
                iconData: iconData,
                size: AppFontSize.label),
          ),
          Text(
            " $text",
            style: TextStyle(
                fontSize: AppFontSize.label),
          ),
        ],
      ),
    );
  }
}
