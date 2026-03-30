import 'package:dio/dio.dart';
import 'package:upd8s/core/helper/api_client.dart';
import 'package:upd8s/core/helper/endpoint.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // =====================
  // REGISTER
  // =====================
  Future<Response> register({
    required String role,
    required String name,
    required String email,
    required String mobile,
    required String province,
    required String city,
    required String address,
    required String password,
    required bool consentAccepted,
  }) async {
    final body = {
      "role": role.toUpperCase(),
      "name": name,
      "email": email,
      "mobile": mobile,
      "province": province,
      "city": city,
      "address": address,
      "password": password,
      "consentAccepted": consentAccepted,
    };
    return await _apiClient.post(Endpoints.register, data: body, useToken: false);
  }

  // =====================
  // LOGIN
  // =====================
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    final body = {"email": email, "password": password};
    return await _apiClient.post(Endpoints.login, data: body, useToken: false);
  }

  // =====================
  // REFRESH TOKEN
  // =====================
  Future<Response> refreshToken({required String refreshToken}) async {
    final body = {"refreshToken": refreshToken};
    return await _apiClient.post(Endpoints.refreshToken, data: body, useToken: false);
  }

  // =====================
  // VERIFY OTP (Email verification after register)
  // =====================
  Future<Response> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final body = {"email": email, "otp": otp};
    return await _apiClient.post(Endpoints.verifyOtp, data: body, useToken: false);
  }

  // =====================
  // RESEND VERIFICATION OTP
  // =====================
  Future<Response> resendVerificationOtp({required String email}) async {
    final body = {"email": email};
    return await _apiClient.post(Endpoints.resendVerificationOtp, data: body, useToken: false);
  }

  // =====================
  // FORGOT PASSWORD - SEND OTP
  // =====================
  Future<Response> forgotPassword({required String email}) async {
    final body = {"email": email};
    return await _apiClient.post(Endpoints.forgotPassword, data: body, useToken: false);
  }

  // =====================
  // RESEND RESET OTP
  // =====================
  Future<Response> resendResetOtp({required String email}) async {
    final body = {"email": email};
    return await _apiClient.post(Endpoints.resendResetOtp, data: body, useToken: false);
  }

  // =====================
  // FORGOT PASSWORD - VERIFY OTP
  // =====================
  Future<Response> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    final body = {"email": email, "otp": otp};
    return await _apiClient.post(Endpoints.verifyForgotPasswordOtp, data: body, useToken: false);
  }

  // =====================
  // RESET PASSWORD WITH OTP (Forgot flow)
  // =====================
  Future<Response> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final body = {
      "email": email,
      "otp": otp,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };
    return await _apiClient.post(Endpoints.resetPassword, data: body, useToken: false);
  }


}