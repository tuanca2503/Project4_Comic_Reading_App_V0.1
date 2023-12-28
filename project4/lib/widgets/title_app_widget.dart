import 'package:flutter/material.dart';
import 'package:project4/utils/app_dimension.dart';

class TitleAppWidget extends StatelessWidget {
  const TitleAppWidget({Key? key, required this.title, this.crossAxisAlignment = CrossAxisAlignment.center, this.mainAxisAlignment = MainAxisAlignment.start, this.underlineWidth = 100, this.fontSize}) : super(key: key);

  final String title;
  final double? fontSize;
  final double underlineWidth;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  double? getFontSize(BuildContext context) {
    if (fontSize != null) return fontSize;
    return Theme.of(context).textTheme.headlineMedium?.fontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        const SizedBox(
          height: AppDimension.dimension16,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: getFontSize(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 3.0,
          width: underlineWidth,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(
          height: AppDimension.dimension4,
        ),
        Container(
          height: 3.0,
          width: underlineWidth * 0.75,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(
          height: AppDimension.dimension16,
        ),
      ],
    );
  }
}
