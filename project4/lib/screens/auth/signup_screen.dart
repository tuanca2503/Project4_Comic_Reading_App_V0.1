import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/repositories/auth_repository.dart';
import 'package:project4/screens/auth/login_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/widgets/custom/custom_button_widget.dart';
import 'package:project4/widgets/title_app_widget.dart';

import '../../utils/app_validator.dart';
import '../../utils/helper.dart';
import '../../utils/response_helper.dart';
import '../../widgets/base_widget.dart';
import '../../widgets/custom/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "string2@gmail.com");
  final TextEditingController _usernameController =
      TextEditingController(text: "string");
  final TextEditingController _passwordController =
      TextEditingController(text: "string123aA@");
  final TextEditingController _rePasswordController =
      TextEditingController(text: "string123aA@");

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await AuthRepository.instance.registerUser(
          email: _emailController.text,
          password: _passwordController.text,
          userName: _usernameController.text);
      if (!mounted) return;
      Helper.navigatorPush(
          context: context, screen: const LoginScreen(), isReplace: true);
      Helper.showSuccessSnackBar(context, "Đăng ký thành công");
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
        child: SingleChildScrollView(
          child: Container(
            padding: AppDimension.initPaddingBody(),
            child: Column(
              children: [
                _logoWidget(),
                _formGroupWidget(context, _formKey),
                _btnGroupWidget(),
              ],
            ),
          ),
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
            child: TitleAppWidget(title: 'Đăng ký', mainAxisAlignment: MainAxisAlignment.center,),
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
            controller: _usernameController,
            label: "Name",
            hintText: 'Nguyễn Văn A',
            prefixIcon: BaseWidget.instance.setIcon(iconData: Icons.account_circle),
            validator: (value) {
              return AppValidator.usernameValidator(value, 3, 255);
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
          CustomTextFormField(
            controller: _rePasswordController,
            label: "Nhập lại mật khẩu",
            hintText: 'Nhập lại mật khẩu',
            prefixIcon: BaseWidget.instance.setIcon(iconData: Icons.lock_outline),
            suffixIcon: BaseWidget.instance.setIcon(iconData: Icons.remove_red_eye_outlined),
            obscureText: true,
            validator: (value) {
              return AppValidator.rePasswordValidator(
                  _passwordController.text, _rePasswordController.text);
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
        const SizedBox(height: AppDimension.dimension32,),
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
                onTap: _signUp,
                text: "Đăng ký",
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
