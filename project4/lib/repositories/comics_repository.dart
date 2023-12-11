import 'dart:io';

import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get.dart';
import 'package:project4/config.dart';
import 'package:project4/models/comic_book.dart';
import 'package:project4/models/handle_response_api.dart';
import 'package:project4/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';

class ComicsRepository {
  List<ComicBook> _comicBook = ComicBook().Seed();
  ComicsRepository({required this.ip, required this.port});
  String ip;
  String port;
  List<ComicBook> getComicsData() {
    // Make an API call to fetch user data using the stored token

    return _comicBook;
  }

  Future<ResultCallAPI> getAllComics({String filter = 'CREATED_DATE'}) async {
    try {
      final ResultCallAPI response = await HandleResponseAPI().callAPI(
          method: 'get',
          ip: ip,
          port: port,
          api: 'api/mangas/free?filter=$filter');
      if (response.check) {
        List<dynamic> jsonArray = jsonDecode(response.response.body)['data'];
        _comicBook = ComicBook().getAllDataFromJson(jsons: jsonArray);
///////////////////////
        // await getDetailsComics(id: _comicBook.first.id);
      }
      response.data = _comicBook;

      return response;
    } catch (e) {
      print("///ERROR: $e///");
      return HandleResponseAPI().getErrReturn(e);
    }
  }

  Future<ResultCallAPI> getDetailsComics({required String id}) async {
    try {
      final ResultCallAPI response = await HandleResponseAPI().callAPI(
          method: 'get', ip: ip, port: port, api: 'api/mangas/free/$id');
      if (response.check) {
        _comicBook
            .firstWhere((cmb) => cmb.id == id)
            .getDetailsDataFromJson(json: jsonDecode(response.response.body));
      }

      return response;
    } catch (e) {
      print("///ERROR: $e///");
      return HandleResponseAPI().getErrReturn(e);
    }
  }
}
