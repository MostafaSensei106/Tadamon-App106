import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bulka/core/assets/asset_translations.dart';
import 'package:bulka/core/shared/entity/token_entity.dart';
import 'package:bulka/core/utils/constant/api_constance.dart';
import 'package:bulka/core/utils/home_utilites.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// A helper class for making HTTP requests using Dio.
/// Supports caching, retries, and running requests in isolates.
class DioHelper extends Equatable {
  const DioHelper._();

  /// Singleton instance of Dio
  static late Dio _dio;

  /// Cache store for request caching
  static late CacheStore _cacheStore;

  /// Default cache options
  static late CacheOptions _cacheOptions;

  /// Request queue for managing concurrent requests
  static final _requestQueue = Queue<Future<Response>>();
  static const _maxConcurrentRequests = 4;
  static int _activeRequests = 0;

  /// Retry delays with exponential backoff
  static const _retryDelays = [
    Duration(milliseconds: 100), // Fast first retry
    Duration(seconds: 1), // 1s
    Duration(seconds: 2), // 2s
    Duration(seconds: 4), // 4s
    Duration(seconds: 8), // 8s
    Duration(seconds: 16), // 16s
    Duration(seconds: 32), // 32s
    Duration(seconds: 64), // 64s
    Duration(seconds: 120), // 2m
    Duration(seconds: 300), // 5m
    
  ];

