import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project4/utils/util_func.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ComicBook {
  String id;
  String title;
  String coverImage;
  int createdDate;
  int lastUpdatedDate;
  int totalChapters;
  int totalRead;
  int totalLike;
  int totalFavourite;
  String? currentReadChapterName;
  String? currentReadChapterId;
  //
  List<Genre> genres;
//
  String author;
  String description;
  bool like;
  bool favourite;

///////////////////

  List<ChapterComicBook> listChapters = [];
  // List<String> listPart;
  // List<PartComicBook> partComicBook = [];

  ComicBook({
    this.currentReadChapterId,
    this.currentReadChapterName,
    this.id = "",
    this.title = "",
    this.coverImage = "",
    this.createdDate = 1702693982000,
    this.lastUpdatedDate = 0,
    this.author = "",
    this.totalChapters = 0,
    this.totalRead = 0,
    this.totalLike = 0,
    this.totalFavourite = 0,
    this.description = "",
    this.genres = const [],
    this.like = false,
    this.favourite = false,
    // this.listPart = const [],
    // this.listChapters = const [[]],
  }) {
    // setPartComicBook(part: listPart, chapter: listChapters);
  }

  // Constructor từ JsonMap
  ComicBook.fromJson(Map<String, dynamic> json)
      : currentReadChapterId = json['currentReadChapterId'],
        currentReadChapterName = json['currentReadChapterName'],
        id = json['id'],
        title = json['title'],
        coverImage = json['coverImage'].toString().replaceAll('-/', '/'),
        createdDate = json['createdDate'],
        lastUpdatedDate = json['lastUpdatedDate'],
        author = json['author'] ?? '',
        totalChapters = json['totalChapters'],
        totalRead = json['totalRead'],
        totalLike = json['totalLike'],
        totalFavourite = json['totalFavourite'],
        description = json['description'] ?? '',
        genres = (json['genres'] as List)
            .map((itemJson) => Genre.fromJson(itemJson))
            .toList(),
        like = json['like'] ?? false,
        favourite = json['favourite'] ?? false;

  ///////
  List<ComicBook> getAllDataFromJson({required List<dynamic> jsons}) {
    List<ComicBook> datas = [];

    for (var json in jsons) {
      datas.add(
        ComicBook(
          id: json['id'],
          title: json['title'],
          // title: utf8.decode(latin1.encode(json['title'])),
          coverImage: json['coverImage'].toString().replaceAll('-/', '/'),
          createdDate:
              DateTime.fromMillisecondsSinceEpoch(json['createdDate']).year,
          lastUpdatedDate: json['lastUpdatedDate'],
          genres: Genre().getAllDataFromJson(jsons: json['genres']),
          totalChapters: json['totalChapters'],
          totalRead: json['totalRead'],
          totalLike: json['totalLike'],
          totalFavourite: json['totalFavourite'],
          currentReadChapterName: json['currentReadChapterName'],
          currentReadChapterId: json['currentReadChapterId'],
        ),
      );
    }
    return datas;
  }

  void setDetailsDataFromJson({required Map<String, dynamic> json}) {
    // author = utf8.decode(latin1.encode(json['author']));
    // description = utf8.decode(latin1.encode(json['description']));
    author = json['author'];
    description = json['description'];
    currentReadChapterName = json['currentReadChapterName'];
    currentReadChapterId = json['currentReadChapterId'];

    favourite = json['favourite'];
    like = json['like'];

    //
    // listPart = [json['part'] ?? 'Phan 1'];
    // print(listPart);

    listChapters =
        ChapterComicBook().setListChapterFormJson(jsons: json['chapters']);

    // List<ChapterComicBook>

    //
    // listChapters = [
    //   List.generate(json['chapters'], ( chapterIndex) {
    //     print(chapterIndex);
    //     return ChapterComicBook();
    //   }),
    // ];

    // listChapters = [[]]
  }

  // void setPartComicBook(
  //     {required List<String> part,
  //     required List<List<ChapterComicBook>> chapter}) {
  //   /////
  //   ///////////// chap = [[]]
  //   int i = 0;
  //   if (part.length == chapter.length) {
  //     for (var valuePart in part) {
  //       partComicBook
  //           .add(PartComicBook(partName: valuePart, chapter: chapter[i]));
  //       i++;
  //     }
  //   } else {
  //     partComicBook.add(PartComicBook(
  //         partName: "error part or chapter not equal", chapter: []));
  //   }
  // }

  // int getSumAllChapInPart() {
  //   int sum = 0;
  //   for (var value in partComicBook) {
  //     sum += value.chapter.length;
  //   }
  //   return sum;
  // }

  // List<PartComicBook> getPartComicBook() {
  //   return partComicBook;
  // }

  List<ComicBook> Seed() {
//////////////////////
    List<ComicBook> comicBooks = List.generate(
      7,
      (index) => ComicBook(
        id: 'CB${Random().nextInt(500) + 20}-$index',
        title: 'Comic Name $index ',
        author: 'Author $index ',
        createdDate: Random().nextInt(25) + 1999,
        description:
            'The story revolves around the life of a young girl named Hương. Born and raised in a small village in Vietnam, Hương dreams of exploring the world beyond her humble beginnings. However, her life takes a dramatic turn when her family falls into financial hardship, forcing her to put her dreams on hold.Despite the challenges, Hương remains resilient. She takes on various jobs to support her family, all the while nurturing her dream of traveling. Her determination and hard work eventually pay off when she receives a scholarship to study abroad.',
        coverImage: 'c$index.jpg',
        genres: Genre().seed(),
      ),
    );

    return comicBooks;
  }

  //////////////////////////////
  QrImageView toQrImage({required Color color, required double size}) {
    String json = '{"id": "$id"}';

    return QrImageView(
      eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square, color: color),
      dataModuleStyle: QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.circle, color: color),
      data: json,
      version: QrVersions.auto,
      size: size,
      padding: EdgeInsets.zero,
    );
  }
}

