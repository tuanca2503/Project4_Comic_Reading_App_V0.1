import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project4/models/fillter_comic_book.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/widgets/base_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.baseConstraints});
  final BoxConstraints baseConstraints;

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
  List<String> items = [];

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
        setBottomBar: true,
        chooseBottomicon: 2,
        baseConstraints: widget.baseConstraints,
        setBody: bodySearchScreen());
  }

  Widget bodySearchScreen() {
    double heightSearchBox = widget.baseConstraints.maxHeight * 0.1;
    double heightFillterSearchBox = widget.baseConstraints.maxHeight * 0.07;
    //
    double heightResultBox = widget.baseConstraints.maxHeight -
        heightFillterSearchBox -
        heightSearchBox;

    return Container(
      padding: BaseWidget().setLefRightPadding(pLR: 20),
      child: Column(
        children: [
          //
          searchBox(heightSearchBox: heightSearchBox),
          //
          SizedBox(
            width: widget.baseConstraints.maxWidth,
            height: heightResultBox,
            child: LayoutBuilder(builder: (context, size) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: heightFillterSearchBox,
                    child: Container(
                      width: size.maxWidth,
                      height: size.maxHeight,
                      child: Column(
                        children: [
                          Container(
                            width: widget.baseConstraints.maxWidth,
                            height: heightResultBox * 0.05,
                            child: Text(
                              'Kết quả tìm kiếm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      widget.baseConstraints.maxWidth * 0.05),
                            ),
                          ),
                          Container(
                            width: widget.baseConstraints.maxWidth,
                            height: heightResultBox * 0.95,
                            child: items.isEmpty
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
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(items[index]),
                                      );
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),

                  ///////////////////////
                  Positioned(
                    top: 0,
                    child: fillterSearch(
                        heightFillterSearchBox: heightFillterSearchBox),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget resultSearchBox() {
    return Column(
      children: [
        Container(
          child: BaseWidget().setText(txt: "tim kiem nhanh"),
        ),
      ],
    );
  }

  Widget fillterSearch({required double heightFillterSearchBox}) {
    return Container(
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            height: heightFillterSearchBox,
            width: widget.baseConstraints.maxWidth - 30,
            child: LayoutBuilder(builder: (context, constraints) {
              Color colorBackground = BaseWidget().color;
              return ListView.builder(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,

                itemCount: listFillters.length,
                itemBuilder: (context, index) {
                  bool choose = chooseItemFillter[listFillters[index]] ?? false;
                  bool l = (listFillters.first == listFillters[index]);
                  bool r = (listFillters.last == listFillters[index]);
                  bool c = (!l && !r);

                  return handleChooseFillterEvent(
                      fillterComicBook: listFillters[index],
                      child: filltersItem(
                          left: l,
                          right: r,
                          center: c,
                          constraints: constraints,
                          colorButton: Colors.white,
                          colorChoose: Colors.orange,
                          choose: choose,
                          txt: listFillters[index].name,
                          colorBackground: colorBackground));
                },

                // children: [

                //   filltersItem(
                //       constraints: constraints,
                //       color: Colors.red,
                //       choose: true,
                //       txt: "Year",
                //       colorBackground: colorBackground),
                //   filltersItem(
                //       constraints: constraints,
                //       txt: "Category",
                //       colorBackground: colorBackground),
                //   filltersItem(
                //       constraints: constraints,
                //       txt: "Favort",
                //       colorBackground: colorBackground),
                //   filltersItem(
                //       constraints: constraints,
                //       txt: "Favort",
                //       colorBackground: colorBackground),
                // ],
              );
            }),
          ),
          // Positioned(
          //   bottom: 0,
          //   child: Container(
          //     color: Colors.amber,
          //     height: 200,
          //     child: Row(
          //       children: [
          //         Container(
          //           width: 100,
          //           color: Colors.black,
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget itemOfFillter() {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 2.0, // Khoảng cách giữa các Container
        children: List.generate(
          20, // Số lượng phần tử trong danh sách
          (index) => Container(
            width: 50.0,
            height: 50.0,
            color: Colors.blue,
            margin: EdgeInsets.all(8.0),
            child: Center(
              child: Text('$index'),
            ),
          ),
        ),
      ),
    );
  }

  Widget filltersItem({
    required BoxConstraints constraints,
    required Color colorButton,
    required Color colorChoose,
    bool choose = false,
    required String txt,
    required Color colorBackground,
    bool left = false,
    bool right = false,
    bool center = false,
  }) {
    double padding = 10;
    ////////////////
    ///
    ///
    ///
    double borderOutSide = padding;
    double widthBoxFillter = constraints.maxWidth * 0.3;
    return Container(
      margin: EdgeInsets.only(bottom: choose ? 0 : padding, right: padding),
      height: constraints.maxHeight,
      width: widthBoxFillter,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: choose ? padding : 0),
            // boxfillter
            decoration: BoxDecoration(
                border: choose ? Border.all(color: colorChoose) : null,
                color: choose ? colorChoose : colorButton,
                borderRadius: choose
                    ? BorderRadius.only(
                        topRight: Radius.circular(padding / 2),
                        topLeft: Radius.circular(padding / 2))
                    : BorderRadius.all(Radius.circular(5))),
            alignment: Alignment.center,
            child: BaseWidget().setText(
                txt: txt,
                color: choose ? Colors.white : Colors.black,
                fontWeight: choose ? FontWeight.bold : FontWeight.w300),
          ),
          /////////////////
          ///box item

          // choose
          //     ? Transform.translate(
          //         offset: Offset(0, 0),
          //         child: ListView(
          //           children: List.generate(
          //             20,
          //             (index) => ListTile(
          //               title: Text('Item $index'),
          //             ),
          //           ),
          //         ),
          //       )
          //     : Container(),

          ///left
          choose
              //true
              ? left
                  ? leftOutSideBorderFillterBox(
                      borderOutSide: borderOutSide,
                      colorChoose: colorChoose,
                      colorBackground: colorBackground)
                  : right
                      ? rightOutSideBorderFillterBox(
                          borderOutSide: borderOutSide,
                          colorChoose: colorChoose,
                          colorBackground: colorBackground)
                      : Container()
              : Container(),

          choose
              ? center
                  ? Stack(
                      clipBehavior: Clip.none,
                      children: [
                        rightOutSideBorderFillterBox(
                            borderOutSide: borderOutSide,
                            colorChoose: colorChoose,
                            colorBackground: colorBackground),
                        leftOutSideBorderFillterBox(
                            borderOutSide: borderOutSide,
                            colorChoose: colorChoose,
                            colorBackground: colorBackground)
                      ],
                    )
                  : Container()
              : Container(),

          choose
              ? Positioned(
                  bottom: -200,
                  left: center
                      //
                      ? -(widthBoxFillter / 2 +
                          ((widget.baseConstraints.maxWidth - 40) / 5))
                      //
                      : left
                          ? 0
                          : null,
                  right: right ? 0 : null,
                  child: Container(
                    width: widget.baseConstraints.maxWidth - 40,
                    height: 200,
                    padding: EdgeInsets.all(10),

                    //box item

                    decoration: BoxDecoration(
                      border: choose ? Border.all(color: colorChoose) : null,
                      color: colorChoose,
                      borderRadius: center
                          ? BorderRadius.all(Radius.circular(padding / 2))
                          : left
                              ? BorderRadius.only(
                                  bottomLeft: Radius.circular(padding / 2),
                                  bottomRight: Radius.circular(padding / 2),
                                  topRight: Radius.circular(padding / 2),
                                )
                              : right
                                  ? BorderRadius.only(
                                      bottomLeft: Radius.circular(padding / 2),
                                      bottomRight: Radius.circular(padding / 2),
                                      topLeft: Radius.circular(padding / 2),
                                    )
                                  : null,
                    ),
                    child: itemOfFillter(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget leftOutSideBorderFillterBox({
    required borderOutSide,
    required colorChoose,
    required colorBackground,
  }) {
    return Positioned(
      bottom: -0,
      right: -borderOutSide,
      child: Container(
        clipBehavior: Clip.none,
        color: colorChoose,
        width: borderOutSide,
        height: borderOutSide,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -borderOutSide,
              right: -borderOutSide,
              child: Container(
                height: borderOutSide * 2,
                width: borderOutSide * 2,
                //outside border
                decoration: BoxDecoration(
                    color: colorBackground,
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderOutSide))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rightOutSideBorderFillterBox({
    required borderOutSide,
    required colorChoose,
    required colorBackground,
  }) {
    return Positioned(
      bottom: -0,
      left: -borderOutSide,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: colorChoose,
        ),
        width: borderOutSide,
        height: borderOutSide,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -borderOutSide,
              left: -borderOutSide,
              child: Container(
                height: borderOutSide * 2,
                width: borderOutSide * 2,
                //outside border
                decoration: BoxDecoration(
                    color: colorBackground,
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderOutSide))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget handleChooseFillterEvent(
      {required Widget child, required FillterComicBook fillterComicBook}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (chooseItemFillter[fillterComicBook] == true) {
            chooseItemFillter.update(fillterComicBook, (value) => false);

            return;
          }
          chooseItemFillter.updateAll((key, value) => false);
          chooseItemFillter.update(fillterComicBook, (value) => true);
        });
      },
      child: child,
    );
  }

  Widget searchBox({required double heightSearchBox}) {
    Color borderColor = const Color(0xff232220);
    double ourRadius = 10;
    double scalePadding = 3;

    BorderRadius borderRadius = BorderRadius.all(Radius.circular(ourRadius));
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(width: 2, color: borderColor),
            ),
            padding: EdgeInsets.all(scalePadding),
            height: heightSearchBox / 1.5,
            child: LayoutBuilder(builder: (context, constraints) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(ourRadius / 2)),
                ),
                child: TextField(
                  style: TextStyle(color: Colors.white),
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
                          color: Color(0xffA4A3A1),
                          fontWeight: FontWeight.w300,
                          fontSize: constraints.maxHeight * 0.3),
                      hintText: 'Tìm kiếm ngay',
                      border: InputBorder.none),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}


//////////
