import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/screens/setting/auth/login_screen.dart';
import 'package:project4/screens/setting/auth/signup_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/widgets/app/custom_app_bar.dart';
import 'package:project4/widgets/app/custom_button_widget.dart';
import 'package:project4/widgets/base_widget.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final double _heightScreen = AppDimension.baseConstraints.maxHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(selectedAppBar: AppBarEnum.back),
      body: Stack(
        children: [
          // back button
          _backgroundWidget(),
          _formContainerWidget(),
        ],
      ),
    );
  }

  Widget _backgroundWidget() {
    return Positioned.fill(
      child: FittedBox(
        fit: BoxFit.cover,
        child: BaseWidget.instance.getBackground(context: context),
      ),
    );
  }

  Widget _formContainerWidget() {
    return Positioned(
        bottom: 0,
        child: Container(
          width: AppDimension.baseConstraints.maxWidth,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppDimension.radius24),
              topRight: Radius.circular(AppDimension.radius24),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(AppDimension.dimension16),
            color: Theme.of(context).colorScheme.surface,
            child: Column(children: [
              _formLogoWidget(),
              CustomButtonWidget(
                onTap: () {
                  Helper.navigatorPush(
                      context: context, screen: const LoginScreen());
                },
                bgColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
                text: "Đăng nhập với email",
                fontSize: AppFontSize.button,
              ),
              CustomButtonWidget(
                onTap: () {
                  Helper.navigatorPush(
                      context: context, screen: const SignUpScreen());
                },
                bgColor: AppColor.transparent,
                borderColor: Theme.of(context).colorScheme.onSurface,
                textColor: Theme.of(context).colorScheme.onTertiary,
                text: "Tạo tài khoản",
                fontSize: AppFontSize.button,
              ),
              _formLoginOAuthWidget(),
              _footerWidget(),
            ]),
          ),
        ));
  }

  Widget _formLogoWidget() {
    return SizedBox(
      width: double.infinity,
      child: BaseWidget.instance.getLogoApp(context: context),
    );
  }

  Widget _formLoginOAuthWidget() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: _heightScreen * 0.06,
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 1,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimension.dimension8,
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                  child: Text(
                    'Hoặc đăng nhập bằng',
                    style: TextStyle(
                      fontSize: AppFontSize.label,
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: _heightScreen * 0.1,
          child: Row(
            children: [
              _loginOAuthIconWidget('logo_google.png'),
              _loginOAuthIconWidget('logo_facebook.png'),
              _loginOAuthIconWidget('logo_apple.png'),
              _loginOAuthIconWidget('logo_twitter.png'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _loginOAuthIconWidget(String image) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.dimension12),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.surfaceVariant,
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.outline,
            ),
            // borderRadius: BorderRadius.circular(AppDimension.dimension8),
          ),
          child: BaseWidget.instance
              .setImageAssetScale(link: image, scale: 0.7, fit: BoxFit.contain),
        ),
      ),
    );
  }

  Widget _footerWidget() {
    return SizedBox(
      width: double.infinity,
      height: _heightScreen * 0.05,
      child: Center(
        child: Text(
          '@ 2023 Comic Reading | v1.0.157',
          style: TextStyle(
            fontSize: AppFontSize.labelSmall,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
