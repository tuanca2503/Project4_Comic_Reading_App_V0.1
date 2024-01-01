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

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController =
      TextEditingController();
  final TextEditingController _reNewPasswordController =
      TextEditingController();

  Future<void> _onChangePassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      showDialog(
          context: context,
          builder: (c) {
            return const LoadingDialog(
              message: "Đang đổi mật khẩu",
            );
          });
      await AuthRepository.instance.updatePassword(
        oldPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
      );
      if (!mounted) return;
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
            child: TitleAppWidget(
              title: 'Đổi mật khẩu',
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          CustomTextFormField(
            controller: _oldPasswordController,
            label: "Mật khẩu cũ",
            hintText: 'Mật khẩu',
            prefixIcon:
                BaseWidget.instance.setIcon(iconData: Icons.lock_outline),
            suffixIcon: BaseWidget.instance
                .setIcon(iconData: Icons.remove_red_eye_outlined),
            obscureText: true,
            validator: (value) {
              return AppValidator.passwordValidator(value);
            },
          ),
          CustomTextFormField(
            controller: _newPasswordController,
            label: "Mật khẩu mới",
            hintText: 'Mật khẩu',
            prefixIcon:
                BaseWidget.instance.setIcon(iconData: Icons.lock_outline),
            suffixIcon: BaseWidget.instance
                .setIcon(iconData: Icons.remove_red_eye_outlined),
            obscureText: true,
            validator: (value) {
              return AppValidator.passwordValidator(value);
            },
          ),
          CustomTextFormField(
            controller: _reNewPasswordController,
            label: "Nhập lại mật khẩu",
            hintText: 'Mật khẩu',
            prefixIcon:
                BaseWidget.instance.setIcon(iconData: Icons.lock_outline),
            suffixIcon: BaseWidget.instance
                .setIcon(iconData: Icons.remove_red_eye_outlined),
            obscureText: true,
            validator: (value) {
              return AppValidator.rePasswordValidator(
                  _newPasswordController.text, _reNewPasswordController.text);
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
        const SizedBox(
          height: AppDimension.dimension64,
        ),
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
