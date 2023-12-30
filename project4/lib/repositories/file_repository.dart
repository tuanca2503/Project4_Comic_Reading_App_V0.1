import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/utils/helper.dart';

class FileRepository {
  static FileRepository? _instance;

  FileRepository._();

  static FileRepository get instance {
    _instance ??= FileRepository._();
    return _instance!;
  }

  final dio = GetIt.instance<Dio>();
  final String _apiBase = '${Environment.apiUrl}/api/files';

  Future<String> uploadFile(XFile fileData) async {
    try {
      final Response response =
          await dio.post(_apiBase, data: {'file': fileData});
      // inspect(response);
      if (response.statusCode != 200) {
        Helper.debug("///ERROR uploadFile: ${response.data}///");
        throw Exception(response);
      }
      return response.data;
    } catch (e) {
      throw Exception(e);
    }
  }
}
