import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._privateConstructor();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  factory SecureStorage() {
    return _instance;
  }

  SecureStorage._privateConstructor();

  static Future<void> writeApiKey(String apiKey) async =>
      await _instance._secureStorage.write(key: 'ApiKey', value: apiKey);

  static Future<String?> readApiKey() async =>
      await _instance._secureStorage.read(key: 'ApiKey');
}