  /// Initialize the DioHelper with default configuration
  static Future<void> init() async {
    // Initialize cache store
    final dir = await getTemporaryDirectory();
    _cacheStore = HiveCacheStore(
      dir.path,
      hiveBoxName: 'dio_cache',
    );

    // Configure cache options
    _cacheOptions = CacheOptions(
      store: _cacheStore,
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      keyBuilder: (options) {
        return options.uri.toString();
      },
    );

    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstance.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          "Access-Control-Allow-Origin": "*",
          'Cache-Control': 'public, max-age=604800', // 7 days
          'Pragma': 'cache',
          'Authorization': 'Bearer ${getToken()?.token}',
        },
        contentType: 'application/json',
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    // Add logging interceptor first
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          enabled: true,
          maxWidth: 90,
        ),
      );
    }

    // Add other interceptors
    _dio.interceptors.addAll([
      RetryInterceptor(
        dio: _dio,
        logPrint: log,
        retries: 20,
        retryDelays: _retryDelays,
        retryableExtraStatuses: {408, 429, 500, 503},
      ),
      DioCacheInterceptor(options: _cacheOptions),
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = getToken();
          if (token != null) {
            options.headers["Authorization"] = "Bearer ${token.token}";
          }
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          await _logResponse(response, DateTime.now());
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Handle token refresh here if needed
          }
          return handler.next(error);
        },
      ),
    ]);

    if (kDebugMode) {
      log('🚀 DioHelper initialized with ${_dio.interceptors.length} interceptors:');
      for (var interceptor in _dio.interceptors) {
        log('  • ${interceptor.runtimeType}');
      }
    }
  }

  /// Check internet connectivity
  /// TODO: Check this function
  static Future<bool> _checkConnectivity() async {
    return true;
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      }

      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<void> _logResponse(Response response, DateTime startTime) async {
    if (!kDebugMode) return;

    final duration = DateTime.now().difference(startTime);
    final responseSize = response.data.toString().length;
    final formattedSize = _formatSize(responseSize);
    final statusEmoji = _getStatusEmoji(response.statusCode ?? 0);

    log('\n📊 Request Stats ${response.requestOptions.method} ${response.requestOptions.path}');
    log('⏱️  Duration: ${duration.inMilliseconds}ms');
    log('💾 Size: $formattedSize');
    log('$statusEmoji Status: ${response.statusCode}');

    if (response.headers.map.isNotEmpty) {
      log('📋 Headers:');
      response.headers.map.forEach((key, value) {
        log('  • $key: ${value.join(", ")}');
      });
    }
    log('\n Request Body \n');
    log('\n\n');

    if (kDebugMode && response.data != null) {
      log('📦 Response Data Preview:');
      printWrapped(response.data.toString());
    }
  }

  /// Format size in bytes to human readable format
  static String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Get appropriate emoji for HTTP status code
  static String _getStatusEmoji(int statusCode) {
    if (statusCode >= 200 && statusCode < 300) return '✅';
    if (statusCode >= 300 && statusCode < 400) return '↪️';
    if (statusCode >= 400 && statusCode < 500) return '⚠️';
    if (statusCode >= 500) return '❌';
    return '❓';
  }

  static void printWrapped(String text) {
    final pattern = RegExp('.{1,100}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => log(match.group(0).toString()));
  }

  /// Truncate long strings for logging

  /// Queue management for concurrent requests
  static Future<Response> _enqueueRequest(Future<Response> Function() request) async {
    _requestQueue.add(request());
    while (_activeRequests >= _maxConcurrentRequests) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    _activeRequests++;
    try {
      return await _requestQueue.removeFirst();
    } finally {
      _activeRequests--;
    }
  }

  /// Determine if a request should be retried based on the error
  static Future<bool> _shouldRetry(DioException error) async {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return true;
    }

    final statusCode = error.response?.statusCode;
    if (statusCode != null) {
      return statusCode == 408 || // Request Timeout
          statusCode == 429 || // Too Many Requests
          statusCode == 500 || // Internal Server Error
          statusCode == 502 || // Bad Gateway
          statusCode == 503 || // Service Unavailable
          statusCode == 504; // Gateway Timeout
    }
    return false;
  }

  /// Transform response to specific type
  static T transformResponse<T>(Response response, T Function(Map<String, dynamic>) fromJson) {
    try {
      if (response.data is Map<String, dynamic>) {
        return fromJson(response.data);
      }
      throw const FormatException('Unexpected response format');
    } catch (e) {
      throw FormatException('Failed to parse response: ${e.toString()}');
    }
  }

  /// Get headers for requests including auth token and language
  static Future<Map<String, dynamic>> _getHeaders() async {
    TokenEntity? token = getToken();
    LanguageConfig lang = await AssetTranslations.getLanguage();
    return {
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": "*",
      'Accept-Language': lang.locale.languageCode,
      "Authorization": token != null ? "Bearer ${token.token}" : '',
      'Cache-Control': 'public, max-age=604800', // 7 days
      'Pragma': 'cache',
    };
  }

  /// Execute a request in an isolate with enhanced error handling
  static Future<Response<T>> _executeInIsolate<T>(
    String method,
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
    Duration? duration,
    CachePolicy? cachePolicy,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    void Function(int, int)? onSendProgress,
  }) async {
    final port = ReceivePort();
    final startTime = DateTime.now();

    await Isolate.spawn(
      (List<dynamic> args) async {
        final SendPort sendPort = args[0];
        final String method = args[1];
        final String url = args[2];
        final Map<String, dynamic>? queryParameters = args[3];
        final dynamic data = args[4];
        final Map<String, dynamic>? headers = args[5];
        final Duration? duration = args[6];
        final CancelToken? cancelToken = args[7];
        final onReceiveProgress = args[8];
        final onSendProgress = args[9];

        try {
          final dio = Dio(
            BaseOptions(
              baseUrl: ApiConstance.baseUrl,
              headers: headers,
              connectTimeout: duration,
              receiveTimeout: duration,
              sendTimeout: duration,
              validateStatus: (status) {
                return status != null && status < 500;
              },
            ),
          );
          void progressUpdate(int count, int total, String type) {
          sendPort.send({'type': type, 'count': count, 'total': total});
        }


          Response response;
          switch (method) {
            case 'GET':
              response = await dio.get(
                url,
                queryParameters: queryParameters,
                data: data,
                cancelToken: cancelToken,
                onReceiveProgress: onReceiveProgress,
              );
              break;
            case 'POST':
              response = await dio.post(url,
                  queryParameters: queryParameters,
                  data: data,
                  cancelToken: cancelToken,
                  onSendProgress: onSendProgress,
                  onReceiveProgress: onSendProgress);
              break;
            case 'PUT':
              response = await dio.put(url,
                  queryParameters: queryParameters, data: data, cancelToken: cancelToken);
              break;
            case 'DELETE':
              response = await dio.delete(
                url,
                queryParameters: queryParameters,
                data: data,
                cancelToken: cancelToken,
              );
              break;
            default:
              throw Exception('Unsupported HTTP method: $method');
          }

          if (kDebugMode) {
            log('⏱ Request completed in ${DateTime.now().difference(startTime).inMilliseconds}ms');
            log('📊 Response Stats ${response.requestOptions.method} ${response.requestOptions.path}');
            log('⏱️  Duration: ${DateTime.now().difference(startTime).inMilliseconds}ms');
            log('💾 Size: ${response.data.toString().length}');
            log('📋 Headers:');
            response.headers.map.forEach((key, value) {
              log('  • $key: ${value.join(", ")}');
            });
            log('📦 Response Data Preview:');

            printWrapped(response.data.toString());
          }

          Isolate.exit(sendPort, response);
        } catch (e) {
          if (e is DioException) {
            Isolate.exit(sendPort, _handleDioError(e));
          }
          Isolate.exit(sendPort, e);
        }
      },
      [
        port.sendPort,
        method,
        url,
        queryParameters,
        data,
        headers,
        duration,
        cancelToken,
      ],
    );

    final result = await port.first;
    if (result is Exception) {
      throw result;
    }
    return result as Response<T>;
  }

  /// Make a GET request with enhanced features
  static Future<Response> get(
    String url, {
    Map<String, dynamic>? queries,
    Map<String, dynamic>? data,
    String? token,
    String? baseUrl,
    Map<String, dynamic>? headers,
    Duration? duration,
    CachePolicy? cachePolicy,
    CancelToken? cancelToken,
  }) async {
    if (!await _checkConnectivity()) {
      throw DioException(
        requestOptions: RequestOptions(path: url),
        error: 'No internet connection',
        type: DioExceptionType.connectionError,
      );
    }

    final requestHeaders = headers ?? await _getHeaders();
    if (baseUrl != null) {
      _dio.options.baseUrl = baseUrl;
    }

    if (cachePolicy != null) {
      _dio.options.extra.addAll(_cacheOptions.copyWith(policy: cachePolicy).toExtra());
    }

    return _enqueueRequest(() => _executeInIsolate(
          'GET',
          url,
          queryParameters: queries,
          data: data,
          headers: requestHeaders,
          duration: duration,
          cancelToken: cancelToken,
          onReceiveProgress: (count, total) {
            if (total != -1) {
              log("------------------recieve Progress: ${(count / total * 100).toStringAsFixed(2)}%");
            }
          },
        ));
  }

  /// Make a POST request with enhanced features
  static Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool isFormData = false,
    Duration? duration,
    CachePolicy? cachePolicy,
    CancelToken? cancelToken,
  }) async {
    if (!await _checkConnectivity()) {
      throw DioException(
        requestOptions: RequestOptions(path: url),
        error: 'No internet connection',
        type: DioExceptionType.connectionError,
      );
    }

    final headers = await _getHeaders();

    // Process data based on type and isFormData flag
    dynamic processedData = data;
    if (isFormData) {
      if (data is Map<String, dynamic>) {
        processedData = FormData.fromMap(data);
      } else if (data is! FormData) {
        throw Exception(
            'Data must be either FormData or Map<String, dynamic> when isFormData is true');
      }
    }

    if (cachePolicy != null) {
      _dio.options.extra.addAll(_cacheOptions.copyWith(policy: cachePolicy).toExtra());
    }

    return _enqueueRequest(() => _executeInIsolate(
          'POST',
          url,
          queryParameters: queryParameters,
          data: processedData,
          headers: headers,
          duration: duration,
          cancelToken: cancelToken,
          onSendProgress: (count, total) {
            if (total != -1) {
              log("----------------send Progress: ${(count / total * 100).toStringAsFixed(2)}%");
            }
          },
          onReceiveProgress: (count, total) {
            if (total != -1) {
              log("-----------------recieve Progress: ${(count / total * 100).toStringAsFixed(2)}%");
            }
          },
        ));
  }

  /// Make a PUT request with enhanced features
  static Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
    bool isFormData = false,
    Duration? duration,
    CachePolicy? cachePolicy,
    CancelToken? cancelToken,
  }) async {
    if (!await _checkConnectivity()) {
      throw DioException(
        requestOptions: RequestOptions(path: url),
        error: 'No internet connection',
        type: DioExceptionType.connectionError,
      );
    }

    final headers = await _getHeaders();

    // Process data based on type and isFormData flag
    dynamic processedData = data;
    if (isFormData) {
      if (data is Map<String, dynamic>) {
        processedData = FormData.fromMap(data);
      } else if (data is! FormData) {
        throw Exception(
            'Data must be either FormData or Map<String, dynamic> when isFormData is true');
      }
    }

    if (cachePolicy != null) {
      _dio.options.extra.addAll(_cacheOptions.copyWith(policy: cachePolicy).toExtra());
    }

    return _enqueueRequest(() => _executeInIsolate(
          'PUT',
          url,
          queryParameters: queryParameters,
          data: processedData,
          headers: headers,
          duration: duration,
          cancelToken: cancelToken,
        ));
  }

  /// Make a DELETE request with enhanced features
  static Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
    Duration? duration,
    CachePolicy? cachePolicy,
    CancelToken? cancelToken,
  }) async {
    if (!await _checkConnectivity()) {
      throw DioException(
        requestOptions: RequestOptions(path: url),
        error: 'No internet connection',
        type: DioExceptionType.connectionError,
      );
    }

    final headers = await _getHeaders();

    if (cachePolicy != null) {
      _dio.options.extra.addAll(_cacheOptions.copyWith(policy: cachePolicy).toExtra());
    }

    return _enqueueRequest(() => _executeInIsolate(
          'DELETE',
          url,
          queryParameters: queryParameters,
          data: data,
          headers: headers,
          duration: duration,
          cancelToken: cancelToken,
        ));
  }

  /// Handle Dio specific errors with detailed messages
  static Exception _handleDioError(DioException error) {
    final timestamp = DateTime.now().toIso8601String();
    final errorId = _generateErrorId();

    String message = 'Error [$errorId] at $timestamp: ';

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message += 'Connection timed out. Please check your internet connection.';
        break;
      case DioExceptionType.sendTimeout:
        message += 'Failed to send request. Server is not responding.';
        break;
      case DioExceptionType.receiveTimeout:
        message += 'Server took too long to respond. Please try again.';
        break;
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        message += 'Server error ($statusCode): ${_getErrorMessage(data)}';
        break;
      case DioExceptionType.cancel:
        message += 'Request was cancelled';
        break;
      case DioExceptionType.connectionError:
        message += 'Connection error. Please check your internet connection.';
        break;
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          message += 'No internet connection. Please check your network settings.';
        } else {
          message += error.message ?? 'An unexpected error occurred';
        }
        break;
      default:
        message += error.message ?? 'An unexpected error occurred';
    }

    if (kDebugMode) {
      log('🚨 $message');
      if (error.response?.data != null) {
        printWrapped('Error Response Data: ${error.response!.data.toString()}');
      }
    }

    return Exception(message);
  }

  /// Generate a unique error ID for tracking
  static String _generateErrorId() {
    return DateTime.now().microsecondsSinceEpoch.toRadixString(36).toUpperCase();
  }

  /// Extract error message from response data with improved parsing
  static String _getErrorMessage(dynamic data) {
    if (data == null) return 'Unknown error';
    if (data is String) return data;
    if (data is Map) {
      // Try common error message fields
      final possibleFields = ['message', 'error', 'error_description', 'errorMessage', 'detail'];
      for (final field in possibleFields) {
        final value = data[field];
        if (value != null && value is String) return value;
      }

      // Handle nested errors
      if (data['errors'] is List && (data['errors'] as List).isNotEmpty) {
        return (data['errors'] as List).first.toString();
      }

      // If no specific error field found, return the whole object as string
      return data.toString();
    }
    return 'Unknown error';
  }

  @override
  List<Object?> get props => [];
}
