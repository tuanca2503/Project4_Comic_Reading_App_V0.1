import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/models/comic/page_comic_item.dart';
import 'package:project4/screens/details_comic_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/comic_bottom_sheet.dart';
import 'package:project4/widgets/list_widget/list_genres_horizontal.dart';

class ItemComicWidget extends StatelessWidget {
  const ItemComicWidget({Key? key, required this.comic}) : super(key: key);

  final PageComicItem comic;

  void _onPress(BuildContext context) {
    Helper.navigatorPush(
        context: context, screen: DetailsComicScreen(id: comic.id));
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
    return Container(
      height: AppDimension.baseConstraints.maxHeight * 0.2,
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
              Expanded(flex: 3, child: _comicInfoWidget(context)),
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

  Widget _comicInfoWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comic.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize),
        ),
        ListGenresHorizontal(
            genres: comic.genres,
            fontSize: Theme.of(context).textTheme.titleSmall?.fontSize,
            height: AppDimension.baseConstraints.maxHeight * 0.04,
            bgColor: Theme.of(context).colorScheme.surfaceVariant,
            textColor: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        Text(
          "${comic.totalChapters} Chương",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: Theme.of(context).textTheme.labelLarge?.fontSize),
        ),
        _comicInteractGroupWidget(context),
      ],
    );
  }

  Widget _comicInteractGroupWidget(BuildContext context) {
    return Row(
      children: [
        _comicInteractWidget(context, Icons.remove_red_eye_outlined, comic.totalRead),
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
                size: Theme.of(context).textTheme.labelLarge?.fontSize),
          ),
          Text(
            " $text",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.labelLarge?.fontSize),
          ),
        ],
      ),
    );
  }
}
