import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:project4/screens/base_screen.dart';

class CategoryScreen extends StatelessWidget {
  @override
  const CategoryScreen({Key? key, required this.constraints});
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenWidth * 0.03;
    final fontFour = screenWidth * 0.04;
    final fontBac = screenWidth * 0.02;
    final fontBack = screenWidth * 0.05;
    final create = screenWidth * 0.025;
    final fontOne = screenWidth * 0.1;

    return BaseScreen(
      baseConstraints: constraints,
      setBody: Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Column(children: [
          Container(
              width: constraints.maxWidth,
              height: screenHeight * 0.2,
              // decoration: BoxDecoration(
              //   border: Border.all(width: 1, color: Colors.black),
              // ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Let us know!',
                    style: TextStyle(
                      fontSize: fontOne,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Choose your genre to find your favorite webtoon here!',
                    style:
                        TextStyle(fontSize: fontFour, color: Color(0xff999999)),
                    textAlign: TextAlign.center,
                  )
                ],
              ))),
          Container(
            width: constraints.maxWidth,
            height: screenHeight * 0.18,
            // decoration: BoxDecoration(
            //   border: Border.all(width: 1, color: Colors.black),
            // ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5), // Adjust the padding as needed
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xFFeaecef)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.1,
                            child: Transform.scale(
                              scale:
                                  0.5, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                              child: Image.asset(
                                  '/images/fire.png'), // Đường dẫn đến ảnh của bạn
                            ),
                          ),
                          Container(
                            child: Text(
                              'Action',
                              style: TextStyle(fontSize: fontFour),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xFFeaecef)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.1,
                            child: Transform.scale(
                              scale:
                                  0.5, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                              child: Image.asset(
                                  '/images/crying.png'), // Đường dẫn đến ảnh của bạn
                            ),
                          ),
                          Container(
                            child: Text(
                              'Drama',
                              style: TextStyle(fontSize: fontFour),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xFFeaecef)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.1,
                            child: Transform.scale(
                              scale:
                                  0.5, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                              child: Image.asset(
                                  '/images/ghost.png'), // Đường dẫn đến ảnh của bạn
                            ),
                          ),
                          Container(
                            child: Text(
                              'Horror',
                              style: TextStyle(fontSize: fontFour),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: constraints.maxWidth,
            height: screenHeight * 0.18,
            // decoration: BoxDecoration(
            //   border: Border.all(width: 1, color: Colors.black),
            // ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5), // Adjust the padding as needed
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xFFeaecef)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.1,
                            child: Transform.scale(
                              scale:
                                  0.5, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                              child: Image.asset(
                                  '/images/heart.png'), // Đường dẫn đến ảnh của bạn
                            ),
                          ),
                          Container(
                            child: Text(
                              'Romance',
                              style: TextStyle(fontSize: fontFour),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xFFeaecef)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.1,
                            child: Transform.scale(
                              scale:
                                  0.5, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                              child: Image.asset(
                                  '/images/crown.png'), // Đường dẫn đến ảnh của bạn
                            ),
                          ),
                          Container(
                            child: Text(
                              'Western',
                              style: TextStyle(fontSize: fontFour),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xFFeaecef)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.1,
                            child: Transform.scale(
                              scale:
                                  0.5, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                              child: Image.asset(
                                  '/images/unicorn.png'), // Đường dẫn đến ảnh của bạn
                            ),
                          ),
                          Container(
                            child: Text(
                              'Fantasy',
                              style: TextStyle(fontSize: fontFour),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: constraints.maxWidth,
            height: screenHeight * 0.18,
            // decoration: BoxDecoration(
            //   border: Border.all(width: 1, color: Colors.black),
            // ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5), // Adjust the padding as needed
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xFFeaecef)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.1,
                            child: Transform.scale(
                              scale:
                                  0.5, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                              child: Image.asset(
                                  '/images/laughing.png'), // Đường dẫn đến ảnh của bạn
                            ),
                          ),
                          Container(
                            child: Text(
                              'Parody',
                              style: TextStyle(fontSize: fontFour),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xFFeaecef)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.1,
                            child: Transform.scale(
                              scale:
                                  0.5, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                              child: Image.asset(
                                  '/images/magic-ball.png'), // Đường dẫn đến ảnh của bạn
                            ),
                          ),
                          Container(
                            child: Text(
                              'Magic',
                              style: TextStyle(fontSize: fontFour),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xFFeaecef)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.1,
                            child: Transform.scale(
                              scale:
                                  0.5, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                              child: Image.asset(
                                  '/images/mistery.png'), // Đường dẫn đến ảnh của bạn
                            ),
                          ),
                          Container(
                            child: Text(
                              'Mistery',
                              style: TextStyle(fontSize: fontFour),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: constraints.maxWidth,
            height: screenHeight * 0.07,
            // decoration: BoxDecoration(
            //   border: Border.all(width: 1, color: Colors.black),
            // ),
          ),
          Container(
            width: screenWidth * 0.6,
            height: screenHeight * 0.07,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFf48611),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffd6dbe2),
                    fontSize: fontFour,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: constraints.maxWidth,
            height: screenHeight * 0.07,
            child: Center(
                child: Text(
              'Skip for now',
              style: TextStyle(color: Color(0xff8e8e8e)),
            )),
          )
        ]),
      ),
    );
  }
}
