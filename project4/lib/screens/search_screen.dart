import 'package:flutter/material.dart';
import 'package:project4/models/comic/filter_comic_book.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/widgets/base_widget.dart';

import '../models/comic/comic_book.dart';
import '../utils/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  bool focusSearch = false;

  ////////////////////////////////////////////////
  ///seed fillter
  List<FillterComicBook> listFillters = FillterComicBook().seed();
  Map<FillterComicBook, bool> chooseItemFillter = {};
  List<ComicBook> comicBooks = [];
  List<FillterSearchBox> itemsFilter = FillterSearchBox().seed();
  int selectedIdx = -1;
  FillterSearchBox fillterSearchBox = FillterSearchBox().seed().first;

  ///
  ///

  @override
  void initState() {
    super.initState();
    //
    for (var element in listFillters) {
      chooseItemFillter.addAll({element: false});
    }

    //

    // Lắng nghe sự kiện khi TextField nhận hoặc mất focus
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        // TextField nhận focus
        setState(() {
          // focusSearch = true;
        });
        // Thực hiện các hành động khi TextField nhận focus ở đây
      } else {
        // TextField mất focus
        setState(() {
          // focusSearch = false;
        });
        // Thực hiện các hành động khi TextField mất focus ở đây
      }
    });
  }

  @override
  void dispose() {
    // Giải phóng FocusNode khi widget bị hủy
    searchFocusNode.dispose();
    super.dispose();
  }

  ///////////////////////////////

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        setBottomBar: true, chooseBottomIcon: 2, setBody: bodySearchScreen());
  }

  Widget bodySearchScreen() {
    double heightSearchBox = baseConstraints.maxHeight * 0.1;
    double heightFillterSearchBox = baseConstraints.maxHeight * 0.07;
    //
    double heightResultBox =
        baseConstraints.maxHeight - heightFillterSearchBox - heightSearchBox;

    return Container(
      padding: BaseWidget().setLefRightPadding(pLR: 20),
      child: Column(
        children: [
          //
          searchBox(heightSearchBox: heightSearchBox),
          fillterSearch(heightFillterSearchBox: heightFillterSearchBox),
          //
          SizedBox(
            width: baseConstraints.maxWidth,
            height: heightResultBox,
            child: LayoutBuilder(builder: (context, size) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 0,
                    child: SizedBox(
                      width: size.maxWidth,
                      height: size.maxHeight,
                      child: Column(
                        children: [
                          SizedBox(
                            width: baseConstraints.maxWidth,
                            height: heightResultBox * 0.05,
                            child: Text(
                              'Kết quả tìm kiếm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: baseConstraints.maxWidth * 0.05),
                            ),
                          ),
                          SizedBox(
                            width: baseConstraints.maxWidth,
                            height: heightResultBox * 0.95,
                            child: comicBooks.isEmpty
                                ? const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.insert_drive_file,
                                          size: 48.0,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'Danh sách trống',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: comicBooks.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(comicBooks[index].title),
                                      );
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),

                  /////////////////////
                  Positioned(
                    top: 0,
                    child: Container(),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

////////////////////////

  Widget fillterSearch({required double heightFillterSearchBox}) {
    itemsFilter.first.choose = true;
    return SizedBox(
      height: heightFillterSearchBox,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(itemsFilter.length, (index) {
          return Container(
            padding: const EdgeInsets.only(bottom: 5, right: 20, left: 20),
            child: InkWell(
              onTap: () {
                setState(
                  () {
                    // selectedIdx = index;
                    for (FillterSearchBox item in itemsFilter) {
                      item.choose = false;
                    }
                    itemsFilter[index].choose = true;
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: itemsFilter[index].choose
                          ? Colors.grey
                          : Colors.transparent,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Center(
                  child: BaseWidget().setText(
                      txt: itemsFilter[index].nameFillter,
                      fontSize: 13,
                      fontWeight: FontWeight.w100),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

/////////////////////////////////////

  Widget searchBox({required double heightSearchBox}) {
    Color borderColor = const Color(0xff232220);
    double ourRadius = 10;
    double scalePadding = 3;

    BorderRadius borderRadius = BorderRadius.all(Radius.circular(ourRadius));
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(width: 2, color: borderColor),
        ),
        padding: EdgeInsets.all(scalePadding),
        height: heightSearchBox,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: borderColor),
                color: borderColor,
                borderRadius: BorderRadius.all(Radius.circular(ourRadius / 2)),
              ),
              child: SingleChildScrollView(
                child: TextField(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: constraints.maxHeight * 0.3),
                  focusNode: searchFocusNode,
                  textAlign: TextAlign.start,
                  controller: searchController,
                  onTap: () {},
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: constraints.maxHeight * 0.5,
                      ),
                      // contentPadding: EdgeInsets.all(scalePadding),
                      hintStyle: TextStyle(
                          color: const Color(0xffA4A3A1),
                          fontWeight: FontWeight.w300,
                          fontSize: constraints.maxHeight * 0.3),
                      hintText: 'Tìm kiếm ngay',
                      border: InputBorder.none),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//////////
