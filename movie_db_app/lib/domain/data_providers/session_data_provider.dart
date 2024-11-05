import 'package:the_movie_db/library/flutter_secure_storage/secure_storage.dart';

abstract class _Keys {
  static const String sessionIdKey = 'session_id';
}

abstract class SessionDataProvider {
  Future<String?> getSessionId();
  Future<void> setSessionId(String? value);
  Future<void> clearStorage();
}

class SessionDataProviderBasic implements SessionDataProvider {
  const SessionDataProviderBasic({required this.secureStorage});

  final SecureStorage secureStorage;

  @override
  Future<String?> getSessionId() => secureStorage.read(key: _Keys.sessionIdKey);

  @override
  Future<void> setSessionId(String? value) => value != null
      ? secureStorage.write(key: _Keys.sessionIdKey, value: value)
      : secureStorage.delete(key: _Keys.sessionIdKey);

  @override
  Future<void> clearStorage() => secureStorage.delete(key: _Keys.sessionIdKey);
}
