import 'dart:math';

class FillterComicBook {
  String name;
  List<String> fillterItem;

  FillterComicBook({this.name = "", this.fillterItem = const ["all"]});

  List<FillterComicBook> seed() {
    List<FillterComicBook> data = [];
    data.addAll(
      [
        FillterComicBook(
            name: "Year",
            fillterItem: List.generate(10, (index) => "20${index + 10}")),
        FillterComicBook(name: "Category", fillterItem: [
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
        ]),
      ],
    );

    data.addAll(List.generate(
      3,
      (index) => FillterComicBook(
        name: "filter $index",
        fillterItem: List.generate(
          Random().nextInt(5) + 1, // Generating a list with 1 to 5 items
          (itemIndex) => 'Item $itemIndex',
        ),
      ),
    ));
    return data;
  }
}
