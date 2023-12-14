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
      create: (context) => VisibilityProvider(),
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

class VisibilityProvider with ChangeNotifier {
  bool _isVisible = true;

  bool get isVisible => _isVisible;
  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}

class DetailsProviderScreen with ChangeNotifier {
  bool _isVisible = true;

  bool get isVisible => _isVisible;
  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
