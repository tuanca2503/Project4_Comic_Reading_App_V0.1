import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:project4/models/app_valid.dart';
import 'package:project4/models/handle_response_api.dart';
import 'package:project4/models/user.dart';
import 'package:project4/repositories/base_repository.dart';
import 'package:project4/repositories/user_repository.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/screens/home_screen.dart';

import 'package:project4/widgets/base_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen(
      {super.key,
      required this.baseConstraints,
      required this.baseRepository,
      this.chooseScreen = false,
      this.keyAS = false});
  final BaseRepository baseRepository;
  final BoxConstraints baseConstraints;
  final bool keyAS;
  final bool chooseScreen;

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  double fontSize = 0;
  double fontFour = 0;
  double fontBac = 0;
  double boxBack = 0;
  double fontBack = 0;
  double create = 0;
  bool chooseScreen = false;
  bool key = false; // true là đăng kí fales là đăng nhập
  ////
  List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();
  TextEditingController _rePassword = TextEditingController();
  String errorMess = '';

  //////////////////////////////////////
  @override
  void initState() {
    chooseScreen = widget.chooseScreen;
    key = widget.keyAS;
    double screenWidth = widget.baseConstraints.maxWidth;
    ThemeData(colorSchemeSeed: const Color(0xFF3b4149), useMaterial3: true);
    fontSize = screenWidth * 0.03;
    fontFour = screenWidth * 0.04;
    fontBac = screenWidth * 0.02;
    boxBack = screenWidth * 0.15;
    fontBack = screenWidth * 0.05;
    create = screenWidth * 0.025;

    super.initState();
    /////////////////////////////////////////////////////////////////////
  }

  bool _isObscured = true;
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        baseConstraints: widget.baseConstraints,
        setAppBar: 3,
        setBottomBar: false,
        setBody: chooseScreen
            ? bodyAccountScreen(
                key: key,
                context: context,
                baseConstraints: widget.baseConstraints)
            : bodyChooseScreen(
                context: context, baseConstraints: widget.baseConstraints));
  }

  ////////////////////////////////////////
  Widget rowCode({required limit}) {
    /////

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 6; i++)
          Expanded(
            child: Container(
                child: Container(
              padding: EdgeInsets.only(
                  left: (i == 0) ? 10 : 5, right: (i == 6) ? 10 : 5),
              child: TextField(
                onChanged: (value) {
                  // Auto move to the next field when the current field is filled
                  // if (value.isNotEmpty && index < controllers.length - 1) {
                  //   FocusScope.of(context).requestFocus(controllers[index + 1]);
                  // }
                  if (value.isNotEmpty) {
                    // Move focus to the next box when a number is entered
                    print("a");
                    if (i < 5) {
                      FocusScope.of(context).nextFocus();
                    } else {
                      // If the last box is filled, remove focus
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  }
                },
                controller: controllers[i],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                ),
              ),
            )),
          ),
      ],
    );
  }

