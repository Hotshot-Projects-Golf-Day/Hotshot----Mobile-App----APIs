import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:upd8s/core/helper/endpoint.dart';
import 'package:upd8s/core/helper/secure_storage.dart';
import 'package:upd8s/routes/app_router.dart';

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

  // =========================
  // REQUEST INTERCEPTOR
  // =========================
  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final useToken = options.extra['useToken'] ?? true;

    if (useToken && !_isAuthEndpoint(options.path)) {
      final token = await SecureStorage.instance.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

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

    // 403 on any protected endpoint → force logout immediately
    if (status == 403 && !_isAuthEndpoint(error.requestOptions.path)) {
      await _logout();
      handler.next(error);
      return;
    }

    handler.next(error);
  }

  // =========================
  // LOGOUT
  // =========================
  Future<void> _logout() async {
    await SecureStorage.instance.clearAll();
    final context = navigatorKey.currentContext;
    if (context != null) {
      context.go(AppRoute.login.path);
    }
  }

  // =========================
  // HELPERS
  // =========================
  bool _isAuthEndpoint(String path) {
    return path.contains(Endpoints.login) ||
        path.contains(Endpoints.register) ||
        path.contains(Endpoints.refreshToken);
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
