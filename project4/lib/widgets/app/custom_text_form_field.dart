import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/utils/app_dimension.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.label,
    required this.hintText,
    this.inputFormatters,
    this.validator,
    this.suffixIcon,
    this.onSuffixIcon,
    this.onTap,
    this.onPrefixIcon,
    this.onEditingComplete,
    this.height,
    this.obscureText,
    this.isEnable,
    required this.prefixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function()? onSuffixIcon;
  final void Function()? onTap; // click in textField (focus)
  final void Function()? onPrefixIcon;
  final void Function()? onEditingComplete;
  final Widget prefixIcon;
  final double? height;
  final bool? isEnable;
  final bool? obscureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool? obscureText;
  late double height;
  Widget? suffixIcon;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    height = widget.height != null
        ? widget.height!
        : AppDimension.baseConstraints.maxHeight * 0.06;

    if (widget.suffixIcon != null) {
      if (obscureText != null) {
        suffixIcon = GestureDetector(
          onTap: widget.obscureText != null
              ? () {
                  setState(() {
                    obscureText = !obscureText!;
                  });
                }
              : widget.onSuffixIcon,
          child: widget.suffixIcon,
        );
      } else if (widget.onSuffixIcon != null) {
        suffixIcon = GestureDetector(
          onTap: widget.onSuffixIcon,
          child: widget.suffixIcon,
        );
      }
    } else {
      suffixIcon = widget.suffixIcon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelWidget(),
        SizedBox(
          height: height,
          child: TextFormField(
            controller: widget.controller,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            enabled: widget.isEnable,
            onEditingComplete: widget.onEditingComplete,
            obscureText: obscureText != null ? obscureText! : false,
            onTap: widget.onTap,
            textAlignVertical: TextAlignVertical.center, // enabled false
            decoration: InputDecoration(
              isCollapsed: true, // if use prefixIcon + enabled false
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: AppDimension.dimension16),
              filled: true,
              errorMaxLines: 2,
              hintText: widget.hintText,
              suffixIcon: suffixIcon,
              prefixIcon: GestureDetector(
                onTap: widget.onPrefixIcon,
                child: widget.prefixIcon,
              ),
            ),
            style: TextStyle(
              fontSize: AppFontSize.bodySmall,
            ),
          ),
        ),
        const SizedBox(
          height: AppDimension.dimension16,
        ),
      ],
    );
  }

  Widget _labelWidget() {
    return widget.label != null
        ? Column(
            children: [
              Text(
                widget.label!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: AppFontSize.body),
              ),
              const SizedBox(
                height: AppDimension.dimension8,
              ),
            ],
          )
        : Container();
  }
}
