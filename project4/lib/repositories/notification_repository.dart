import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/notification/notification_page_item.dart';
import 'package:project4/models/page_data.dart';
import 'package:project4/utils/helper.dart';

class NotificationRepository {
  static NotificationRepository? _instance;
  NotificationRepository._();

  static NotificationRepository get instance {
    _instance ??= NotificationRepository._();
    return _instance!;
  }


  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/notifications';

  Future<PageData<NotificationPageItem>> getAllNotification({int page = 0, int pageSize = 10, bool hasRead = true}) async {
    try {
      final Response response = await dio.get(
        '$_apiBase?page=$page&pageSize=$pageSize&hasRead=$hasRead',
      );
      // inspect(response);
      if (response.statusCode != 200) {
        Helper.debug("///ERROR getAllNotification: ${response.data}///");
        return PageData<NotificationPageItem>.empty();
      }
      return PageData<NotificationPageItem>.fromJson(
          response.data, (json) => NotificationPageItem.fromJson(json));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      final Response response = await dio.post(
        '$_apiBase/read', data: {'ids': [id]}
      );
      // inspect(response);
      if (response.statusCode != 200) {
        Helper.debug("///ERROR markAsRead: ${response.data}///");
        throw Exception(response);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      final Response response = await dio.post(
          '$_apiBase/delete', data: {'ids': [id]}
      );
      // inspect(response);
      if (response.statusCode != 200) {
        Helper.debug("///ERROR delete: ${response.data}///");
        throw Exception(response);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final Response response = await dio.post(
          '$_apiBase/read-all', data: {}
      );
      if (response.statusCode != 200) {
        Helper.debug("///ERROR markAllAsRead: ${response.data}///");
        throw Exception(response);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

    Future<void> deleteAll() async {
      try {
        final Response response = await dio.post(
            '$_apiBase/delete-all', data: {}
        );
        // inspect(response);
        if (response.statusCode != 200) {
          Helper.debug("///ERROR deleteAll: ${response.data}///");
          throw Exception(response);
        }
      } catch (e) {
        throw Exception(e);
      }
    }
}
