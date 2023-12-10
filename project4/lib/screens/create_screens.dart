import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:project4/screens/base_screen.dart';

class CreateScreen extends StatelessWidget {
  @override
  const CreateScreen({Key? key, required this.constraints});
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final fontSize = screenWidth * 0.03;
    final fontBac = screenWidth * 0.02;
    final fontBack = screenWidth * 0.05;
    final create = screenWidth * 0.025;

    return BaseScreen(
      baseConstraints: constraints,
      setBottomBar: false,
      setBody: Container(
        padding: EdgeInsets.all(10),
        color: Color(0xFF1f252e),
        child: Column(children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.4,
            padding: EdgeInsets.only(top: screenHeight * 0.2),
            // decoration: BoxDecoration(
            //   border: Border.all(width: 1, color: Colors.white),
            // ),
            child: Transform.scale(
              scale:
                  0.7, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
              child: Image.asset('/images/logo_white.png'),
              // Đường dẫn đến ảnh của bạn
            ),
          ),
          Container(
            width: double.infinity,
            height: screenHeight * 0.1,
            // padding: EdgeInsets.all(10),
            // decoration: BoxDecoration(
            //   border: Border.all(width: 1, color: Colors.white),
            // ),
            child: Column(
              children: [
                TextField(
                  style:
                      TextStyle(color: Color(0xffd6dbe2), fontSize: fontSize),
                  decoration: InputDecoration(
                    filled: true, // Đánh dấu rằng TextField có màu nền
                    fillColor: Color(0xFF181c1f), // Đặt màu nền của TextField
                    hintText: 'name@gmail.com',
                    hintStyle: TextStyle(
                      color: Color(0xff49575e),
                      fontSize: fontSize,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFF242830),
                          width: 3,
                        )),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Color(0xFF3b4149), width: 2),
                      // Đặt chiều cao và chiều dài cho đường viền khi focus
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.03,
                        horizontal: screenHeight * 0.02),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: screenHeight * 0.1,
            // padding: EdgeInsets.all(10),
            // decoration: BoxDecoration(
            //   border: Border.all(width: 1, color: Colors.white),
            // ),
            child: Column(
              children: [
                TextField(
                  style:
                      TextStyle(color: Color(0xffd6dbe2), fontSize: fontSize),
                  decoration: InputDecoration(
                    filled: true, // Đánh dấu rằng TextField có màu nền
                    fillColor: Color(0xFF181c1f), // Đặt màu nền của TextField
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Color(0xff49575e),
                      fontSize: fontSize,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Color(0xFF242830),
                          width: 3,
                        )),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Color(0xFF3b4149), width: 2),
                      // Đặt chiều cao và chiều dài cho đường viền khi focus
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: screenWidth * 0.03,
                        horizontal: screenHeight * 0.02),
                  ),
                  obscureText: true,
                  obscuringCharacter: '\u2022',
                ),
                Center(
                  child: Text(
                    'Min 8 characters containing a number and symbol',
                    style:
                        TextStyle(color: Color(0xff49575e), fontSize: fontSize),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: screenHeight * 0.05,
            padding: EdgeInsets.only(bottom: screenWidth * 0.06),
            // child: Center(
            //   child: Text(
            //     'Min 8 characters containing a number and symbol',
            //     style: TextStyle(color: Color(0xff49575e), fontSize: fontSize),
            //   ),
            // ),
          ),
          Container(
            width: double.infinity,
            height: screenHeight * 0.1,
            padding: EdgeInsets.all(10),
            // decoration: BoxDecoration(
            //   border: Border.all(width: 1, color: Colors.white),
            // ),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: buttonBack(
                          child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: Color(0xFF455258)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                '<',
                                style: TextStyle(
                                    color: Color(0xffd6dbe2),
                                    fontSize: fontBack),
                              ),
                            ),
                          ),
                          context: context)),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFd98118),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'CREATE FREE ACCOUWT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffd6dbe2),
                            fontSize: create,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: screenHeight * 0.23,
            // decoration: BoxDecoration(
            //   border: Border.all(width: 1, color: Colors.white),
            // ),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      height: double.infinity,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.only(left: screenHeight * 0.025),
                    child: Container(
                      height: double.infinity,
                      child: Text(
                        'I agree to the Terrms',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffd6dbe2),
                          fontSize: create,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget buttonBack({required Widget child, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: child,
    );
  }
}
