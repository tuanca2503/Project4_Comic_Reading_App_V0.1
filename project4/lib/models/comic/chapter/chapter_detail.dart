import 'dart:convert';

class ChapterDetail {
  String id;
  String chapterName;
  String mangaName;
  int createdDate;
  List<String> images;

  ChapterDetail.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        chapterName = json['chapterName'],
        mangaName = json['mangaName'],
        createdDate = json['createdDate'],
        images = List<String>.from(json['images']);
}
