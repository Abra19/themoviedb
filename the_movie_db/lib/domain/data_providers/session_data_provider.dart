import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const String sessionIdKey = 'session_id';
}

class SessionDataProvider {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<String?> getSessionId() =>
      _secureStorage.read(key: _Keys.sessionIdKey);

  Future<void> setSessionId(String? value) => value != null
      ? _secureStorage.write(key: _Keys.sessionIdKey, value: value)
      : _secureStorage.delete(key: _Keys.sessionIdKey);
}
