import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/models/users/user.dart';
import 'package:project4/repositories/file_repository.dart';
import 'package:project4/repositories/user_repository.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/app_validator.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/response_helper.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/widgets/app/custom_button_widget.dart';
import 'package:project4/widgets/app/custom_text_form_field.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/loading_dialog.dart';
import 'package:project4/widgets/title_app_widget.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _usernameController;
  TextEditingController? _emailController;
  String? _avatarName;
  String? _avatarError;
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    UserRepository.instance.getUserInfo().then((User user) {
      _usernameController = TextEditingController(text: user.username);
      _emailController = TextEditingController(text: user.email);
      _avatarName = user.avatar;
      Storages.instance.setUser(user).then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  Future<void> _onUpdate() async {
    if (!_formKey.currentState!.validate()) return;
    if (_avatarName == null && imageXFile == null) {
      setState(() {
        _avatarError = 'Đây là trường bắt buộc';
      });
      return;
    }
    try {
      showDialog(
          context: context,
          builder: (c) {
            return const LoadingDialog(
              message: "Đang cập nhật",
            );
          });
      if (imageXFile != null) {
        _avatarName = await FileRepository.instance.uploadFile(imageXFile!);
      }

      await UserRepository.instance.updateUserInfo(
          username: _usernameController!.text,
          avatar: _avatarName!,
          email: _emailController!.text);
      if (!mounted) return;
      // pop loading dialog
      Helper.dialogPop(context);
      // pop user info screen
      Helper.navigatorPop(context);
      Helper.showSuccessSnackBar(context, 'Cập nhật thông tin thành công!');
    } catch (e) {
      if (!mounted) return;
      Helper.dialogPop(context);
      Helper.showErrorSnackBar(context, ResponseErrorHelper.getErrorMessage(e));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? BaseWidget.instance.loadingWidget()
          : Container(
              padding: AppDimension.initPaddingBody(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _avatarPicker(),
                  _avatarError != null
                      ? Text(
                          _avatarError!,
                          style: TextStyle(color: AppColor.error),
                        )
                      : Container(),
                  _formGroupWidget(context, _formKey),
                  _btnGroupWidget(),
                ],
              ),
            ),
    );
  }

  Widget _avatarPicker() {
    return GestureDetector(
      onTap: _getImage,
      child: CircleAvatar(
        radius: AppDimension.baseConstraints.maxHeight * 0.1,
        backgroundColor: _avatarError != null ? AppColor.error : Colors.white,
        backgroundImage: imageXFile == null
            ? null
            : FileImage(File(imageXFile!.path)) as ImageProvider<Object>?,
        child: imageXFile == null
            ? (_avatarName != null
                ? ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppDimension.dimension64),
                    child: BaseWidget.instance.getAvatarWidget(),
                  )
                : null)
            : (_avatarName != null
                ? Icon(
                    Icons.add_photo_alternate,
                    size: AppDimension.baseConstraints.maxHeight * 0.1,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : null),
      ),
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
              title: 'Cập nhật thông tin',
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
          CustomTextFormField(
            controller: _emailController!,
            label: "Email",
            hintText: 'abc@mail.com',
            prefixIcon:
                BaseWidget.instance.setIcon(iconData: Icons.email_outlined),
            isEnable: false,
            validator: (value) {
              return AppValidator.emailValidator(value);
            },
          ),
          CustomTextFormField(
            controller: _usernameController!,
            label: "Name",
            hintText: 'Nguyễn Văn A',
            prefixIcon:
                BaseWidget.instance.setIcon(iconData: Icons.account_circle),
            validator: (value) {
              return AppValidator.usernameValidator(value, 3, 255);
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
                fontSize: AppFontSize.body,
              ),
            ),
            Expanded(
              flex: 5,
              child: CustomButtonWidget(
                onTap: _onUpdate,
                text: "Cập nhật",
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
