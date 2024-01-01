import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/models/notification/notification_page_item.dart';
import 'package:project4/repositories/notification_repository.dart';
import 'package:project4/screens/comic/details_comic_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/custom_date_utils.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/loading_dialog.dart';

class ItemNotificationWidget extends StatefulWidget {
  const ItemNotificationWidget({Key? key, required this.notification})
      : super(key: key);

  final NotificationPageItem notification;

  @override
  State<ItemNotificationWidget> createState() => _ItemNotificationWidgetState();
}

class _ItemNotificationWidgetState extends State<ItemNotificationWidget> {
  void _onPress(BuildContext context) {
    showDialog(
        context: context,
        builder: (c) {
          return const LoadingDialog(message: "Đang xử lý");
        });
    NotificationRepository.instance
        .markAsRead(widget.notification.id)
        .then((_) {
      setState(() {
        widget.notification.isRead = true;
      });
      Helper.dialogPop(context);
      Helper.navigatorPush(
          context: context,
          screen: DetailsComicScreen(id: widget.notification.comicId));
    });
  }

  void _onMarkAsRead() {
    showDialog(
        context: context,
        builder: (c) {
          return const LoadingDialog(message: "Đang xử lý");
        });
    NotificationRepository.instance
        .markAsRead(widget.notification.id)
        .then((_) {
      setState(() {
        widget.notification.isRead = true;
      });
      Helper.dialogPop(context);
      Helper.showSuccessSnackBar(context, 'Đánh dấu đã đọc thành công!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppFontSize.headline1 * 4.5,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: AppDimension.dimension8),
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.all(Radius.circular(AppDimension.dimension8)),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Container(
        color: widget.notification.isRead
            ? AppColor.transparent
            : Theme.of(context).colorScheme.surfaceVariant,
        child: GestureDetector(
          onTap: () {
            _onPress(context);
          },
          child: Container(
            padding: const EdgeInsets.all(AppDimension.dimension8),
            child: Row(
              children: [
                Expanded(flex: 1, child: _notificationImageWidget()),
                const SizedBox(
                  width: AppDimension.dimension8,
                ),
                Expanded(flex: 3, child: _notificationInfoWidget(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _notificationImageWidget() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimension.dimension8),
        ),
      ),
      child: BaseWidget.instance
          .setImageNetwork(link: widget.notification.coverImage),
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
                'Chương mới',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.headline3),
              ),
            ),
            widget.notification.isRead != true
                ? GestureDetector(
                    onTap: _onMarkAsRead,
                    child: Icon(
                      Icons.circle,
                      color: AppColor.success,
                      size: AppFontSize.body,
                    ))
                : Container(),
          ],
        ),
        RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: 'Truyện ',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: AppFontSize.label,
                  color: Theme.of(context).colorScheme.onSurface),
            ),
            TextSpan(
              text: widget.notification.comicName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppFontSize.bodySmall,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            TextSpan(
              text: ' đã có chương mới. Click để xem chi tiết!',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: AppFontSize.label,
                  color: Theme.of(context).colorScheme.onSurface),
            ),
          ]),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            CustomDateUtils.formatDateFromTs(widget.notification.createdDate),
            // has a new chapter ...
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: AppFontSize.label),
          ),
        ),
      ],
    );
  }
}
