import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/genres.dart';
import 'package:project4/utils/helper.dart';

class GenresRepository {
  static GenresRepository? _instance;

  GenresRepository._();

  static GenresRepository get instance {
    _instance ??= GenresRepository._();
    return _instance!;
  }

  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/genres';

  Future<List<Genres>> getAllGenres() async {
    try {
      final Response response = await dio.get(
        '$_apiBase/free',
      );
      // inspect(response);
      if (response.statusCode != 200) {
        Helper.debug("///ERROR getAllGenres: ${response.data}///");
        return [];
      }
      return (response.data as List)
          .map((json) => Genres.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
