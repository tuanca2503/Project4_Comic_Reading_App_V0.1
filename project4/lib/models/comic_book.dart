import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project4/models/chapter_comic_book.dart';
import 'package:project4/models/part_comic_book.dart';
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
  int? currentReadChapterId;
  //
  List<Genre> genres;
//
  String author;
  String description;
  bool like;
  bool favourite;

///////////////////

  final List<List<ChapterComicBook>> listChapters;
  final List<String> listPart;
  List<PartComicBook> partComicBook = [];

  ComicBook({
    this.currentReadChapterId,
    this.currentReadChapterName,
    this.id = "",
    this.title = "",
    this.coverImage = "c4.jpg",
    this.createdDate = 1999,
    this.lastUpdatedDate = 0,
    this.author = "Unknow",
    this.totalChapters = 0,
    this.totalRead = 0,
    this.totalLike = 0,
    this.totalFavourite = 0,
    this.description = "",
    this.genres = const [],
    this.like = false,
    this.favourite = false,
    this.listPart = const [],
    this.listChapters = const [[]],
  }) {
    setPartComicBook(part: listPart, chapter: listChapters);
  }
  ///////
  List<ComicBook> getAllDataFromJson({required List<dynamic> jsons}) {
    List<ComicBook> datas = [];
    for (var json in jsons) {
      datas.add(
        ComicBook(
          id: json['id'],
          title: json['title'],
          coverImage: json['coverImage'],
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

  void getDetailsDataFromJson({required Map<String, dynamic> json}) {
    author = json['author'];
    description = json['description'];
    currentReadChapterName = json['currentReadChapterName'];
    currentReadChapterId = json['currentReadChapterId'];

    favourite = json['favourite'];
    like = json['like'];
  }

  void setPartComicBook(
      {required List<String> part,
      required List<List<ChapterComicBook>> chapter}) {
    /////
    ///////////// chap = [[]]
    int i = 0;
    if (part.length == chapter.length) {
      for (var valuePart in part) {
        partComicBook
            .add(PartComicBook(partName: valuePart, chapter: chapter[i]));
        i++;
      }
    } else {
      partComicBook.add(PartComicBook(
          partName: "error part or chapter not equal", chapter: []));
    }
  }

  int getSumAllChapInPart() {
    int sum = 0;
    for (var value in partComicBook) {
      sum += value.chapter.length;
    }
    return sum;
  }

  List<PartComicBook> getPartComicBook() {
    return partComicBook;
  }

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
        listPart: ["Phần 1"],
        listChapters: [
          List.generate(
              Random().nextInt(20) + 5,
              (chapterIndex) => ChapterComicBook(
                  chapterName: 'Chương ${chapterIndex + 1}',
                  chapterDate:
                      '${Random().nextInt(31)}-${Random().nextInt(12)}-${Random().nextInt(25) + 1999}'))
        ],
      ),
    );

//////test model
    comicBooks.addAll([
      //error
      ComicBook(
        listPart: ["p1", "p2"],
        listChapters: [
          [ChapterComicBook(chapterName: "c1", chapterDate: "1-1-1111")]
        ],
      ),
      ComicBook(
        listPart: ["p1", "p2"],
        listChapters: [
          List.generate(
              Random().nextInt(20) + 5,
              (chapterIndex) => ChapterComicBook(
                  chapterName: 'Chapter ${chapterIndex + 1}',
                  chapterDate:
                      '${Random().nextInt(31)}-${Random().nextInt(12)}-${Random().nextInt(25) + 1999}')),
          List.generate(
              Random().nextInt(20) + 5,
              (chapterIndex) => ChapterComicBook(
                  chapterName: 'Chapter ${chapterIndex + 1}',
                  chapterDate:
                      '${Random().nextInt(31)}-${Random().nextInt(12)}-${Random().nextInt(25) + 1999}'))
        ],
      ),
      ComicBook(),
    ]);
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
  List<Genre> getAllDataFromJson({required List<dynamic> jsons}) {
    List<Genre> datas = [];
    for (var json in jsons) {
      datas.add(Genre(id: json['id'], genresName: json['genresName']));
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
