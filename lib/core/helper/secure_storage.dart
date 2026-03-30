import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._();
  static final instance = SecureStorage._();

  final _storage = const FlutterSecureStorage();

  static const _authTokenKey = 'auth_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userIdKey = 'user_id';
  static const _tempSignupTokenKey = 'temp_signup_token';
  static const _rolesKey = 'user_roles';

  // AUTH TOKEN
  Future<void> saveToken(String token) =>
      _storage.write(key: _authTokenKey, value: token);

  Future<String?> getToken() => _storage.read(key: _authTokenKey);

  // REFRESH TOKEN
  Future<void> saveRefreshToken(String token) =>
      _storage.write(key: _refreshTokenKey, value: token);

  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);

  // USER ID
  Future<void> saveUserId(String userId) =>
      _storage.write(key: _userIdKey, value: userId);

  // ROLES
  Future<void> saveRoles(List<String> roles) =>
      _storage.write(key: _rolesKey, value: jsonEncode(roles));

  // TEMP SIGNUP TOKEN
  Future<void> saveTempSignupToken(String token) =>
      _storage.write(key: _tempSignupTokenKey, value: token);

  Future<void> clearTempSignupToken() =>
      _storage.delete(key: _tempSignupTokenKey);

  // CLEAR ALL (used on logout)
  Future<void> clearAll() => _storage.deleteAll();
}
