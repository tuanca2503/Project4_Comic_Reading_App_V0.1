import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/utils/util_func.dart';

class InteractComicRepository {
  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/interact-manga';

  InteractComicRepository();

  Future<bool> interactComic(String action, String mangaId) async {
    final Response response =
        await dio.post(_apiBase, data: {'action': action, 'mangaId': mangaId});
    // inspect(response);
    if (response.statusCode != 200) {
      debug("///ERROR interactComic: $response///");
      throw Exception(response);
    }
    return response.data;
  }
}
