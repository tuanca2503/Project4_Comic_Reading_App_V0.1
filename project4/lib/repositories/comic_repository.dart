import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/comic/detail_comic.dart';
import 'package:project4/models/comic/page_comic_item.dart';
import 'package:project4/models/page_data.dart';
import 'package:project4/utils/helper.dart';

class ComicRepository {
  static ComicRepository? _instance;

  ComicRepository._();

  static ComicRepository get instance {
    _instance ??= ComicRepository._();
    return _instance!;
  }

  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/mangas';

  Future<PageData<PageComicItem>> getAllComics({
    String filter = 'CREATED_DATE',
    int page = 0,
    int pageSize = 10,
    String mangaName = '',
    List<String>? genresIds,
  }) async {
    try {
      String apiGet =
          '$_apiBase/free?filter=$filter&page=$page&pageSize=$pageSize&mangaName=$mangaName';
      if (genresIds != null && genresIds.isNotEmpty) {
        apiGet = '$apiGet&genresIds=${genresIds.join(",")}';
      }
      final Response response = await dio.get(apiGet);
      // inspect(response);
      if (response.statusCode != 200) {
        Helper.debug("///ERROR getAllComics: ${response.data}///");
        return PageData<PageComicItem>.empty();
      }
      return PageData<PageComicItem>.fromJson(
          response.data, (json) => PageComicItem.fromJson(json));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<DetailComic> getDetailsComics({required String id}) async {
    try {
      final Response response = await dio.get(
        '$_apiBase/free/$id',
      );
      if (response.statusCode != 200) {
        Helper.debug("///ERROR getDetailsComics: ${response.data}///");
        throw Exception(response.data);
      }
      return DetailComic.fromJson(response.data);
    } catch (e) {
      Helper.debug("///ERROR getDetailsComics catch: $e///");
      throw Exception(e);
    }
  }

  Future<PageData<PageComicItem>> getAllHistoryComics(
      {int page = 0, int pageSize = 10, required String action}) async {
    try {
      final Response response = await dio.get(
        '$_apiBase/history?page=$page&pageSize=$pageSize&action=$action',
      );
      if (response.statusCode != 200) {
        Helper.debug("///ERROR getAllFavouriteComics: ${response.data}///");
        return PageData<PageComicItem>.empty();
      }
      return PageData<PageComicItem>.fromJson(
          response.data, (json) => PageComicItem.fromJson(json));
    } catch (e) {
      throw Exception(e);
    }
  }
}
