import 'package:project4/models/comic/comic_book.dart';

class ComicHome {
  List<ComicBook> topViewMangas;
  List<ComicBook> topLikeMangas;
  List<ComicBook> topFavouriteMangas;

  ComicHome.empty()
      : topViewMangas = List.empty(growable: false),
        topLikeMangas = List.empty(growable: false),
        topFavouriteMangas = List.empty(growable: false);

  // Constructor từ JsonMap
  ComicHome.fromJson(Map<String, dynamic> json)
      : topViewMangas = (json['topViewMangas'] as List)
            .map((itemJson) => ComicBook.fromJson(itemJson))
            .toList(),
        topLikeMangas = (json['topLikeMangas'] as List)
            .map((itemJson) => ComicBook.fromJson(itemJson))
            .toList(),
        topFavouriteMangas = (json['topFavouriteMangas'] as List)
            .map((itemJson) => ComicBook.fromJson(itemJson))
            .toList();
}
