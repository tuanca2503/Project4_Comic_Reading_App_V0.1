import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/repositories/auth_repository.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/app_validator.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/response_helper.dart';
import 'package:project4/widgets/app/custom_button_widget.dart';
import 'package:project4/widgets/app/custom_text_form_field.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/loading_dialog.dart';
import 'package:project4/widgets/title_app_widget.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
  TextEditingController(text: "string2@gmail.com");
  final TextEditingController _codeController =
  TextEditingController();
  final TextEditingController _newPasswordController =
  TextEditingController(text: "string123aA@");
  final TextEditingController _reNewPasswordController =
  TextEditingController(text: "string123aA@");

  int? _sendEmailAfterSecond;

  @override
  void initState() {
    super.initState();
    _sendEmailTimer();
  }

  _sendEmailTimer() {
    Timer(const Duration(seconds: 1), () async {
      if (_sendEmailAfterSecond != null && _sendEmailAfterSecond! > 0) {
        setState(() {
          _sendEmailAfterSecond = _sendEmailAfterSecond! - 1;
        });
      }
    });
  }

  Future<void> _sendEmailForgotPassword() async {
    try {
      showDialog(context: context, builder: (c) {
        return const LoadingDialog(message: "Đang gửi mã",);
      });
      _sendEmailAfterSecond = 60;
      await AuthRepository.instance.forgotPassword(
          email: _emailController.text);
      if (!mounted) return;
      Helper.dialogPop(context);
    } catch (e) {
      if (!mounted) return;
      Helper.dialogPop(context);
      Helper.showErrorSnackBar(context, ResponseErrorHelper.getErrorMessage(e));
    }
  }

  Future<void> _onChangePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      showDialog(context: context, builder: (c) {
        return const LoadingDialog(message: "Đang đổi mật khẩu",);
      });
      await AuthRepository.instance.updatePasswordByCode(
        email: _emailController.text,
        code: _codeController.text,
        newPassword: _newPasswordController.text,
      );
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      Helper.dialogPop(context);
      Helper.navigatorPop(context);
      Helper.showSuccessSnackBar(context, 'Đổi mật khẩu thành công!');
    } catch (e) {
      if (!mounted) return;
      Helper.dialogPop(context);
      Helper.showErrorSnackBar(context, ResponseErrorHelper.getErrorMessage(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
            child: TitleAppWidget(title: 'Quên mật khẩu', mainAxisAlignment: MainAxisAlignment.center,),
          ),
          CustomTextFormField(
            controller: _emailController,
            label: "Email",
            hintText: 'abc@mail.com',
            prefixIcon: BaseWidget.instance.setIcon(iconData: Icons.email_outlined),
            suffixIcon: BaseWidget.instance.setIcon(iconData: Icons.send),
            onSuffixIcon: _sendEmailForgotPassword,
            validator: (value) {
              return AppValidator.emailValidator(value);
            },
          ),
          _sendEmailTime(),
          CustomTextFormField(
            controller: _codeController,
            label: "Nhập mã",
            hintText: '....',
            isEnable: _sendEmailAfterSecond != null,
            prefixIcon: BaseWidget.instance.setIcon(iconData: Icons.numbers),
            validator: (value) {
              return AppValidator.codeValidator(value);
            },
          ),
          CustomTextFormField(
            controller: _newPasswordController,
            label: "Mật khẩu",
            hintText: 'Mật khẩu',
            isEnable: _sendEmailAfterSecond != null,
            prefixIcon: BaseWidget.instance.setIcon(iconData: Icons.lock_outline),
            suffixIcon: BaseWidget.instance.setIcon(iconData: Icons.remove_red_eye_outlined),
            obscureText: true,
            validator: (value) {
              return AppValidator.passwordValidator(value);
            },
          ),
          CustomTextFormField(
            controller: _reNewPasswordController,
            label: "Nhập lại mật khẩu",
            hintText: 'Mật khẩu',
            isEnable: _sendEmailAfterSecond != null,
            prefixIcon: BaseWidget.instance.setIcon(iconData: Icons.lock_outline),
            suffixIcon: BaseWidget.instance.setIcon(iconData: Icons.remove_red_eye_outlined),
            obscureText: true,
            validator: (value) {
              return AppValidator.rePasswordValidator(_newPasswordController.text, _reNewPasswordController.text);
            },
          ),
        ],
      ),
    );
  }

  Widget _sendEmailTime() {
    if (_sendEmailAfterSecond == null) {
      return Container();
    } else if (_sendEmailAfterSecond! > 0) {
      return Text('Không nhận được Email? Gửi lại sau $_sendEmailAfterSecond giây!', style: TextStyle(color: AppColor.error, fontSize: AppFontSize.body, fontWeight: FontWeight.w500),);
    } else {
      return Text('Gửi lại Email!', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: AppFontSize.body, fontWeight: FontWeight.w500),);
    }
  }

  Widget _btnGroupWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: AppDimension.dimension16,),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: CustomButtonWidget(
                onTap: () {
                  Helper.navigatorPop(context);
                },
                text: "<",
                bgColor: AppColor.transparent,
                borderColor: Theme.of(context).colorScheme.outline,
                fontSize: AppFontSize.button,
              ),
            ),
            Expanded(
              flex: 5,
              child: CustomButtonWidget(
                onTap: _onChangePassword,
                text: "Đổi mật khẩu",
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
