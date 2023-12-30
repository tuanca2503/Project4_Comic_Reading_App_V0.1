import 'package:flutter/material.dart';
import 'package:project4/config/app_font_size.dart';
import 'package:project4/models/comic/filter_comic.dart';
import 'package:project4/models/genres.dart';
import 'package:project4/repositories/genres_repository.dart';
import 'package:project4/screens/category_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/widgets/app/custom_text_form_field.dart';
import 'package:project4/widgets/base_widget.dart';
import 'package:project4/widgets/comic/list_widget/list_genres_horizontal.dart';
import 'package:project4/widgets/comic/list_widget/scroll_page_widget.dart';
import 'package:project4/widgets/title_app_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  @override
  bool get wantKeepAlive => true;

  final TextEditingController _searchController = TextEditingController();
  List<Genres> _genresFilter = [];
  List<Genres>? _allGenres;
  bool _showFilterWidget = true; // if false, show result search

  @override
  void initState() {
    super.initState();
    GenresRepository.instance.getAllGenres().then((value) {
      setState(() {
        _allGenres = value;
      });
    });
  }

  void focusSearchField() {
    setState(() {
      _showFilterWidget = true;
    });
  }

  // set state
  void findByGenres() {
    setState(() {
      _showFilterWidget = false;
    });
  }

  // no setState
  void updateGenresFilter(List<Genres> genresFilter) {
    _genresFilter = genresFilter;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          _searchBox(),
          Expanded(child: _filterGenresWidget()),
        ],
      ),
    );
  }

  Widget _searchBox() {
    return Container(
      padding: AppDimension.initPaddingBody(),
      alignment: Alignment.center,
      child: CustomTextFormField(
        controller: _searchController,
        onEditingComplete: findByGenres,
        onPrefixIcon: findByGenres,
        onTap: focusSearchField,
        hintText: 'Nhập tên truyện',
        prefixIcon: BaseWidget.instance.setIcon(iconData: Icons.search),
      ),
    );
  }

  Widget _filterGenresWidget() {
    if (_allGenres == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (_showFilterWidget) {
      return CategoryScreen(
        onSelectedFilterGenres: updateGenresFilter,
        genresFilter: _genresFilter,
        allGenres: _allGenres!,
      );
    } else {
      return _listComicWidget();
    }
  }

  Widget _listComicWidget() {
    return ScrollPageWidget(
      title: const TitleAppWidget(
        title: 'Kết quả tìm kiếm',
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      filter: FilterComicType.LAST_UPDATED_DATE.name,
      mangaName: _searchController.text,
      genresId: _genresFilter.map((genres) => genres.id).toList(),
      children: [
        const TitleAppWidget(
          title: 'Tìm kiếm thể loại',
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        _genresFilter.isNotEmpty
            ? ListGenresHorizontal(
                bgColor: Theme.of(context).colorScheme.surface,
                fontSize: AppFontSize.headline3,
                genres: _genresFilter,
                height: AppDimension.baseConstraints.maxHeight * 0.05,
                textColor: Theme.of(context).colorScheme.onSurface,
        )
            : Container(),
      ],
    );
  }
}
