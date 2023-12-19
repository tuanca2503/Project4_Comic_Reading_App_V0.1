import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/utils/constants.dart';

import '../models/users/auth.dart';
import '../utils/util_func.dart';

final _dio = GetIt.instance<Dio>();
final _flutterSecureStorage = GetIt.instance<FlutterSecureStorage>();
Map<String, String> _headers = {
  // 'accept': '*/*',
  'Content-Type': 'application/json',
  // 'ngrok-skip-browser-warning': 'true',
};
bool isRefreshToken = false;

void interceptor() {
  _dio.interceptors
      .add(InterceptorsWrapper(onRequest: (options, handler) async {
    // config url (dotenv, ...)
    String? accessToken = await _flutterSecureStorage.read(
        key: FlutterSecureStorageEnum.accessToken.name);

    bool tokenIsValid = await checkTokenIsValid();
    if (!tokenIsValid) {
      await _clearToken();
      String? refreshToken = await _flutterSecureStorage.read(
          key: FlutterSecureStorageEnum.refreshToken.name);
      if (refreshToken != null) {
        await _refreshToken();
        accessToken = await _flutterSecureStorage.read(
            key: FlutterSecureStorageEnum.accessToken.name);
      }
    }

    if (!options.path.startsWith('http')) {
      options.path = Environment.apiUrl + options.path;
    }

    // config timeout
    options.connectTimeout = const Duration(seconds: 30);
    options.receiveTimeout = const Duration(seconds: 30);

    // Add header when call API

    if (checkStringIsNotEmpty(accessToken)) {
      _headers['Authorization'] = '${AuthorizationPrefix.Bearer.name} $accessToken';
    }
    options.headers = _headers;
    return handler.next(options);
  }, onResponse: (Response response, handler) {
    // Do something with response data
    return handler.next(response);
  }, onError: (DioException error, handler) async {
    // String? token = getTokenFromAuthorize(
    //     error.requestOptions.headers['Authorization'].toString());
    // String? refreshToken = await _flutterSecureStorage.read(
    //     key: FlutterSecureStorageEnum.refreshToken.name);
    //
    // if (error.response?.statusCode == 401 &&
    //     token != null &&
    //     DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(
    //         convertJwtToken(token)['exp'] * 1000))) {
    //   await clearToken();
    //   if (refreshToken != null) {
    //     bool result = await _refreshToken();
    //     if (result) {
    //       return handler.resolve(await _retry(error.requestOptions));
    //     }
    //   }
    // }
    return handler.next(error);
  }));
}

Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  Dio dio = Dio();
  // handle before retry, examples update token, ...
  String? newToken = await _flutterSecureStorage.read(
      key: FlutterSecureStorageEnum.accessToken.name);
  if (checkStringIsNotEmpty(newToken)) {
    requestOptions.headers['Authorization'] = '${AuthorizationPrefix.Bearer.name} $newToken';
  }
  // Clone RequestOptions from root requestOptions
  RequestOptions newOptions = requestOptions.copyWith();

  try {
    // Convert RequestOptions to Options
    Options options = Options(
      method: newOptions.method,
      headers: newOptions.headers,
      receiveTimeout: newOptions.receiveTimeout,
      sendTimeout: newOptions.sendTimeout,
      extra: newOptions.extra,
      responseType: newOptions.responseType,
      contentType: newOptions.contentType,
      validateStatus: newOptions.validateStatus,
      receiveDataWhenStatusError: newOptions.receiveDataWhenStatusError,
      followRedirects: newOptions.followRedirects,
      maxRedirects: newOptions.maxRedirects,
      requestEncoder: newOptions.requestEncoder,
      responseDecoder: newOptions.responseDecoder,
    );

    // retry with new option
    return await dio.request<dynamic>(
      newOptions.path,
      data: newOptions.data,
      queryParameters: newOptions.queryParameters,
      options: options,
      onReceiveProgress: newOptions.onReceiveProgress,
    );
  } catch (e) {
    rethrow;
  }
}

Future<bool> _refreshToken() async {
  Auth auth = Auth();
  try {
    debug('run refresh token');
    String? refreshToken = await _flutterSecureStorage.read(
        key: FlutterSecureStorageEnum.refreshToken.name);
    if (checkStringIsNotEmpty(refreshToken)) {
      _headers['Authorization'] = '${AuthorizationPrefix.Refresh.name} $refreshToken';
    }
    final Response response = await _dio.get(
      '${Environment.apiUrl}/api/auth/free/refresh-token',
      options: Options(headers: _headers),
    );
    if (response.statusCode != 200) {
      debug("///ERROR _refreshToken: ${response.data}///");
      throw Exception(response.data);
    }
    auth = Auth.fromJson(response.data);
    await updateTokenStorage(auth.accessToken, auth.refreshToken);
    Map<String, dynamic> tokenPayload = convertJwtToken(auth.accessToken);
    await updateSharedPreferences(tokenPayload);
    return true;
  } catch (e) {
    debug("///ERROR _refreshToken: $e///");
    return false;
  }
}

Future<void> _clearToken() async {
  String? accessToken = await _flutterSecureStorage.read(
      key: FlutterSecureStorageEnum.accessToken.name);
  if (accessToken != null) {
    await _flutterSecureStorage.delete(
        key: FlutterSecureStorageEnum.accessToken.name);
  } else {
    await _flutterSecureStorage.delete(
        key: FlutterSecureStorageEnum.refreshToken.name);
    await clearAllSharedPreferences();
  }
}

Future<bool> checkTokenIsValid() async {
  String? accessToken = await _flutterSecureStorage.read(
      key: FlutterSecureStorageEnum.accessToken.name);
  if (accessToken == null) return false;

  final Map<String, dynamic> payloadData = convertJwtToken(accessToken);
  return DateTime.now()
      .isBefore(DateTime.fromMillisecondsSinceEpoch(payloadData['exp'] * 1000 - 5000));
}

String? getTokenFromAuthorize(String headerAuth) {
  if (headerAuth.startsWith(AuthorizationPrefix.Bearer.name)) {
    return headerAuth.substring(7);
  }
  return null;
}
