import 'package:flutter/material.dart';
import 'package:project4/utils/app_dimension.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    Key? key,
    required this.onTap,
    required this.text,
    this.width = double.infinity,
    this.height,
    this.bgColor,
    this.borderColor,
    this.textColor,
    this.fontSize,
  }) : super(key: key);

  final void Function()? onTap;
  final String text;
  final double width;
  final double? height;
  final Color? bgColor;
  final Color? borderColor;
  final Color? textColor;
  final double? fontSize;

  double getHeight() {
    return height != null
        ? height!
        : AppDimension.baseConstraints.maxHeight * 0.08;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: getHeight(),
      padding: const EdgeInsets.all(AppDimension.dimension8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: borderColor != null ? Border.all(
              width: 2,
              color: borderColor!,
            ) : null,
            color: bgColor,
            borderRadius: BorderRadius.circular(AppDimension.radius12),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
