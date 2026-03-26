import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._();
  static final instance = SecureStorage._();

  final _storage = const FlutterSecureStorage();

  /// Keys
  static const _authTokenKey = "auth_token";
  static const _refreshTokenKey = "refresh_token";
  static const _userIdKey = "user_id";
  static const _tempSignupTokenKey = "temp_signup_token";
  static const _rolesKey = "user_roles";

  /// =====================
  /// AUTH TOKEN
  /// =====================
  Future<void> saveToken(String token) async {
    await _storage.write(key: _authTokenKey, value: token);
  }

  Future<String?> getToken() async {
    return _storage.read(key: _authTokenKey);
  }

  /// =====================
  /// REFRESH TOKEN
  /// =====================
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  Future<String?> getRefreshToken() async {
    return _storage.read(key: _refreshTokenKey);
  }

  /// =====================
  /// USER ID
  /// =====================
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: _userIdKey, value: userId);
  }

  Future<String?> getUserId() async {
    return _storage.read(key: _userIdKey);
  }

  /// =====================
  /// ROLES
  /// =====================
  Future<void> saveRoles(List<String> roles) async {
    await _storage.write(key: _rolesKey, value: jsonEncode(roles));
  }

  Future<List<String>> getRoles() async {
    final data = await _storage.read(key: _rolesKey);
    if (data == null) return [];
    return List<String>.from(jsonDecode(data));
  }

  /// =====================
  /// TEMP SIGNUP TOKEN (OTP / Verification)
  /// =====================
  Future<void> saveTempSignupToken(String token) async {
    await _storage.write(key: _tempSignupTokenKey, value: token);
  }

  Future<String?> getTempSignupToken() async {
    return await _storage.read(key: _tempSignupTokenKey);
  }

  Future<void> clearTempSignupToken() async {
    await _storage.delete(key: _tempSignupTokenKey);
  }

  /// =====================
  /// CLEAR EVERYTHING
  /// =====================
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
