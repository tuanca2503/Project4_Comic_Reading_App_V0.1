import 'dart:html';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/comic/page_comic_item.dart';
import 'package:project4/models/comment/page_comment_item.dart';
import 'package:project4/models/page_data.dart';
import 'package:project4/utils/helper.dart';
import 'package:project4/utils/string_utils.dart';

class CommentRepository {
  static CommentRepository? _instance;

  CommentRepository._();

  static CommentRepository get instance {
    _instance ??= CommentRepository._();
    return _instance!;
  }

  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/comments';

  Future<PageData<PageCommentItem>> getAllComment({
    int page = 0,
    int pageSize = 10,
    required String mangaId,
    String? parentCommentId,
  }) async {
    try {
      String apiGet =
          '$_apiBase/free?page=$page&pageSize=$pageSize&mangaId=$mangaId&';
      if (parentCommentId.isHasText) {
        apiGet = '$apiGet&parentCommentId=$parentCommentId';
      }
      final Response response = await dio.get(apiGet);
      // inspect(response);
      if (response.statusCode != 200) {
        Helper.debug("///ERROR getAllComment: ${response.data}///");
        return PageData<PageCommentItem>.empty();
      }
      return PageData<PageCommentItem>.fromJson(
          response.data, (json) => PageCommentItem.fromJson(json));
    } catch (e) {
      Helper.debug("///ERROR getAllComment: $e///");
      throw Exception(e);
    }
  }

  Future<Response?> createOrUpdateComment(
      {String? id,
        required String content,
        String? parentCommentId,
        required String mangaId}) async {
    try {
      final Response response =
      await dio.post('$_apiBase/', data: {
        'email': id,
        'content': content,
        'parentCommentId': parentCommentId,
        'mangaId': mangaId,
      });
      if (response.statusCode != 200) {
        Helper.debug("///ERROR at createOrUpdateComment: ${response.data}///");
        throw Exception(response.data);
      }
      return response;
    } catch (e) {
      Helper.debug("///ERROR at createOrUpdateComment: $e///");
      throw Exception(e);
    }
  }
}
