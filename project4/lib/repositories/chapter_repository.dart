import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/comic/comic_book.dart';
import 'package:project4/utils/util_func.dart';

class ChapterRepository {
  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/chapters';

  ChapterRepository();

  Future<ChapterComicBook> getChapterComic(
      {required ChapterComicBook chapter}) async {
    try {
      final Response response = await dio.get(
        '$_apiBase/free/${chapter.id}',
      );
      if (response.statusCode != 200) {
        debug("///ERROR getChapterComic: ${response.data}///");
        throw Exception(response.data);
      }
      chapter.setDetailsChapter(json: response.data);
    } catch (e) {
      debug("///ERROR getChapterComic: $e///");
    }
    return chapter;
  }
}
