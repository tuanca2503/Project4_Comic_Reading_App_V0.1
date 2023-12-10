import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/models/user.dart';
import 'package:project4/repositories/user_repository.dart';
import 'package:project4/screens/home_screen.dart';

void main() {
  GetIt.instance.registerLazySingleton<UserRepository>(() => UserRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comic Reading App',
      home: LayoutBuilder(
        builder: (context, constraints) {
          return HomeScreen(
            baseConstraints: constraints,
          );
        },
      ),
    );
  }
}
