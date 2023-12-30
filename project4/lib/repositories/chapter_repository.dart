import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/comic/chapter/chapter_detail.dart';
import 'package:project4/models/comic/chapter/page_chapter_item.dart';
import 'package:project4/utils/helper.dart';

class ChapterRepository {
  static ChapterRepository? _instance;

  ChapterRepository._();

  static ChapterRepository get instance {
    _instance ??= ChapterRepository._();
    return _instance!;
  }

  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/chapters';

  Future<ChapterDetail> getChapterComic({required String id}) async {
    try {
      final Response response = await dio.get(
        '$_apiBase/free/$id',
      );
      if (response.statusCode != 200) {
        Helper.debug("///ERROR getChapterComic: ${response.data}///");
        throw Exception(response.data);
      }
      return ChapterDetail.fromJson(response.data);
    } catch (e) {
      Helper.debug("///ERROR getChapterComic: $e///");
      throw Exception(e);
    }
  }

  Future<List<PageChapterItem>> getChapterListByComicId({required String comicId}) async {
    try {
      final Response response = await dio.get(
        '$_apiBase/free/chapter-list/$comicId',
      );
      if (response.statusCode != 200) {
        Helper.debug("///ERROR getChapterComic: ${response.data}///");
        throw Exception(response.data);
      }
      return (response.data as List)
          .map((json) => PageChapterItem.fromJson(json))
          .toList();
    } catch (e) {
      Helper.debug("///ERROR getChapterComic: $e///");
      throw Exception(e);
    }
  }
}