class Genre {
  String id;
  String genresName;
  Genre({this.id = '', this.genresName = ''});

  // Constructor từ JsonMap
  Genre.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        genresName = json['genresName'];
  List<Genre> getAllDataFromJson({required List<dynamic> jsons}) {
    List<Genre> datas = [];
    for (var json in jsons) {
      datas.add(
        Genre(
          id: json['id'],
          // genresName: json['genresName'],
          genresName: utf8.decode(latin1.encode(json['genresName'])),
        ),
      );
    }
    return datas;
  }

  List<Genre> seed() {
    return List.generate(
      Random().nextInt(8) + 3,
      (index) => Genre(
        id: "MTVC$index",
        genresName: [
          'Action',
          'Adventure',
          'Comedy',
          'Drama',
          'Fantasy',
          'Shounen',
          'Supernatured',
          'Seinen',
          'Comedy',
          'Romance',
        ][Random().nextInt(10)],
      ),
    );
  }
}

///
class ChapterComicBook {
  String id;
  String name;
  String lastUpdatedDate;
  List<String> images;

  ChapterComicBook(
      {this.name = '',
      this.lastUpdatedDate = '0',
      this.id = '',
      this.images = const []});
  ChapterComicBook setChapterFromJson({required Map<String, dynamic> json}) {
    return ChapterComicBook(
        id: json['id'],
        name: json['name'],
        lastUpdatedDate: formatDateFromTs(json['lastUpdatedDate']));
  }

  List<ChapterComicBook> setListChapterFormJson(
      {required List<dynamic> jsons}) {
    List<ChapterComicBook> datas = [];

    for (var json in jsons) {
      datas.add(ChapterComicBook().setChapterFromJson(json: json));
    }
    return datas;
  }

  void setDetailsChapter({required Map<String, dynamic> json}) {
    // images.add('1');
    // print(images );
    images = [];
    for (var value in json['images']) {
      images.add(value);
    }
  }
}

class FillterSearchBox {
  final String nameFillter;
  final String apiFillter;
  String searchName;
  bool choose;

  FillterSearchBox(
      {this.nameFillter = '',
      this.apiFillter = '',
      this.choose = false,
      this.searchName = ''});

  List<FillterSearchBox> seed() {
    return [
      FillterSearchBox(nameFillter: 'Tất cả', apiFillter: 'TOP_ALL'),
      FillterSearchBox(nameFillter: 'Ngày tạo', apiFillter: 'CREATED_DATE'),
      FillterSearchBox(
          nameFillter: 'Ngày cập nhật', apiFillter: 'LAST_UPDATED_DATE'),
      FillterSearchBox(nameFillter: 'Top ngày', apiFillter: 'TOP_DAY'),
      FillterSearchBox(nameFillter: 'Top tuần', apiFillter: 'TOP_WEEK'),
      FillterSearchBox(nameFillter: 'Top tháng', apiFillter: 'TOP_MONTH'),
      FillterSearchBox(nameFillter: 'Top năm', apiFillter: 'TOP_YEAR'),
      FillterSearchBox(nameFillter: 'Yêu thích', apiFillter: 'TOP_LIKE'),
      FillterSearchBox(
          nameFillter: 'Lượt theo dõi', apiFillter: 'TOP_FAVOURITE'),
    ];
  }
}
