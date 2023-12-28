import 'package:flutter/material.dart';
import 'package:project4/config/app_color.dart';
import 'package:project4/models/genres.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/title_app_widget.dart';

import '../utils/app_dimension.dart';

class CategoryScreen extends StatefulWidget {
  @override
  const CategoryScreen({
    super.key,
    required this.onSelectedFilterGenres,
    required this.genresFilter,
    required this.allGenres,
  });

  final void Function(List<Genres> genresFilter) onSelectedFilterGenres;
  final List<Genres> genresFilter;
  final List<Genres> allGenres;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with AutomaticKeepAliveClientMixin<CategoryScreen> {
  late List<Genres> _genres;
  final ScrollController _scrollController = ScrollController();
  late final List<Genres> _genresFilter;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _genresFilter = widget.genresFilter;
    setState(() {
      _genres = widget.allGenres;
    });
  }

  void updateGenresFilter(Genres genres) {
    setState(() {
      if (_genresFilter.contains(genres)) {
        _genresFilter.remove(genres);
      } else {
        _genresFilter.add(genres);
      }
    });
    widget.onSelectedFilterGenres(_genresFilter);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _listGenresWidget();
  }

  Widget _listGenresWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: AppDimension.initPaddingBody(),
        child: Column(
          children: [
            const TitleAppWidget(
              title: 'Danh sách thể loại',
              // crossAxisAlignment: CrossAxisAlignment.start,
            ),
            GridView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: _genres.length,
              itemBuilder: (_, index) {
                return _categoryItemWidget(
                  context: context,
                  genres: _genres[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryItemWidget({
    required BuildContext context,
    required Genres genres,
  }) {
    return GestureDetector(
      onTap: () {
        updateGenresFilter(genres);
      },
      child: Padding(
        padding: const EdgeInsets.all(AppDimension.dimension8),
        child: Container(
          height: double.infinity,
          color: Theme.of(context).colorScheme.surface,
          child: Stack(
            children: [
              Positioned.fill(
                child: BaseWidget.instance.setImageNetwork(
                  link: genres.genresImage!,
                ),
              ),
              // overlay
              Container(
                decoration: BoxDecoration(
                  color: _genresFilter.contains(genres) ? AppColor.overlayActive : AppColor.overlay,
                  border: _genresFilter.contains(genres)
                      ? Border.all(
                          width: 3,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                ),
                width: double.infinity,
                height: double.infinity,
              ),
              Center(
                child: Text(
                  genres.genresName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColor.onOverlay,
                  ),
                  maxLines: 3,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
