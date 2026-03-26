import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:upd8s/core/helper/endpoint.dart';
import 'package:upd8s/core/helper/secure_storage.dart';
import 'package:upd8s/routes/app_router.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';




class ApiClient {
  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(seconds: 50),
        receiveTimeout: const Duration(seconds: 50),
      ),
    );

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(onRequest: _onRequest, onError: _onError),
    );
  }

  static final ApiClient instance = ApiClient._internal();
  late final Dio dio;

  bool _isRefreshing = false;
  final List<Future<void> Function()> _retryQueue = [];

  // =========================
  // REQUEST INTERCEPTOR
  // =========================
  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final useToken = options.extra['useToken'] ?? true;
    final useTempToken = options.extra['useTempToken'] ?? false;

    String? token;

    if (useTempToken) {
      token = await SecureStorage.instance.getTempSignupToken();
    } else if (useToken) {
      token = await SecureStorage.instance.getToken();
    }

    if (token != null && !_isAuthEndpoint(options.path)) {
      options.headers["Authorization"] = "Bearer $token";
    }

    print('════════════════════════════════════════');
    print('[REQUEST] ${options.method} ${options.uri}');
    print('Headers: ${options.headers}');
    print('Token: ${token ?? "No token"}');
    print('Body: ${options.data}');
    print('Extras: ${options.extra}');
    print('════════════════════════════════════════');

    handler.next(options);
  }

  // =========================
  // ERROR INTERCEPTOR
  // =========================
  Future<void> _onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final status = error.response?.statusCode;

    if ((status == 401 || status == 403) &&
        !_isAuthEndpoint(error.requestOptions.path)) {
      final requestOptions = error.requestOptions;

      if (_isRefreshing) {
        _retryQueue.add(() async {
          final newToken = await SecureStorage.instance.getToken();
          requestOptions.headers["Authorization"] = "Bearer $newToken";
          await dio.fetch(requestOptions);
        });
        return;
      }

      _isRefreshing = true;

      try {
        final refreshed = await _refreshToken();
        if (!refreshed) {
          _logout();
          return;
        }

        final newToken = await SecureStorage.instance.getToken();
        requestOptions.headers["Authorization"] = "Bearer $newToken";

        final response = await dio.fetch(requestOptions);
        handler.resolve(response);

        for (final retry in _retryQueue) {
          await retry();
        }
        _retryQueue.clear();
      } catch (_) {
        _logout();
      } finally {
        _isRefreshing = false;
      }
      return;
    }

    handler.next(error);
  }

  // =========================
  // REFRESH TOKEN
  // =========================
  Future<bool> _refreshToken() async {
    final refreshToken = await SecureStorage.instance.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final response = await dio.post(
        Endpoints.refreshToken,
        data: {"refreshToken": refreshToken},
        options: Options(headers: {"Authorization": null}),
      );

      final newToken = response.data["data"]["token"];
      await SecureStorage.instance.saveToken(newToken);
      return true;
    } catch (_) {
      return false;
    }
  }

  bool _isAuthEndpoint(String path) {
    return path.contains(Endpoints.login) ||
        path.contains(Endpoints.register) ||
        path.contains(Endpoints.refreshToken);
  }

  void _logout() async {
    await SecureStorage.instance.clearAll();

    final context = navigatorKey.currentContext;
    if (context != null) {
      // context.go(AppRoute.login.path);
    }
  }

  // =========================
  // HTTP METHODS
  // =========================
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool useToken = true,
  }) {
    options ??= Options();
    options.extra = {...?options.extra, 'useToken': useToken};
    return dio.get(path, queryParameters: queryParameters, options: options);
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Options? options,
    bool useToken = true,
  }) {
    options ??= Options();
    options.extra = {...?options.extra, 'useToken': useToken};
    return dio.post(path, data: data, options: options);
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Options? options,
    bool useToken = true,
  }) {
    options ??= Options();
    options.extra = {...?options.extra, 'useToken': useToken};
    return dio.put(path, data: data, options: options);
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Options? options,
    bool useToken = true,
  }) {
    options ??= Options();
    options.extra = {...?options.extra, 'useToken': useToken};
    return dio.delete(path, data: data, options: options);
  }
}
