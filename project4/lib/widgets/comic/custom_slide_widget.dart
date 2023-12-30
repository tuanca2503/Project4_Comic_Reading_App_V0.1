import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/comic/page_comic_item.dart';
import 'package:project4/screens/comic/details_comic_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/widgets/base_widget.dart';


class CustomSlideWidget extends StatefulWidget {
  const CustomSlideWidget({Key? key, required this.comics}) : super(key: key);
  final List<PageComicItem>? comics;

  @override
  State<CustomSlideWidget> createState() => _CustomSlideWidgetState();
}

class _CustomSlideWidgetState extends State<CustomSlideWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.comics != null
        ? CarouselSlider(
            items: widget.comics!.map(
              (comic) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double widthBox = constraints.maxWidth * 0.7;
                      double center = constraints.maxWidth / 2 - (widthBox / 2);
                      return Stack(
                        children: [
                          Image.network(
                            "${Environment.apiUrl}/${comic.coverImage}",
                            fit: BoxFit.cover,
                            width: constraints.maxWidth,
                            height: constraints.maxWidth * 2,
                          ),
                          Positioned(
                            bottom: 20,
                            left: center,
                            child: SizedBox(
                              width: widthBox,
                              height: 40,
                              child: Row(
                                children: [
                                  itemButtonSlide(
                                      color: const Color(0xffD0480A),
                                      txt: "Đọc",
                                      iconData: Icons.local_library_outlined,
                                      comic: comic,
                                      showButton: 0),
                                  Expanded(flex: 1, child: Container()),
                                  itemButtonSlide(
                                      color: const Color(0xff232220),
                                      txt: "Chi tiết",
                                      iconData: Icons.info_outline,
                                      comic: comic,
                                      showButton: 1),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ).toList(),
            options: CarouselOptions(
              autoPlay: true,
              // Enable auto-play
              enlargeCenterPage: true,
              // Make the current image larger
              aspectRatio: 16 / 9,
              // Set the aspect ratio
              viewportFraction: 0.8,
              // Set the fraction of the viewport to show
              // initialPage: 4,   //// anh bat dau
              autoPlayInterval: const Duration(seconds: 5),

              height: AppDimension.baseConstraints.maxWidth *
                  1.2, // Set the height of the carousel
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }

  Widget itemButtonSlide(
      {required Color color,
      required String txt,
      required IconData iconData,
      required PageComicItem comic,
      required int showButton}) {
    return Expanded(
      flex: 5,
      child: BaseWidget.instance.handleEventNavigation(
        context: context,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: color,
          ),
          height: double.infinity,
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimension.dimension16),
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: BaseWidget.instance.setText(
                  txt: txt,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: BaseWidget.instance.setIcon(iconData: iconData),
                ),
              ),
            ],
          ),
        ),
        pageTo: DetailsComicScreen(showButton: showButton, id: comic.id),
      ),
    );
  }
}
