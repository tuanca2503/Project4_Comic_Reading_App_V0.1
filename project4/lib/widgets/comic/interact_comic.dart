import 'package:flutter/material.dart';
import 'package:project4/models/comic/detail_comic.dart';
import 'package:project4/repositories/interact_comic_repository.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/loading_dialog.dart';

class InteractComicWidget extends StatefulWidget {
  const InteractComicWidget({Key? key, required this.detailComic, required this.height, required this.bgColor, required this.iconColor, required this.textColor, this.borderColor}) : super(key: key);

  final DetailComic detailComic;
  final double height;
  final Color bgColor;
  final Color? borderColor;
  final Color iconColor;
  final Color textColor;

  @override
  State<InteractComicWidget> createState() => _InteractComicWidgetState();
}

class _InteractComicWidgetState extends State<InteractComicWidget> {
  bool isLogin = Storages.instance.isLogin();

  void likeOrFavourite(String action, String id) {
    if (!isLogin) return;
    showDialog(context: context, builder: (c) {
      return const LoadingDialog(message: "Đang xử lý",);
    });
    InteractComicRepository.instance
        .interactComic(action, widget.detailComic.id)
        .then((value) {
      setState(() {
        if (action == 'LIKE') {
          widget.detailComic.isLike = value;
          widget.detailComic.totalLike += (value ? 1 : -1);
        } else if (action == 'FAVOURITE') {
          widget.detailComic.isFavourite = value;
          widget.detailComic.totalFavourite += (value ? 1 : -1);
        }
      });
      Helper.dialogPop(context);
    }).catchError((Object e, StackTrace stackTrace) {
      Helper.dialogPop(context);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height * 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _interactComicWidget(
            context: context,
            text: "${widget.detailComic.totalRead} lượt đọc",
            iconData: Icons.remove_red_eye_outlined,
            color: widget.iconColor,
          ),
          const SizedBox(width: AppDimension.dimension24,),
          _interactComicWidget(
              context: context,
              text: "${widget.detailComic.totalFavourite} lượt theo dõi",
              iconData: Icons.favorite,
              color: widget.detailComic.isFavourite
                  ? Colors.redAccent
                  : widget.iconColor,
              id: widget.detailComic.id,
              action: 'FAVOURITE',
              handler: likeOrFavourite),
          const SizedBox(width: AppDimension.dimension24,),
          _interactComicWidget(
              context: context,
              text: "${widget.detailComic.totalLike} lượt thích",
              iconData: Icons.thumb_up,
              color: widget.detailComic.isLike
                  ? Colors.blueAccent
                  : widget.iconColor,
              id: widget.detailComic.id,
              action: 'LIKE',
              handler: likeOrFavourite),
        ],
      ),
    );
  }

  Widget _interactComicWidget(
      {
        required BuildContext context,
        required String text,
        required IconData iconData,
        required Color color,
        void Function(String, String)? handler,
        String? action,
        String? id,}) {
    return Expanded(
      child: SizedBox(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: GestureDetector(
                onTap: () {
                  if (!isLogin || handler == null) return;
                  handler(action!, id!);
                },
                child: Container(
                  margin:
                  const EdgeInsets.only(bottom: AppDimension.dimension8),
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppDimension.dimension8)),
                      border: widget.borderColor != null ? Border.all(
                        width: 2,
                        color: widget.borderColor!,
                      ) : null,
                      color: widget.bgColor),
                  child: BaseWidget.instance
                      .setIcon(iconData: iconData, color: color),
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 14,
                      color: widget.textColor),
                )),
          ],
        ),
      ),
    );
  }
}
