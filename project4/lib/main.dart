import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/app_theme.dart';
import 'package:project4/models/notification/notification_page_item.dart';
import 'package:project4/models/users/user.dart';
import 'package:project4/screens/main_screen.dart';
import 'package:project4/utils/app_dimension.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/socket_helper.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/utils/string_utils.dart';
import 'package:provider/provider.dart';

import 'config/http_interceptor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storages.initialize();
  GetIt.instance.registerLazySingleton<Dio>(() => Dio());
  GetIt.instance.registerLazySingleton<ScreenProvider>(() => ScreenProvider());

  HttpInterceptor.instance.interceptor();

  final storage = Storages.instance;
  final screenProvider = GetIt.instance<ScreenProvider>();
  User? userLogin = storage.getUser();

  // Splash Screen
  if (storage.isLogin()) {
    String? accessToken = await storage.getAccessToken();
    Helper.debug('accessToken = $accessToken');
    if (accessToken.isHasText) {
      // TODO get user info

      SocketHelper.instance.activate();
    }
  } else {
    // update BottomNavigatorWidget
    // Helper.debug('userLogin = ${userLogin!.username}');
    // screenProvider.updateUserInfo(userLogin!.email);
  }

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
    /*return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comic Reading App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Storages.instance.getDarkMode() ? ThemeMode.dark : ThemeMode.light,
      home: LayoutBuilder(
        builder: (context, constraints) {
          AppDimension.baseConstraints = constraints;
          return const MainScreen();
        },
      ),
    );*/
    return Consumer<ScreenProvider>(builder: (context, provider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Comic Reading App',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode:
            Storages.instance.isDarkMode() ? ThemeMode.dark : ThemeMode.light,
        home: LayoutBuilder(
          builder: (context, constraints) {
            AppDimension.baseConstraints = constraints;
            return const MainScreen();
          },
        ),
      );
    });
  }
}

class ScreenProvider with ChangeNotifier {
  bool _isVisible = true;
  bool isDarkMode = false;

  bool boxDetailDetailsScreen = false;
  bool boxChapterDetailsScreen = true;

  //0 = chapter || 1 = details
  bool buttonDetailsScreen = true;
  String showPartDetailsScreen = '';

  String? email = Storages.instance.getUser()?.email;
  bool showAllChapter = false;

  bool get isVisible => _isVisible;

  NotificationPageItem? notificationPageItem;

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

  void updateNotificationPageItem(NotificationPageItem item) {
    notificationPageItem = item;
    notifyListeners();
  }

  void setIsDarkMode(bool darkMode) {
    Storages.instance.setDarkMode(darkMode).then((value) {
      isDarkMode = darkMode;
      notifyListeners();
    });
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
