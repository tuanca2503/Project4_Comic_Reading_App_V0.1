import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/repositories/auth_repository.dart';
import 'package:project4/repositories/chapter_repository.dart';
import 'package:project4/repositories/comics_repository.dart';
import 'package:project4/repositories/interact_comic_repository.dart';
import 'package:project4/repositories/user_repository.dart';
import 'package:project4/screens/home_screen.dart';
import 'package:project4/utils/constants.dart';
import 'package:project4/utils/util_func.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/http_interceptor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerLazySingleton<UserRepository>(() => UserRepository());
  GetIt.instance
      .registerLazySingleton<ChapterRepository>(() => ChapterRepository());
  GetIt.instance
      .registerLazySingleton<ComicsRepository>(() => ComicsRepository());
  GetIt.instance.registerLazySingleton<AuthRepository>(() => AuthRepository());
  GetIt.instance.registerLazySingleton<InteractComicRepository>(
      () => InteractComicRepository());
  GetIt.instance.registerLazySingleton<Dio>(() => Dio());
  GetIt.instance.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage());
  // GetIt.instance.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
  GetIt.instance.registerLazySingleton<ScreenProvider>(() => ScreenProvider());

  sharedPreferences = await SharedPreferences.getInstance();

  interceptor();

  final flutterSecureStorage = GetIt.instance<FlutterSecureStorage>();
  final screenProvider = GetIt.instance<ScreenProvider>();

  String? accessToken = await flutterSecureStorage.read(
      key: FlutterSecureStorageEnum.accessToken.name);
  if (checkStringIsNotEmpty(accessToken)) {
    Map<String, dynamic> tokenPayload = convertJwtToken(accessToken!);
    await updateSharedPreferences(tokenPayload);
    screenProvider.updateUserInfo(tokenPayload['email']);
  }

  // runApp(const MyApp());
  runApp(
    ChangeNotifierProvider(
      // create: (context) => ScreenProvider(),
      create: (context) => GetIt.instance<ScreenProvider>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.transparent, // Đặt màu nền của Scaffold là trong suốt
        appBarTheme: AppBarTheme(
          backgroundColor:
              Colors.transparent, // Đặt màu nền của AppBar là trong suốt
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Comic Reading App',
      home: LayoutBuilder(
        builder: (context, constraints) {
          baseConstraints = constraints;
          return const HomeScreen();
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

  bool showBoxSwitch = true;
  String? email = sharedPreferences.getString('email');
  bool showAllChapter = false;
  bool get isVisible => _isVisible;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  void toggleShowAllChapter() {
    showAllChapter = !showAllChapter;
    notifyListeners();
  }

  void updateUserInfo(String? updateEmail) {
    email = updateEmail;
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
