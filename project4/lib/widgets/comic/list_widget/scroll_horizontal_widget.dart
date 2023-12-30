import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/models/comic/page_comic_item.dart';
import 'package:project4/models/genres.dart';
import 'package:project4/screens/comic/details_comic_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/comic/comic_bottom_sheet.dart';

class ScrollHorizontalWidget extends StatefulWidget {
  const ScrollHorizontalWidget({Key? key, required this.comics})
      : super(key: key);
  final List<PageComicItem>? comics;

  @override
  State<ScrollHorizontalWidget> createState() => _ScrollHorizontalWidgetState();
}

class _ScrollHorizontalWidgetState extends State<ScrollHorizontalWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.comics != null
        ? SizedBox(
            height: 300,
            child: LayoutBuilder(builder: (context, constraints) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.comics!.length,
                itemBuilder: (BuildContext context, int index) {
                  return _itemListView(
                      constraints: constraints, comic: widget.comics![index]);
                },
              );
            }),
          )
        : const Center(child: CircularProgressIndicator());
  }

  Widget _itemListView(
      {required BoxConstraints constraints, required PageComicItem comic}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimension.dimension8),
      width: constraints.maxWidth / 2 - 10,
      height: constraints.maxHeight,
      child: Column(
        children: [
          Expanded(
            flex: 11,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.cover,
                child: myEventHandler(
                    context: context,
                    child: BaseWidget.instance
                        .setImageNetwork(link: comic.coverImage),
                    comic: comic),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: BaseWidget.instance.setText(
                  txt: "${comic.title} ",
                  fontSize: 18,
                  fontWeight: FontWeight.w100),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (Genres value in comic.genres)
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Container(
                          // height: constraints.maxHeight / 2 - 5,
                          padding: const EdgeInsets.all(3),
                          child: Align(
                            alignment: Alignment.center,
                            child: BaseWidget.instance.setText(
                                color: const Color(0xffD8d8d8),
                                txt: value.genresName,
                                fontSize: 6,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myEventHandler(
      {required BuildContext context,
      required Widget child,
      required PageComicItem comic}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsComicScreen(id: comic.id),
          ),
        );
      },
      onLongPress: () async {
        showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: true,
          backgroundColor: AppColor.transparent,
          context: context,
          builder: (BuildContext context) {
            return ComicBottomSheet(id: comic.id);
          },
        );
      },
      child: child,
    );
  }
}
