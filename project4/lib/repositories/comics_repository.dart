import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/comic/comic_book.dart';
import 'package:project4/models/comic/comic_home.dart';
import 'package:project4/models/page_data.dart';
import 'package:project4/utils/util_func.dart';

class ComicsRepository {
  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/mangas';

  ComicsRepository();

  Future<PageData<ComicBook>> getAllComics(
      {String filter = 'CREATED_DATE'}) async {
    final Response response = await dio.get(
      '$_apiBase/free?filter=$filter',
    );
    // inspect(response);
    if (response.statusCode != 200) {
      debug("///ERROR getAllComics: ${response.data}///");
      return PageData<ComicBook>.empty();
    }
    return PageData<ComicBook>.fromJson(
        response.data, (json) => ComicBook.fromJson(json));
    // return PageData<ComicBook>.fromJson(
    //     jsonDecode(const Utf8Decoder().convert(response.bodyBytes)),
    //     (json) => ComicBook.fromJson(json));
  }

  Future<ComicHome> getAllComicsForHome() async {
    final Response response = await dio.get(
      '$_apiBase/free/home',
    );
    if (response.statusCode != 200) {
      debug("///ERROR getAllComicsForHome: ${response.data}///");
      return ComicHome.empty();
    }
    return ComicHome.fromJson(response.data);
  }

  Future<ComicBook> getDetailsComics({required ComicBook thisComicBook}) async {
    try {
      final Response response = await dio.get(
        '$_apiBase/free/${thisComicBook.id}',
      );
      if (response.statusCode != 200) {
        debug("///ERROR getDetailsComics: ${response.data}///");
        throw Exception(response.data);
      }
      thisComicBook.setDetailsDataFromJson(json: response.data);
    } catch (e) {
      debug("///ERROR getDetailsComics catch: $e///");
    }
    return thisComicBook;
  }

  Future<PageData<ComicBook>> getAllFavouriteComics({int page = 0, int pageSize = 10}) async {
    final Response response = await dio.get(
      '$_apiBase/favourite?page=$page&pageSize=$pageSize',
    );
    if (response.statusCode != 200) {
      debug("///ERROR getAllFavouriteComics: ${response.data}///");
      return PageData<ComicBook>.empty();
    }
    return PageData<ComicBook>.fromJson(
        response.data, (json) => ComicBook.fromJson(json));
  }
}
