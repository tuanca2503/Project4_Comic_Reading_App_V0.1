import 'package:flutter/material.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/models/comic/detail_comic.dart';
import 'package:project4/repositories/comic_repository.dart';
import 'package:project4/screens/comic/reading_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/widgets/app/custom_button_widget.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/comic/interact_comic.dart';
import 'package:project4/widgets/comic/list_widget/list_genres_horizontal.dart';

class ComicBottomSheet extends StatefulWidget {
  final String id;
  final String? currentChapterId;

  const ComicBottomSheet({Key? key, required this.id, this.currentChapterId})
      : super(key: key);

  @override
  State<ComicBottomSheet> createState() => _ComicBottomSheetState();
}

class _ComicBottomSheetState extends State<ComicBottomSheet> {
  DetailComic? detailComic;

  @override
  void initState() {
    super.initState();
    ComicRepository.instance.getDetailsComics(id: widget.id).then((value) {
      setState(() {
        detailComic = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimension.baseConstraints.maxHeight * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppDimension.dimension16),
            topRight: Radius.circular(AppDimension.dimension16)),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppDimension.dimension8),
        color: Theme.of(context).colorScheme.surface,
        child: detailComic == null
            ? const Center(child: CircularProgressIndicator())
            : _bottomSheetWidget(),
      ),
    );
  }

  Widget _bottomSheetWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSurface,
            borderRadius: const BorderRadius.all(
                Radius.circular(AppDimension.dimension8)),
          ),
          width: AppDimension.dimension64,
          height: AppDimension.dimension4,
        ),
        _mangaInfoWidget(
            AppDimension.baseConstraints.maxHeight * 0.3, detailComic!),
        InteractComicWidget(
          bgColor: Theme.of(context).colorScheme.surface,
          iconColor: Theme.of(context).colorScheme.onSurface,
          height: AppDimension.baseConstraints.maxHeight * 0.2,
          detailComic: detailComic!,
          textColor: Theme.of(context).colorScheme.onSurface,
        ),
        CustomButtonWidget(
          onTap: () {
            Helper.navigatorPush(
                context: context,
                screen: ReadingScreen(
                  comicId: detailComic!.id,
                  chapterId: detailComic!.currentReadChapterId,
                ));
          },
          text: "Đọc ngay",
          bgColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.onPrimary,
          fontSize: AppFontSize.button,
        ),
      ],
    );
  }

  Widget _mangaInfoWidget(double height, DetailComic comic) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppDimension.dimension8))),
              child: FittedBox(
                fit: BoxFit.cover,
                child:
                    BaseWidget.instance.setImageNetwork(link: comic.coverImage),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(left: AppDimension.dimension8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comic.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AppFontSize.headline2),
                  ),
                  Text(
                    "${comic.totalChapters} Chương",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppFontSize.label),
                  ),
                  ListGenresHorizontal(
                    genres: comic.genres,
                    fontSize: AppFontSize.label,
                    height: AppDimension.baseConstraints.maxHeight * 0.03,
                    bgColor: Theme.of(context).colorScheme.surfaceVariant,
                    textColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  Text(
                    comic.description,
                    style: TextStyle(
                      fontSize: AppFontSize.body,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
