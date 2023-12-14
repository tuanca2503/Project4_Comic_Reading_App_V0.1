import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/models/handle_response_api.dart';
import 'package:project4/models/user.dart';
import 'package:project4/repositories/base_repository.dart';
import 'package:project4/repositories/user_repository.dart';
import 'package:project4/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  GetIt.instance.registerLazySingleton<BaseRepository>(() => BaseRepository());

  // runApp(const MyApp());
  runApp(
    ChangeNotifierProvider(
      create: (context) => ScreenProvider(),
      child: MyApp(),
    ),
  );
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
            baseRepository: GetIt.instance<BaseRepository>(),
            baseConstraints: constraints,
          );
        },
      ),
    );
  }
}

class ScreenProvider with ChangeNotifier {
  bool _isVisible = true;
  //
  bool boxDetailDetailsScreen = false;
  bool boxChapterDetailsScreen = true;
  //0 = chapter || 1 = details
  bool buttonDetailsScreen = true;
  String showPartDetailsScreen = '';
  //
  bool showBoxSwitch = true;

  bool get isVisible => _isVisible;
  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  void toggleDetailsScreen({required int showButton}) {
    switch (showButton) {
      case 0:
        boxChapterDetailsScreen = true;
        boxDetailDetailsScreen = false;
        break;

      case 1:
        boxChapterDetailsScreen = false;
        boxDetailDetailsScreen = true;
        break;
    }
    // boxDetailDetailsScreen = !boxDetailDetailsScreen;
    // boxChapterDetailsScreen = !boxChapterDetailsScreen;

    notifyListeners();
  }

  void toggleShowPart(String part) {
    if (showPartDetailsScreen == part) {
      showPartDetailsScreen = '';
    } else {
      showPartDetailsScreen = part;
    }
    notifyListeners();
  }
}