///////////////////////////////////////////////////////////acc
  Widget bodyAccountScreen(
      {required BuildContext context,
      bool key = false,
      required BoxConstraints baseConstraints}) {
    return Container(
      width: baseConstraints.maxWidth,
      height: baseConstraints.maxHeight,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Color(0xff0b0704),
            Color(0xff16110d),
            Color(0xff1f1b19),
          ],
        ),
      ),
      child: ListView(children: [
        Container(
          width: baseConstraints.maxWidth,
          height: baseConstraints.maxHeight * 0.3,
          padding: EdgeInsets.only(top: baseConstraints.maxHeight * 0.09),
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.white),
          // ),
          child: Transform.scale(
            scale:
                0.7, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
            child: BaseWidget().setImageAsset('logo_white.png'),
            // Đường dẫn đến ảnh của bạn
          ),
        ),
        Container(
          width: baseConstraints.maxWidth,
          height: baseConstraints.maxHeight * 0.1,
          child: Center(
            child: Text(
              key ? 'Sign up now' : 'Sign in now',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xffd6dbe2),
                fontSize: fontBack,
              ),
            ),
          ),
        ),
        (errorMess.isNotEmpty || errorMess != '')
            ? BaseWidget()
                .setText(txt: errorMess, color: Colors.red, fontSize: 14)
            : Container(),
        Container(
          width: baseConstraints.maxWidth,
          height: baseConstraints.maxHeight * 0.12,

          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.white),
          // ),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: 0.001), // You can adjust the value as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffd6dbe2),
                    fontSize: fontFour,
                  ),
                ),
                SizedBox(height: 8.0), // Add some vertical space
                TextField(
                  controller: _email,
                  style:
                      TextStyle(color: Color(0xffd6dbe2), fontSize: fontSize),
                  decoration: InputDecoration(
                    fillColor: Color(0xff1f1b19),
                    filled: true,
                    hintText: 'name@gmail.com',
                    hintStyle: TextStyle(
                      color: Color(0xff49575e),
                      fontSize: fontSize,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF242830),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3b4149), width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    suffixIcon: key
                        ? TextButton(
                            onPressed: () {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        color: Colors.white,
                                        child: LayoutBuilder(
                                            builder: (context, constraints) {
                                          return Material(
                                            child: Container(
                                              child: Column(children: [
                                                Expanded(
                                                    child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Text(
                                                    'Cần được xác thực',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: fontBack,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )),
                                                Expanded(
                                                    child: Container(
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            child: Text(
                                                              'Nhập mã chúng tôi đã gửi đến gmail của bạn!',
                                                              style: TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color: Color(
                                                                    0xff737373),
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                fontSize:
                                                                    fontFour,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )),
                                                      Expanded(
                                                          flex: 8,
                                                          child:
                                                              rowCode(limit: 6))
                                                    ],
                                                  ),
                                                )),
                                                Expanded(child: Container()),
                                                Expanded(child: Container())
                                              ]),
                                            ),
                                          );
                                        }),
                                      ),
                                    );
                                  }

                                  //  => AlertDialog(
                                  //   title: const Text(
                                  //     'Cần được xác thực',
                                  //     textAlign: TextAlign.center,
                                  //   ),
                                  //   content: const Text(
                                  //       'Nhập mã chúng tôi đã gửi đến gmail của bạn!'),
                                  //   actions: <Widget>[
                                  //     TextButton(
                                  //       onPressed: () =>
                                  //           Navigator.pop(context, 'Cancel'),
                                  //       child: const Text('Cancel'),
                                  //     ),
                                  //     TextButton(
                                  //       onPressed: () => Navigator.pop(context, 'OK'),
                                  //       child: const Text('OK'),
                                  //     ),
                                  //   ],
                                  // ),
                                  );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              padding: EdgeInsets.all(5),
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..rotateZ(-20 *
                                      (3.14159265358979323846 /
                                          180)) // Xoay 45 độ
                                  ..translate(-5, 0),
                                child: Icon(
                                  Icons.send, // Mã biểu tượng email
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
        key
            ? Container(
                width: baseConstraints.maxWidth,
                height: baseConstraints.maxHeight * 0.12,
                // decoration: BoxDecoration(
                //   border: Border.all(width: 1, color: Colors.white),
                // ),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 0.001), // You can adjust the value as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'UserName',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffd6dbe2),
                          fontSize: fontFour,
                        ),
                      ),
                      SizedBox(height: 8.0), // Add some vertical space
                      TextField(
                        controller: _username,
                        style: TextStyle(
                            color: Color(0xffd6dbe2), fontSize: fontSize),
                        decoration: InputDecoration(
                          fillColor: Color(0xff1f1b19),
                          filled: true,
                          hintText: 'Your name',
                          hintStyle: TextStyle(
                              color: Color(0xff49575e), fontSize: fontSize),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF242830), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF3b4149), width: 2),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: baseConstraints.maxWidth * 0.03,
                            horizontal: baseConstraints.maxHeight * 0.02,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),

        /////////
        Container(
          width: baseConstraints.maxWidth,
          height: baseConstraints.maxHeight * 0.12,
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.white),
          // ),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: 0.001), // You can adjust the value as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffd6dbe2),
                    fontSize: fontFour,
                  ),
                ),
                SizedBox(height: 8.0), // Add some vertical space
                TextField(
                  controller: _password,
                  style:
                      TextStyle(color: Color(0xffd6dbe2), fontSize: fontSize),
                  decoration: InputDecoration(
                    fillColor: Color(0xff1f1b19),
                    filled: true,
                    hintText: 'Password',
                    hintStyle:
                        TextStyle(color: Color(0xff49575e), fontSize: fontSize),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF242830), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3b4149), width: 2),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: baseConstraints.maxWidth * 0.03,
                      horizontal: baseConstraints.maxHeight * 0.02,
                    ),
                    suffixIcon: TextButton(
                      onPressed: () {
                        // Đảo ngược trạng thái ẩn/mở mật khẩu khi nhấn nút
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                      child: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  obscureText: _isObscured,
                  obscuringCharacter: '\u2023',
                ),
              ],
            ),
          ),
        ),
        key
            ? Container()
            : Container(
                width: baseConstraints.maxWidth,
                height: baseConstraints.maxHeight * 0.06,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          TextEditingController _forgotPass =
                              TextEditingController();
                          String _errMess = '';
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Forgot Password'),
                              actions: <Widget>[
                                (_errMess.isNotEmpty || _errMess.isBool)
                                    ? BaseWidget().setText(
                                        txt: _errMess,
                                        color: Colors.red,
                                        fontSize: 14)
                                    : Container(),
                                TextField(
                                  controller: _forgotPass,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'Enter your email',
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        //
                                        dynamic validMess =
                                            AppValid(data: _forgotPass.text)
                                                    .isValidEmail
                                                ? true
                                                : "Hay nhap dung email";
                                        //
                                        if (validMess is bool && validMess) {
                                          ResultCallAPI response = await widget
                                              .baseRepository.userRepository
                                              .forgotPassword(
                                                  email: _forgotPass.text);
                                          /////
                                          print(response.mess);
                                          if (!response.check ||
                                              response.code == 400) {
                                            errorMess = response.mess;
                                          }
                                          Navigator.pop(context);
                                        } else {
                                          setState(() {
                                            _errMess = validMess;
                                          });
                                        }
                                        //
                                      },
                                      child: const Text('Send'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        child: Text(
                          'Forgot your password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffd45d16),
                            fontSize: fontSize,
                          ),
                        ),
                      ),
                    ]),
              ),
        //
        key
            ? Container(
                width: baseConstraints.maxWidth,
                height: baseConstraints.maxHeight * 0.12,
                // decoration: BoxDecoration(
                //   border: Border.all(width: 1, color: Colors.white),
                // ),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 0.001), // You can adjust the value as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Re password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffd6dbe2),
                          fontSize: fontFour,
                        ),
                      ),
                      SizedBox(height: 8.0), // Add some vertical space
                      TextField(
                        controller: _rePassword,
                        style: TextStyle(
                            color: Color(0xffd6dbe2), fontSize: fontSize),
                        decoration: InputDecoration(
                          fillColor: Color(0xff1f1b19),
                          filled: true,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              color: Color(0xff49575e), fontSize: fontSize),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF242830), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF3b4149), width: 2),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: baseConstraints.maxWidth * 0.03,
                            horizontal: baseConstraints.maxHeight * 0.02,
                          ),
                          suffixIcon: TextButton(
                            onPressed: () {
                              // Đảo ngược trạng thái ẩn/mở mật khẩu khi nhấn nút
                              setState(() {
                                isObscured = !isObscured;
                              });
                            },
                            child: Icon(
                              isObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        obscureText: isObscured,
                        obscuringCharacter: '\u2023',
                      ),
                    ],
                  ),
                ),
              )
            : Container(),

        Container(
          width: baseConstraints.maxWidth,
          height: baseConstraints.maxHeight * 0.08,
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.white),
          // ),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        errorMess = '';
                        chooseScreen = false;
                      });
                    },
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xFF455258)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '<',
                          style: TextStyle(
                              color: Color(0xffd6dbe2), fontSize: fontBack),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: key
                        ? () async {
//
                            dynamic validMess = AppValid().isValidAccount(
                                key: key,
                                rePw: _rePassword.text,
                                em: _email.text,
                                pw: _password.text);
                            //
                            if (validMess is bool && validMess) {
                              ResultCallAPI response = await widget
                                  .baseRepository.userRepository
                                  .registerUser(
                                      email: _email.text,
                                      password: _password.text,
                                      userName: _username.text);
                              /////
                              print(response.mess);
                              if (!response.check || response.code == 400) {
                                errorMess = "Email bi trung";
                              } else {
                                await widget.baseRepository.userRepository
                                    .loginUser(
                                        email: _email.text,
                                        password: _password.text);
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                        baseRepository: widget.baseRepository,
                                        baseConstraints: baseConstraints,
                                      ),
                                    ),
                                  );
                                });
                              }
                            } else {
                              setState(() {
                                errorMess = validMess;
                              });
                            }
                          }
                        : () async {
                            //

                            dynamic validMess = AppValid().isValidAccount(
                                key: key, em: _email.text, pw: _password.text);

                            if (validMess is bool && validMess) {
                              ResultCallAPI response = await widget
                                  .baseRepository.userRepository
                                  .loginUser(
                                      email: _email.text,
                                      password: _password.text);
                              /////
                              setState(() {
                                if (!response.check || response.code == 401) {
                                  errorMess = 'Sai email hoac mat khau';
                                } else {
                                  // print(widget.userRepository
                                  //     .fetchUserData()
                                  //     .email);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                          baseRepository: widget.baseRepository,
                                          baseConstraints: baseConstraints),
                                    ),
                                  );
                                }
                              });
                            } else {
                              setState(() {
                                errorMess = validMess;
                              });
                            }
                            //

                            //////////////////
                          },
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFd98118),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          key
                              ? 'CREATE FREE ACCOUWT'.toUpperCase()
                              : 'Sign IN'.toUpperCase(),
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
              ),
            ],
          ),
        ),
        Container(
          width: baseConstraints.maxWidth,
          height: baseConstraints.maxHeight * 0.08,
          // decoration: BoxDecoration(
          //   border: Border.all(width: 1, color: Colors.white),
          // ),
          // child: Container(
          //   height: double.infinity,
          //   decoration: BoxDecoration(
          //     color: Color(0xFFd0480a),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Center(
          //     child: Text(
          //       'Access all my episodes',
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: Color(0xffd6dbe2),
          //         fontSize: fontFour,
          //       ),
          //     ),
          //   ),
          // ),
        )
      ]),
    );
  }

