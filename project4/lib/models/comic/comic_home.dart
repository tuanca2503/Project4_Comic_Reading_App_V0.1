import 'package:project4/models/comic/detail_comic.dart';

class ComicHome {
  List<DetailComic> topViewMangas;
  List<DetailComic> topLikeMangas;
  List<DetailComic> topFavouriteMangas;

  ComicHome.empty()
      : topViewMangas = List.empty(growable: false),
        topLikeMangas = List.empty(growable: false),
        topFavouriteMangas = List.empty(growable: false);

  // Constructor từ JsonMap
  ComicHome.fromJson(Map<String, dynamic> json)
      : topViewMangas = (json['topViewMangas'] as List)
            .map((itemJson) => DetailComic.fromJson(itemJson))
            .toList(),
        topLikeMangas = (json['topLikeMangas'] as List)
            .map((itemJson) => DetailComic.fromJson(itemJson))
            .toList(),
        topFavouriteMangas = (json['topFavouriteMangas'] as List)
            .map((itemJson) => DetailComic.fromJson(itemJson))
            .toList();
}
