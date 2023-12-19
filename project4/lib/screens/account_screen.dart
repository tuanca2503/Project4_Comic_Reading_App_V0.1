import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/models/app_valid.dart';
import 'package:project4/repositories/auth_repository.dart';
import 'package:project4/screens/base_screen.dart';
import 'package:project4/screens/home_screen.dart';
import 'package:project4/utils/util_func.dart';
import 'package:project4/widgets/base_widget.dart';

import '../models/users/auth.dart';
import '../utils/constants.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen(
      {super.key, this.chooseScreen = false, this.keyAS = false});

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
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email =
      TextEditingController(text: "string@gmail.com");

  final TextEditingController _password = TextEditingController(text: "string");
  final TextEditingController _rePassword = TextEditingController();
  String errorMess = '';

  //////////////////////////////////////
  @override
  void initState() {
    chooseScreen = widget.chooseScreen;
    key = widget.keyAS;
    double screenWidth = baseConstraints.maxWidth;
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
        setAppBar: 3,
        setBottomBar: false,
        setBody: chooseScreen
            ? bodyAccountScreen(key: key, context: context)
            : bodyChooseScreen(context: context));
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
                decoration: const InputDecoration(
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
  Widget bodyAccountScreen({required BuildContext context, bool key = false}) {
    return Container(
      width: baseConstraints.maxWidth,
      height: baseConstraints.maxHeight,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
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
              key ? 'Đăng ký' : 'Đăng nhập',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color(0xffd6dbe2),
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
            padding: const EdgeInsets.only(
                bottom: 0.001), // You can adjust the value as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffd6dbe2),
                    fontSize: fontFour,
                  ),
                ),
                const SizedBox(height: 8.0), // Add some vertical space
                TextField(
                  controller: _email,
                  style: TextStyle(
                      color: const Color(0xffd6dbe2), fontSize: fontSize),
                  decoration: InputDecoration(
                    fillColor: const Color(0xff1f1b19),
                    filled: true,
                    hintText: 'name@gmail.com',
                    hintStyle: TextStyle(
                      color: const Color(0xff49575e),
                      fontSize: fontSize,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF242830),
                        width: 1,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF3b4149), width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    suffixIcon: false
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
                                                                color: const Color(
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
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              padding: const EdgeInsets.all(5),
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..rotateZ(-20 *
                                      (3.14159265358979323846 /
                                          180)) // Xoay 45 độ
                                  ..translate(-5, 0),
                                child: const Icon(
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
                  padding: const EdgeInsets.only(
                      bottom: 0.001), // You can adjust the value as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tên',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffd6dbe2),
                          fontSize: fontFour,
                        ),
                      ),
                      const SizedBox(height: 8.0), // Add some vertical space
                      TextField(
                        controller: _username,
                        style: TextStyle(
                            color: const Color(0xffd6dbe2), fontSize: fontSize),
                        decoration: InputDecoration(
                          fillColor: const Color(0xff1f1b19),
                          filled: true,
                          hintText: 'Your name',
                          hintStyle: TextStyle(
                              color: const Color(0xff49575e),
                              fontSize: fontSize),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF242830), width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
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
            padding: const EdgeInsets.only(
                bottom: 0.001), // You can adjust the value as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mật khẩu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffd6dbe2),
                    fontSize: fontFour,
                  ),
                ),
                const SizedBox(height: 8.0), // Add some vertical space
                TextField(
                  controller: _password,
                  style: TextStyle(
                      color: const Color(0xffd6dbe2), fontSize: fontSize),
                  decoration: InputDecoration(
                    fillColor: const Color(0xff1f1b19),
                    filled: true,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        color: const Color(0xff49575e), fontSize: fontSize),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF242830), width: 1),
                    ),
                    focusedBorder: const OutlineInputBorder(
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
                              title: const Text('Lấy lại mật khẩu'),
                              actions: <Widget>[
                                (_errMess.isNotEmpty || _errMess.isBool)
                                    ? BaseWidget().setText(
                                        txt: _errMess,
                                        color: Colors.redAccent,
                                        fontSize: 14)
                                    : Container(),
                                TextField(
                                  controller: _forgotPass,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: 'Email',
                                    hintText: 'Enter your email',
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Hủy'),
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
                                          try {
                                            await GetIt.instance<
                                                    AuthRepository>()
                                                .forgotPassword(
                                                    email: _forgotPass.text);
                                          } catch (e) {
                                            errorMess = e.toString();
                                          }
                                          Navigator.pop(context);
                                        } else {
                                          setState(() {
                                            _errMess = validMess;
                                          });
                                        }
                                        //
                                      },
                                      child: const Text('Gửi'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        child: Text(
                          'Quên mật khẩu ?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffd45d16),
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
                  padding: const EdgeInsets.only(
                      bottom: 0.001), // You can adjust the value as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nhập lại mật khẩu',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffd6dbe2),
                          fontSize: fontFour,
                        ),
                      ),
                      const SizedBox(height: 8.0), // Add some vertical space
                      TextField(
                        controller: _rePassword,
                        style: TextStyle(
                            color: const Color(0xffd6dbe2), fontSize: fontSize),
                        decoration: InputDecoration(
                          fillColor: const Color(0xff1f1b19),
                          filled: true,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              color: const Color(0xff49575e),
                              fontSize: fontSize),
                          enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF242830), width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
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

        SizedBox(
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
                  padding: const EdgeInsets.all(5),
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
                        border: Border.all(
                            width: 2, color: const Color(0xFF455258)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '<',
                          style: TextStyle(
                              color: const Color(0xffd6dbe2),
                              fontSize: fontBack),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: key
                        ? () async {
                            dynamic validMess = AppValid().isValidAccount(
                                key: key,
                                rePw: _rePassword.text,
                                em: _email.text,
                                pw: _password.text,
                                name: _username.text);
                            //
                            if (validMess is bool && validMess) {
                              try {
                                await GetIt.instance<AuthRepository>()
                                    .registerUser(
                                        email: _email.text,
                                        password: _password.text,
                                        userName: _username.text);
                                await GetIt.instance<AuthRepository>()
                                    .loginUser(
                                        email: _email.text,
                                        password: _password.text);
                                setState(() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  );
                                });
                              } catch (e) {
                                setState(() {
                                  errorMess = "Email đã tồn tại";
                                });
                              }
                            } else {
                              setState(() {
                                errorMess = validMess;
                              });
                            }
                          }
                        : () async {
                            dynamic validMess = AppValid().isValidAccount(
                                key: key, em: _email.text, pw: _password.text);

                            if (validMess is bool && validMess) {
                              Auth auth = await GetIt.instance<AuthRepository>()
                                  .loginUser(
                                      email: _email.text,
                                      password: _password.text);
                              setState(() {
                                if (!checkStringIsNotEmpty(auth.accessToken)) {
                                  errorMess = 'Email hoặc mật khẩu không đúng';
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
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
                        color: const Color(0xFFd98118),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          key
                              ? 'Tạo tài khoản'.toUpperCase()
                              : 'Đăng nhập'.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffd6dbe2),
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

  Widget bodyChooseScreen({required BuildContext context}) {
    double screenWidth = baseConstraints.maxWidth;
    double screenHeight = baseConstraints.maxHeight;

    return SizedBox(
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
                          child: BaseWidget().setIcon(
                              iconData:
                                  Icons.navigate_before), // Đường dẫn đến ảnh
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
                decoration: const BoxDecoration(
                    color: Color(0xFF1f252e),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30), // Bo tròn góc trái trên
                      topRight: Radius.circular(30), //Bo tròn góc phai trên
                    )),
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.18,
                    // decoration: BoxDecoration(
                    //   border: Border.all(width: 1, color: Colors.white),
                    // ),
                    child: Transform.scale(
                      scale: 0.7,
                      // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                      child: BaseWidget().setImageAsset('logo_white.png'),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.08,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // key = true;
                          // chooseScreen = true;
                          key = false;
                          chooseScreen = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFe78b34),
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
                                  // 'Tạo tài khoản',
                                  'Đăng nhập với email',

                                  style: TextStyle(
                                    fontSize: fontSize,
                                    color:
                                        const Color.fromARGB(255, 47, 48, 49),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      height: screenHeight * 0.08,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            // key = false;
                            // chooseScreen = true;
                            key = true;
                            chooseScreen = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 2,
                                color:
                                    const Color(0xFF3b4149)), // Đặt độ bo tròn
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                // Để căn giữa nội dung trong Row
                                child: Center(
                                  // Để căn giữa văn bản
                                  child: Text(
                                    'Tạo tài khoản',

                                    // 'Đăng nhập với email',
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      color: const Color(0xffd6dbe2),
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
                            padding: const EdgeInsets.only(
                              top: 17,
                              left: 10,
                            ),
                            child: Container(
                              height: 1,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3b4149),
                                border: Border.all(
                                    width: 1, color: const Color(0xFF3b4149)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 17,
                            ),
                            child: Center(
                              child: Text(
                                'Hoặc đăng nhập bằng',
                                style: TextStyle(
                                  fontSize: fontBac,
                                  color: const Color(0xff767c86),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 17, right: 10),
                            child: Container(
                              height: 1,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3b4149),
                                border: Border.all(
                                    width: 1, color: const Color(0xFF3b4149)),
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
                            padding: const EdgeInsets.all(
                                5), // Adjust the padding as needed
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF181c1f),
                                border: Border.all(
                                    width: 3, color: const Color(0xFF242830)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Transform.scale(
                                scale: 0.6,
                                // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                                child: BaseWidget().setImageAsset('logo_google.png'),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF181c1f),
                                border: Border.all(
                                    width: 3, color: const Color(0xFF242830)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Transform.scale(
                                scale: 0.4,
                                // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                                child: BaseWidget().setImageAsset('logo_facebook.png'),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF181c1f),
                                border: Border.all(
                                    width: 3, color: const Color(0xFF242830)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Transform.scale(
                                scale: 0.5,
                                // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                                child: BaseWidget().setImageAsset('logo_apple.png'),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF181c1f),
                                border: Border.all(
                                    width: 3, color: const Color(0xFF242830)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Transform.scale(
                                scale: 0.6,
                                // Đặt tỉ lệ thu nhỏ hình ảnh (0.7 là 70% kích thước gốc)
                                child: BaseWidget().setImageAsset('logo_twitter.png'),
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
                          color: const Color(0xff565a61),
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
