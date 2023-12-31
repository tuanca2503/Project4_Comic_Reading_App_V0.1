import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project4/config/environment.dart';
import 'package:project4/models/users/user.dart';
import 'package:project4/repositories/auth_repository.dart';
import 'package:project4/utils/storages.dart';
import 'package:project4/utils/string_utils.dart';

import '../models/users/user_login_res.dart';
import '../utils/helper.dart';

enum _AuthorizationPrefix { Bearer, Refresh }

class HttpInterceptor {
  static HttpInterceptor? _instance;

  HttpInterceptor._();

  static HttpInterceptor get instance {
    _instance ??= HttpInterceptor._();
    return _instance!;
  }

  final _dio = GetIt.instance<Dio>();
  final _storage = Storages.instance;
  final Map<String, String> _headers = {
    // 'accept': '*/*',
    'Content-Type': 'application/json',
    // 'ngrok-skip-browser-warning': 'true',
  };
  bool isRefreshToken = false;

  void interceptor() {
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // config url (dotenv, ...)
      if(_storage.isLogin()) {
        String? accessToken = await _storage.getAccessToken();

        bool tokenIsValid = await _checkTokenIsValid();
        if (!tokenIsValid) {
          await _clearToken();
          String? refreshToken = await _storage.getRefreshToken();
          if (refreshToken != null) {
            await _refreshToken();

            // get new token after refresh
            accessToken = await _storage.getAccessToken();
          }
        }

        // Add header when call API
        if (accessToken.isHasText) {
          _headers['Authorization'] =
          '${_AuthorizationPrefix.Bearer.name} $accessToken';
        }
      }
      options.headers = _headers;

      if (!options.path.startsWith('http')) {
        options.path = Environment.apiUrl + options.path;
      }

      // config timeout
      options.connectTimeout = const Duration(seconds: 30);
      options.receiveTimeout = const Duration(seconds: 30);
      return handler.next(options);
    }, onResponse: (Response response, handler) {
      // Do something with response data
      return handler.next(response);
    }, onError: (DioException error, handler) async {
      // String? token = getTokenFromAuthorize(
      //     error.requestOptions.headers['Authorization'].toString());
      // String? refreshToken = await _storage.getRefreshToken();
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
    // update new access token after refresh
    String? newToken = await _storage.getAccessToken();
    if (newToken.isHasText) {
      requestOptions.headers['Authorization'] =
          '${_AuthorizationPrefix.Bearer.name} $newToken';
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
    try {
      Helper.debug('run refresh token');
      String? refreshToken = await _storage.getRefreshToken();
      if (refreshToken.isHasText) {
        _headers['Authorization'] =
            '${_AuthorizationPrefix.Refresh.name} $refreshToken';
      }
      final Response response = await _dio.get(
        '${Environment.apiUrl}/api/auth/free/refresh-token',
        options: Options(headers: _headers),
      );
      if (response.statusCode != 200) {
        Helper.debug("///ERROR _refreshToken: ${response.data}///");
        throw Exception(response.data);
      }
      UserLoginRes userLoginRes = UserLoginRes.fromJson(response.data);
      await _storage.setToken(
          userLoginRes.accessToken, userLoginRes.refreshToken);
      await _storage.setUser(User.fromUserLogin(userLoginRes));
      return true;
    } catch (e) {
      Helper.debug("///ERROR _refreshToken: $e///");
      AuthRepository.instance.logout();
      return false;
    }
  }

  Future<void> _clearToken() async {
    String? accessToken = await _storage.getAccessToken();
    if (accessToken != null) {
      await _storage.removeAccessToken();
    } else {
      await _storage.clearStorage();
    }
  }

  Future<bool> _checkTokenIsValid() async {
    int? accessTokenExp = await _storage.getExpAccessToken();
    if (accessTokenExp == null) return false;
    return DateTime.now().isBefore(
        DateTime.fromMillisecondsSinceEpoch(accessTokenExp * 1000 - 5000));
  }

  String? _getTokenFromAuthorize(String headerAuth) {
    if (headerAuth.startsWith(_AuthorizationPrefix.Bearer.name)) {
      return headerAuth.substring(7);
    }
    return null;
  }
}
