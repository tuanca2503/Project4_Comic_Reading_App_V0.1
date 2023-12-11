import 'package:project4/config.dart';
import 'package:project4/repositories/comics_repository.dart';
import 'package:project4/repositories/user_repository.dart';

class BaseRepository {
  String ip = AppConfig.apiIP;
  String port = AppConfig.apiPort;
  UserRepository userRepository = UserRepository(ip: 'ip', port: 'port');
  ComicsRepository comicsRepository = ComicsRepository(ip: 'ip', port: 'port');
  BaseRepository() {
    userRepository = UserRepository(ip: ip, port: port);
    comicsRepository = ComicsRepository(ip: ip, port: port);
  }
}
