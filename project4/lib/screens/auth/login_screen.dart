import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/repositories/auth_repository.dart';
import 'package:project4/screens/main_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/app_validator.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/response_helper.dart';
import 'package:project4/widgets/custom/custom_button_widget.dart';
import 'package:project4/widgets/custom/custom_text_form_field.dart';
import 'package:project4/widgets/title_app_widget.dart';

import '../../widgets/base_widget.dart';

enum LoginTo { home, pop }
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.loginTo = LoginTo.home}) : super(key: key);
  
  final LoginTo loginTo;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "string2@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "string123aA@");

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await AuthRepository.instance.loginUser(
          email: _emailController.text, password: _passwordController.text);
      if (!mounted) return;
      switch (widget.loginTo) {
        case LoginTo.home:
          Helper.navigatorPush(context: context, screen: const MainScreen());
        case LoginTo.pop:
          Helper.navigatorPop(context);
      }
    } catch (e) {
      if (!mounted) return;
      Helper.showErrorSnackBar(context, ResponseErrorHelper.getErrorMessage(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
          minHeight: AppDimension.baseConstraints.maxHeight,
        ),
        padding: AppDimension.initPaddingBody(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surfaceVariant,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _logoWidget(),
            _formGroupWidget(context, _formKey),
            _btnGroupWidget(),
          ],
        ),
      ),
    );
  }

  Widget _logoWidget() {
    return Column(
      children: [
        const SizedBox(
          height: AppDimension.dimension32,
        ),
        SizedBox(
          width: double.infinity,
          child: BaseWidget.instance.getLogoApp(context: context),
        ),
      ],
    );
  }

  Widget _formGroupWidget(BuildContext context, GlobalKey key) {
    return Form(
      key: key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: TitleAppWidget(title: 'Đăng nhập', mainAxisAlignment: MainAxisAlignment.center,),
          ),
          CustomTextFormField(
            controller: _emailController,
            label: "Email",
            hintText: 'abc@mail.com',
            prefixIcon: BaseWidget.instance.setIcon(iconData: Icons.email_outlined),
            validator: (value) {
              return AppValidator.emailValidator(value);
            },
          ),
          CustomTextFormField(
            controller: _passwordController,
            label: "Mật khẩu",
            hintText: 'Mật khẩu',
            prefixIcon: BaseWidget.instance.setIcon(iconData: Icons.lock_outline),
            suffixIcon: BaseWidget.instance.setIcon(iconData: Icons.remove_red_eye_outlined),
            obscureText: true,
            validator: (value) {
              return AppValidator.passwordValidator(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _btnGroupWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: AppDimension.dimension64,),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: CustomButtonWidget(
                onTap: () {
                  Helper.navigatorPop(context);
                },
                text: "<",
                bgColor: Colors.transparent,
                borderColor: Theme.of(context).colorScheme.outline,
                fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
              ),
            ),
            Expanded(
              flex: 5,
              child: CustomButtonWidget(
                onTap: _onLogin,
                text: "Đăng nhập",
                bgColor: Theme.of(context).colorScheme.primary,
                textColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
