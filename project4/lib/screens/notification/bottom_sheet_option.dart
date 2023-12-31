import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/models/notification/notification_pass_data.dart';
import 'package:project4/repositories/notification_repository.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/widgets/loading_dialog.dart';

enum NotificationOption { delete, markAsRead }

class BottomSheetOption extends StatelessWidget {
  const BottomSheetOption({
    super.key,
    this.notificationId,
    this.isRead
  });

  final String? notificationId;
  final bool? isRead;

  void _onHandlerOne(BuildContext context, NotificationOption option) {
    showDialog(context: context, builder: (c) {
      return const LoadingDialog(message: "Đang xử lý");
    });
    switch (option) {
      case NotificationOption.delete:
        NotificationRepository.instance.delete(notificationId!).then((_) {
          Helper.dialogPop(context);
          Helper.navigatorPopWithMessage(context, NotificationPassData(notificationId, option));
          Helper.showSuccessSnackBar(context, 'Xóa thành công!');
        });
      case NotificationOption.markAsRead:
        NotificationRepository.instance.markAsRead(notificationId!).then((_) {
          Helper.dialogPop(context);
          Helper.navigatorPopWithMessage(context, NotificationPassData(notificationId, option));
          Helper.showSuccessSnackBar(context, 'Đánh dấu đã đọc thành công!');
        });
    }
  }

  void _onHandlerAll(BuildContext context, NotificationOption option) {
    showDialog(context: context, builder: (c) {
      return const LoadingDialog(message: "Đang xử lý");
    });
    switch (option) {
      case NotificationOption.delete:
        NotificationRepository.instance.deleteAll().then((_) {
          Helper.dialogPop(context);
          Helper.navigatorPop(context);
          Helper.navigatorPopWithMessage(context, NotificationPassData(null, option));
          Helper.showSuccessSnackBar(context, 'Xóa thành công!');
        });
      case NotificationOption.markAsRead:
        NotificationRepository.instance.markAllAsRead().then((_) {
          Helper.dialogPop(context);
          Helper.navigatorPop(context);
          Helper.navigatorPopWithMessage(context, NotificationPassData(null, option));
          Helper.showSuccessSnackBar(context, 'Đánh dấu đã đọc thành công!');
        });
    }
  }


  @override
  Widget build(BuildContext context) {
    return _bottomSheetWidget(context);
  }

  Widget _bottomSheetWidget(BuildContext context) {
    return Container(
      height: AppFontSize.headline1 * 3,
      color: Theme.of(context).colorScheme.background,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: AppDimension.initPaddingBody(bodyPaddingType: BodyPaddingType.all),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              isRead == false || notificationId == null ? _notificationOption(context: context,
                  iconData: Icons.delete,
                  iconColor: AppColor.error,
                  text: notificationId != null ? 'Xóa thông báo' : 'Xóa tất cả thông báo',
                  option: NotificationOption.delete) : Container(),
              _notificationOption(context: context,
                  iconData: Icons.mark_chat_read,
                  iconColor: AppColor.success,
                  text: notificationId != null ? 'Đánh dấu là đã đọc' : 'Đánh dấu tất cả là đã đọc',
                  option: NotificationOption.markAsRead),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notificationOption(
      {required BuildContext context, required IconData iconData, required Color iconColor, required String text, required NotificationOption option}) {
    return InkWell(
      onTap: () {
        if (notificationId != null) {
          _onHandlerOne(context, option);
        } else {
          _onHandlerAll(context, option);
        }
      },
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Icon(
              iconData, size: AppFontSize.headline1, color: iconColor,),
          ),
          Expanded(
            flex: 8,
            child: Text(
              text,
              style: TextStyle(fontSize: AppFontSize.headline3),
            ),
          ),
        ],
      ),
    );
  }
}
