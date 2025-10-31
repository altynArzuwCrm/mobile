import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Store {
  final FlutterSecureStorage _secureStorage;

  Store(this._secureStorage);

  final String _tokenKey = 'token';
  final String _rememberKey = 'remember';

  Future<void> setToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return _secureStorage.read(key: _tokenKey);
  }

  Future<bool> isTokenAvailable() async {
    String? token = await _secureStorage.read(key: _tokenKey);
    return Future.value((token != null));
  }

  Future<void> clear() async {
    await _secureStorage.delete(key: _tokenKey);
    await _secureStorage.delete(key: _rememberKey);

  }

  Future<void> setRemember(bool value) async {
    await _secureStorage.write(key: _rememberKey, value: value.toString());
  }

  Future<bool> getRemember() async {
    String? value = await _secureStorage.read(key: _rememberKey);
    return value == 'true';
  }
}
