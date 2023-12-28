enum FilterComicType {
  LAST_UPDATED_DATE('Ngày cập nhật'),
  CREATED_DATE('Ngày đăng'),
  TOP_ALL('Top đọc'),
  TOP_DAY('Top đọc ngày'),
  TOP_WEEK('Top đọc tuần'),
  TOP_MONTH('Top đọc tháng'),
  TOP_YEAR('Top đọc năm'),
  TOP_LIKE('Top yêu thích'),
  TOP_FAVOURITE('Top theo dõi');

  final String value;

  const FilterComicType(this.value);

  factory FilterComicType.fromKey(String key) {
    return values.firstWhere((e) => e.name == key);
  }
}

void main() {
  for (FilterComicType comicType in FilterComicType.values) {
    print(
        'comicType.name = ${comicType.name}, comicType.value = ${comicType.value}');
  }
}

class FilterComic {
  FilterComic._();

  static Map<FilterComicType, String> getAllFilterComic() {
    return {
      FilterComicType.TOP_ALL: 'Top đọc',
      FilterComicType.TOP_DAY: 'Top đọc ngày',
      FilterComicType.TOP_WEEK: 'Top đọc tuần',
      FilterComicType.TOP_MONTH: 'Top đọc tháng',
      FilterComicType.TOP_YEAR: 'Top đọc năm',
      FilterComicType.TOP_LIKE: 'Top yêu thích',
      FilterComicType.TOP_FAVOURITE: 'Top theo dõi',
      FilterComicType.CREATED_DATE: 'Ngày đăng',
      FilterComicType.LAST_UPDATED_DATE: 'Ngày cập nhật',
    };
  }
}
