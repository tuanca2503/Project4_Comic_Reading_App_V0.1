import 'package:flutter/material.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/models/comment/page_comment_item.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/utils/string_utils.dart';
import 'package:project4/widgets/base_widget.dart';

class ItemCommentWidget extends StatefulWidget {
  const ItemCommentWidget({Key? key, required this.comment}) : super(key: key);

  final PageCommentItem comment;

  @override
  State<ItemCommentWidget> createState() => _ItemCommentWidgetState();
}

class _ItemCommentWidgetState extends State<ItemCommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppDimension.dimension8),
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.all(Radius.circular(AppDimension.dimension8)),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppDimension.dimension8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: _notificationImageWidget()),
            const SizedBox(
              width: AppDimension.dimension8,
            ),
            Expanded(flex: 3, child: _notificationInfoWidget(context)),
          ],
        ),
      ),
    );
  }

  Widget _notificationImageWidget() {
    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: ClipRRect(
        borderRadius:BorderRadius.circular(AppDimension.dimension64),
        child: BaseWidget.instance.getAvatarWidget(),
      )
    );
  }

  Widget _notificationInfoWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                widget.comment.username,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: AppFontSize.body),
              ),
            ),
            Text(
              Helper.showTimeUpdatedComic(widget.comment.lastUpdatedDate),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: AppFontSize.label),
            ),
          ],
        ),
        Text(
          widget.comment.content,
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: AppFontSize.body),
        ),
      ],
    );
  }
}
