import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:injectable/injectable.dart';

import '../secure_storage.dart';

class DioClient {
  @lazySingleton
  Dio get dio {
    Dio _dio = Dio(
      BaseOptions(
        connectTimeout: 10000,
        receiveTimeout: 10000,
        baseUrl: FlutterConfig.get('API_URL'),
        validateStatus: (status) {
          return status! < 400;
        },
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onResponse: _onResponse,
        onError: _onError,
      ),
    );
    return _dio;
  }

  void _onRequest(options, handler) async {
    dio.lock();
    String? apiKey = await SecureStorage.readApiKey();
    options.headers['x-apikey'] = '$apiKey';
    options.headers['Content-Type'] = 'application/json';
    handler.next(options);
  }

  void _onResponse(response, handler) {
    handler.next(response);
  }

  void _onError(error, handler) {
    handler.next(error);
  }
}
