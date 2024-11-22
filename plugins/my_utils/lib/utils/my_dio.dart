import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class MyDio {
  static final MyDio _instance = MyDio._internal();
  factory MyDio() => _instance;
  MyDio._internal();

  CancelToken cancelTokenPublic = CancelToken();
  Dio? _dio;

  bool get isInitialized => _dio != null;

  static MyDio initialize({
    BaseOptions Function(BaseOptions options)? baseOptions,
    Map<String, dynamic>? headers,
    Future<void> Function(Response<dynamic> response)? onResponse,
  }) {
    if (_instance.isInitialized) {
      log("⚠️ MyDio 已经初始化过...");
      return _instance;
    }
    return _instance._initialize(baseOptions: baseOptions, headers: headers, onResponse: onResponse);
  }

  MyDio _initialize({
    BaseOptions Function(BaseOptions options)? baseOptions,
    Map<String, dynamic>? headers,
    Future<void> Function(Response<dynamic> response)? onResponse,
  }) {
    final options = baseOptions?.call(BaseOptions());
    _dio = Dio(options ?? BaseOptions());
    _dio!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers.addAll(headers ?? {});
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        await onResponse?.call(response);
        return handler.next(response);
      },
      onError: (DioException err, handler) {
        return handler.reject(err);
      },
    ));
    return this;
  }

  Dio get dio {
    if (!isInitialized) {
      throw StateError("❌ MyDio 未初始化，请先调用 MyDio.initialize()");
    }
    return _dio!;
  }

  void cancel() {
    cancelTokenPublic.cancel();
  }

  void getNewCancelToken() {
    if (cancelTokenPublic.isCancelled) {
      cancelTokenPublic = CancelToken();
    }
  }

  void _logError(DioException err) {
    String headers = const JsonEncoder.withIndent('  ').convert(err.requestOptions.headers);
    String data = const JsonEncoder.withIndent('  ').convert(err.requestOptions.data ?? err.requestOptions.queryParameters);
    log("❌" * 80);
    log("❌ 请求地址 => ${err.requestOptions.uri}");
    log("❌ 请求方式 => ${err.requestOptions.method}");
    log("❌ 请求头${headers == '{}' ? ' => $headers': ':\n$headers'}");
    log("❌ 请求参数${data == '{}' ? ' => $data': ':\n$data'}");
    log("❌ 错误信息 => ${err.message}");
    log("❌ ${err.error}");
    log("❌" * 80);
  }

  void _logSuccess(Response response) {
    String headers = const JsonEncoder.withIndent('  ').convert(response.requestOptions.headers);
    String parameters = const JsonEncoder.withIndent('  ').convert(response.requestOptions.data ?? response.requestOptions.queryParameters);
    String data = const JsonEncoder.withIndent('  ').convert(response.data);

    log("✅" * 80);
    log("✅ 请求地址 => ${response.requestOptions.uri}");
    log("✅ 请求方式 => ${response.requestOptions.method}");
    log("✅ 请求头${headers == '{}' ? ' => $headers': ':\n$headers'}");
    log("✅ 请求参数${parameters == '{}' ? ' => $parameters': ':\n$parameters'}");
    log("✅ 返回数据${data == '{}' ? ' => $data': ':\n$data'}");
    log("✅" * 80);
  }

  Future<void> get<T>({
    String path = '',
    Function(dynamic)? onSuccess,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(DioException)? onError,
  }) async {
    try {
      final response = await dio.get(path,
        queryParameters: data,
        cancelToken: cancelToken ?? cancelTokenPublic,
        onReceiveProgress: onReceiveProgress,
      );
      _logSuccess(response);
      onSuccess?.call(response.data);
    } on DioException catch (err) {
      _logError(err);
      onError?.call(err);
    }
  }

  Future<void> post<T>({
    String path = '',
    Function(dynamic data)? onSuccess,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    void Function(DioException err)? onError,
  }) async {
    try {
      final response = await dio.post(path,
        data: data,
        cancelToken: cancelToken ?? cancelTokenPublic,
      );
      _logSuccess(response);
      onSuccess?.call(response.data);
    } on DioException catch (err) {
      _logError(err);
      onError?.call(err);
    }
  }

  Future<void> upload<T>({
    String path = '',
    Function(dynamic)? onSuccess,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(DioException err)? onError,
  }) async {
    try {
      final response = await dio.post(path,
        data: data == null ? null : FormData.fromMap(data),
        cancelToken: cancelToken ?? cancelTokenPublic,
        options: Options(contentType: 'multipart/form-data'),
        onSendProgress: onSendProgress,
      );
      _logSuccess(response);
      onSuccess?.call(response.data);
    } on DioException catch (err) {
      _logError(err);
      onError?.call(err);
    }
  }
}