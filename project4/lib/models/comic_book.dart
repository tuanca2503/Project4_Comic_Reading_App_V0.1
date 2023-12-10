import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project4/models/chapter_comic_book.dart';
import 'package:project4/models/part_comic_book.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ComicBook {
  final String idComicBook;
  final String name;
  final String author;
  final String description;
  final String linkImage;
  final int view;
  final int like;
  final int follow;
  final String rank;
  final String yearPublic;

///////////////////

  final List<String> listCategory;
  final List<List<ChapterComicBook>> listChapters;
  final List<String> listPart;
  List<PartComicBook> partComicBook = [];

  ComicBook({
    this.idComicBook = "",
    this.yearPublic = "",
    this.rank = "",
    this.name = "",
    this.author = "",
    this.description = "",
    this.linkImage = "c4.jpg",
    this.listCategory = const [],
    this.view = 0,
    this.like = 0,
    this.follow = 0,
    this.listPart = const [],
    this.listChapters = const [[]],
  }) {
    setPartComicBook(part: listPart, chapter: listChapters);
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
        idComicBook: 'CB${Random().nextInt(500) + 20}-$index',
        name: 'Comic Name $index ',
        author: 'Author $index ',
        yearPublic: "${Random().nextInt(25) + 1999}",
        rank: "${Random().nextInt(10) + 1}",
        description:
            'The story revolves around the life of a young girl named Hương. Born and raised in a small village in Vietnam, Hương dreams of exploring the world beyond her humble beginnings. However, her life takes a dramatic turn when her family falls into financial hardship, forcing her to put her dreams on hold.Despite the challenges, Hương remains resilient. She takes on various jobs to support her family, all the while nurturing her dream of traveling. Her determination and hard work eventually pay off when she receives a scholarship to study abroad.',
        linkImage: 'c$index.jpg',
        listCategory: List.generate(
            Random().nextInt(8) + 3,
            (index) => [
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
                ][Random().nextInt(10)]),
        view: Random().nextInt(500) * Random().nextInt(100),
        like: Random().nextInt(500) * Random().nextInt(100),
        follow: Random().nextInt(500) * Random().nextInt(100),
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

////////////
    ///

    // return [
    //   ComicBook(
    //     yearPublic: "1997",
    //     rank: "1",
    //     name: 'Comic Name 1',
    //     author: 'Author 1',
    //     description:
    //         'The story revolves around the life of a young girl named Hương. Born and raised in a small village in Vietnam, Hương dreams of exploring the world beyond her humble beginnings. However, her life takes a dramatic turn when her family falls into financial hardship, forcing her to put her dreams on hold.Despite the challenges, Hương remains resilient. She takes on various jobs to support her family, all the while nurturing her dream of traveling. Her determination and hard work eventually pay off when she receives a scholarship to study abroad.',
    //     linkImage: 'c1.jpg',
    //     listCategory: [
    //       'Action',
    //       'Adventure',
    //       'Comedy',
    //       'Drama',
    //       'Fantasy',
    //       'Shounen',
    //       'Supernatured',
    //       'Seinen',
    //       'Comedy',
    //       'Romance',
    //     ],
    //     view: 1000,
    //     like: 500,
    //     follow: 300,
    //     listPart: ["Phan 1"],
    //     listChapters: [
    //       [
    //         ChapterComicBook(chapterName: 'Chapter 1', chapterDate: '1-1-1111'),
    //         ChapterComicBook(chapterName: 'Chapter 2', chapterDate: '1-1-1111'),
    //         ChapterComicBook(chapterName: 'Chapter 3', chapterDate: '1-1-1111'),
    //         ChapterComicBook(chapterName: 'Chapter 4', chapterDate: '1-1-1111'),
    //         ChapterComicBook(chapterName: 'Chapter 5', chapterDate: '1-1-1111'),
    //         ChapterComicBook(chapterName: 'Chapter 6', chapterDate: '1-1-1111'),
    //         ChapterComicBook(chapterName: 'Chapter 7', chapterDate: '1-1-1111'),
    //         ChapterComicBook(chapterName: 'Chapter 8', chapterDate: '1-1-1111'),
    //         ChapterComicBook(chapterName: 'Chapter 9', chapterDate: '1-1-1111'),
    //         ChapterComicBook(
    //             chapterName: 'Chapter 10', chapterDate: '1-1-1111'),
    //       ]
    //     ],
    //   ),
    // ];
  }

  //////////////////////////////
  QrImageView toQrImage({required Color color, required double size}) {
    String json = '{"id": "$idComicBook"}';

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