///////////////////////////////////////////////////////////lo

  Widget bodyChooseScreen(
      {required BuildContext context,
      required BoxConstraints baseConstraints}) {
    double screenWidth = baseConstraints.maxWidth;
    double screenHeight = baseConstraints.maxHeight;

    return Container(
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: [
          Positioned(
            child: Stack(children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: BaseWidget()
                      .setImageAsset("background.png"), // Đường dẫn đến ảnh
                ),
              ),
              Positioned(
                  top: 0,
                  child: BaseWidget().handleEventBackNavigation(
                      child: Container(
                        padding: EdgeInsets.all(boxBack / 3),
                        width: boxBack,
                        height: boxBack,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: BaseWidget().setImageAsset(
                              'back_white.png'), // Đường dẫn đến ảnh
                        ),
                      ),
                      context: context))
            ]),
          ),
          Positioned(
              bottom: 0,
              // top: screenHeight * 0.42, // Đặt vị trí bên dưới
              // left: 0,
              // right: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.58,
                decoration: BoxDecoration(
                    color: Color(0xFF1f252e),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30), // Bo tròn góc trái trên
                      topRight: Radius.circular(30), //Bo tròn góc phai trên
                    )),
                padding: EdgeInsets.all(10),
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.18,
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 1, color: Colors.white),
                    // ),
                    child: Transform.scale(
                      scale:
                          0.7, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                      child: BaseWidget().setImageAsset(
                          'logo_white.png'), // Đường dẫn đến ảnh của bạn
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: screenHeight * 0.08,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            key = true;
                            chooseScreen = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFe78b34),
                            borderRadius:
                                BorderRadius.circular(20), // Đặt độ bo tròn
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                // Để căn giữa nội dung trong Row
                                child: Center(
                                  // Để căn giữa văn bản
                                  child: Text(
                                    'CREATE FREE ACCOUNT',
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      color: Color(0xffd6dbe2),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Container(
                      width: double.infinity,
                      height: screenHeight * 0.08,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            key = false;
                            chooseScreen = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 2,
                                color: Color(0xFF3b4149)), // Đặt độ bo tròn
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                // Để căn giữa nội dung trong Row
                                child: Center(
                                  // Để căn giữa văn bản
                                  child: Text(
                                    'SIGN IN WITH EMAIL',
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      color: Color(0xffd6dbe2),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.06,
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 1, color: Colors.white),
                    // ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 17,
                              left: 10,
                            ),
                            child: Container(
                              height: 1,
                              decoration: BoxDecoration(
                                color: Color(0xFF3b4149),
                                border: Border.all(
                                    width: 1, color: Color(0xFF3b4149)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 17,
                            ),
                            child: Center(
                              child: Text(
                                'or continue with',
                                style: TextStyle(
                                  fontSize: fontBac,
                                  color: Color(0xff767c86),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 17, right: 10),
                            child: Container(
                              height: 1,
                              decoration: BoxDecoration(
                                color: Color(0xFF3b4149),
                                border: Border.all(
                                    width: 1, color: Color(0xFF3b4149)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.09,
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 1, color: Colors.white),
                    // ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(
                                5), // Adjust the padding as needed
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFF181c1f),
                                border: Border.all(
                                    width: 3, color: Color(0xFF242830)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Transform.scale(
                                scale:
                                    0.6, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                                child: BaseWidget().setImageAsset(
                                    'logo_google.png'), // Đường dẫn đến ảnh của bạn
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
                                color: Color(0xFF181c1f),
                                border: Border.all(
                                    width: 3, color: Color(0xFF242830)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Transform.scale(
                                scale:
                                    0.4, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                                child: BaseWidget().setImageAsset(
                                    'logo_facebook.png'), // Đường dẫn đến ảnh của bạn
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
                                color: Color(0xFF181c1f),
                                border: Border.all(
                                    width: 3, color: Color(0xFF242830)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Transform.scale(
                                scale:
                                    0.5, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                                child: BaseWidget().setImageAsset(
                                    'logo_apple.png'), // Đường dẫn đến ảnh của bạn
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
                                color: Color(0xFF181c1f),
                                border: Border.all(
                                    width: 3, color: Color(0xFF242830)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Transform.scale(
                                scale:
                                    0.6, // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                                child: BaseWidget().setImageAsset(
                                    'logo_twitter.png'), // Đường dẫn đến ảnh của bạn
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.05,
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 1, color: Colors.white),
                    // ),
                    child: Center(
                      // Để căn giữa văn bản
                      child: Text(
                        '@ 2023 VanBac | v1.0.157',
                        style: TextStyle(
                          fontSize: fontBac,
                          color: Color(0xff565a61),
                        ),
                      ),
                    ),
                  )
                ]),
              ))
        ],
      ),
    );
  }

  GestureDetector myLogin({
    required BuildContext context,
    required Widget child,
    required Widget pageTo,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => pageTo,
          ),
        );
      },
      child: child,
    );
  }
}
