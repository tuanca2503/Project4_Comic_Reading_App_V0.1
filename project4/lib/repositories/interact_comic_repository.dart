import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/utils/helper.dart';

class InteractComicRepository {
  static InteractComicRepository? _instance;
  InteractComicRepository._();

  static InteractComicRepository get instance {
    _instance ??= InteractComicRepository._();
    return _instance!;
  }


  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/interact-manga';

  Future<bool> interactComic(String action, String mangaId) async {
    try {
      final Response response =
      await dio.post(_apiBase, data: {'action': action, 'mangaId': mangaId});
      // inspect(response);
      if (response.statusCode != 200) {
        Helper.debug("///ERROR interactComic: $response///");
        throw Exception(response);
      }
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
