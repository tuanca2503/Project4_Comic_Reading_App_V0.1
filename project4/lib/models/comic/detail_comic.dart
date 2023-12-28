import 'package:project4/models/comic/chapter/page_chapter_item.dart';
import 'package:project4/models/genres.dart';

class DetailComic {
  String id;
  String title;
  String author;
  String coverImage;
  String description;
  List<Genres> genres;
  List<PageChapterItem> chapters;
  String? currentReadChapterName;
  String? currentReadChapterId;
  bool isLike;
  bool isFavourite;
  int totalChapters;

  int createdDate;
  int totalFavourite;
  int totalLike;
  int totalRead;

  // Constructor từ JsonMap
  DetailComic.fromJson(Map<String, dynamic> json)
      : currentReadChapterId = json['currentReadChapterId'],
        currentReadChapterName = json['currentReadChapterName'],
        id = json['id'],
        title = json['title'],
        coverImage = json['coverImage'],
        createdDate = json['createdDate'],
        author = json['author'] ?? '',
        totalChapters = json['totalChapters'],
        totalRead = json['totalRead'],
        totalLike = json['totalLike'],
        totalFavourite = json['totalFavourite'],
        description = json['description'] ?? '',
        genres = (json['genres'] as List)
            .map((itemJson) => Genres.fromJson(itemJson))
            .toList(),
        chapters = (json['chapters'] as List)
            .map((itemJson) => PageChapterItem.fromJson(itemJson))
            .toList(),
        isLike = json['like'] ?? false,
        isFavourite = json['favourite'] ?? false;
}

class FilterSearchBox {
  final String nameFilter;
  final String apiFilter;
  String searchName;
  bool choose;

  FilterSearchBox(
      {this.nameFilter = '',
      this.apiFilter = '',
      this.choose = false,
      this.searchName = ''});

  List<FilterSearchBox> seed() {
    return [
      FilterSearchBox(nameFilter: 'Tất cả', apiFilter: 'TOP_ALL'),
      FilterSearchBox(nameFilter: 'Ngày tạo', apiFilter: 'CREATED_DATE'),
      FilterSearchBox(
          nameFilter: 'Ngày cập nhật', apiFilter: 'LAST_UPDATED_DATE'),
      FilterSearchBox(nameFilter: 'Top ngày', apiFilter: 'TOP_DAY'),
      FilterSearchBox(nameFilter: 'Top tuần', apiFilter: 'TOP_WEEK'),
      FilterSearchBox(nameFilter: 'Top tháng', apiFilter: 'TOP_MONTH'),
      FilterSearchBox(nameFilter: 'Top năm', apiFilter: 'TOP_YEAR'),
      FilterSearchBox(nameFilter: 'Yêu thích', apiFilter: 'TOP_LIKE'),
      FilterSearchBox(nameFilter: 'Lượt theo dõi', apiFilter: 'TOP_FAVOURITE'),
    ];
  }
}
