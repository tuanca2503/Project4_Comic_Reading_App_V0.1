// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';

// class LoginPage extends StatelessWidget {
//   final FacebookLogin facebookLogin = FacebookLogin();

//   Future<void> _login() async {
//     final FacebookLoginResult result = await facebookLogin.logIn(['email']);

//     switch (result.status) {
//       case FacebookLoginStatus.loggedIn:
//         print('Đăng nhập thành công: ${result.accessToken.token}');
//         break;
//       case FacebookLoginStatus.cancelledByUser:
//         print('Đăng nhập bị hủy bởi người dùng');
//         break;
//       case FacebookLoginStatus.error:
//         print('Lỗi đăng nhập: ${result.errorMessage}');
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Đăng nhập bằng Facebook'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _login,
//           child: Text('Đăng nhập bằng Facebook'),
//         ),
//       ),
//     );
//   }
// }
