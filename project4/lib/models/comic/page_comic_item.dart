import 'package:project4/models/genres.dart';

class PageComicItem {
  String id;
  String title;
  String coverImage;
  List<Genres> genres;
  int totalChapters;
  int totalRead;
  int totalLike;
  int totalFavourite;
  String? currentReadChapterName;
  String? currentReadChapterId;
  int lastUpdatedDate;

  PageComicItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        coverImage = json['coverImage'],
        genres = (json['genres'] as List)
            .map((itemJson) => Genres.fromJson(itemJson)).toList(),
        totalChapters = json['totalChapters'],
        totalRead = json['totalRead'],
        totalLike = json['totalLike'],
        totalFavourite = json['totalFavourite'],
        currentReadChapterName = json['currentReadChapterName'],
        currentReadChapterId = json['currentReadChapterId'],
        lastUpdatedDate = json['lastUpdatedDate'];
}
