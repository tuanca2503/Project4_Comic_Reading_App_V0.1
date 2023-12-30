import 'package:flutter/material.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/main.dart';
import 'package:project4/models/comic/filter_comic.dart';
import 'package:project4/screens/auth/login_screen.dart';
import 'package:project4/screens/auth/signup_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/widgets/app/custom_button_widget.dart';
import 'package:project4/widgets/comic/list_widget/scroll_page_widget.dart';
import 'package:project4/widgets/title_app_widget.dart';
import 'package:provider/provider.dart';


class FollowScreen extends StatefulWidget {
  const FollowScreen({super.key});

  @override
  State<FollowScreen> createState() => _RankFollowScreen();
}

class _RankFollowScreen extends State<FollowScreen>
    with AutomaticKeepAliveClientMixin<FollowScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Consumer<ScreenProvider>(builder: (context, provider, child) {
        return !Storages.instance.isLogin()
            ? screenNonUser()
            : screenListComic();
      }),
    );
  }

  Widget screenListComic() {
    return ScrollPageWidget(
      filter: FilterComicType.LAST_UPDATED_DATE.value,
      title: const TitleAppWidget(
        title: 'Danh sách theo dõi',
        // crossAxisAlignment: CrossAxisAlignment.start,
      ),
      queryType: QueryType.favourite,
    );
  }

  Widget screenNonUser() {
    return Container(
      height: double.infinity,
      padding: AppDimension.initPaddingBody(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtonWidget(
              text: 'Đăng nhập',
              bgColor: Theme.of(context).colorScheme.primary,
              textColor: Theme.of(context).colorScheme.onPrimary,
              width: AppDimension.baseConstraints.maxWidth * 0.6,
              onTap: () {
                Helper.navigatorPush(
                    context: context,
                    screen: const LoginScreen(
                      loginTo: LoginTo.pop,
                    ));
              }),
          Container(
            padding: const EdgeInsets.all(AppDimension.dimension8),
            alignment: Alignment.center,
            child: Text(
              'hoặc',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: AppFontSize.label),
            ),
          ),
          CustomButtonWidget(
            text: 'Đăng ký',
            bgColor: Theme.of(context).colorScheme.secondary,
            textColor: Theme.of(context).colorScheme.onSecondary,
            width: AppDimension.baseConstraints.maxWidth * 0.6,
            onTap: () {
              Helper.navigatorPush(
                  context: context, screen: const SignUpScreen());
            },
          ),
        ],
      ),
    );
  }
}
