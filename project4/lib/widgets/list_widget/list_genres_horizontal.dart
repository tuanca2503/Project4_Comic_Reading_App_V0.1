import 'package:flutter/material.dart';
import 'package:project4/models/genres.dart';
import 'package:project4/utils/app_dimension.dart';

class ListGenresHorizontal extends StatelessWidget {
  const ListGenresHorizontal({
    Key? key,
    required this.genres,
    required this.height,
    required this.fontSize,
    required this.bgColor,
    required this.textColor,
  }) : super(key: key);

  final List<Genres> genres;
  final double height;
  final double? fontSize;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return FittedBox(
            fit: BoxFit.cover,
            child: Container(
              color: bgColor,
              padding: const EdgeInsets.all(AppDimension.dimension8),
              margin: const EdgeInsets.only(right: AppDimension.dimension8),
              child: Align(
                alignment: Alignment.center,
                child: Text(genres[index].genresName, style: TextStyle(fontSize: fontSize, color: textColor),),
              ),
            ),
          );
        },
      ),
    );
  }
}
