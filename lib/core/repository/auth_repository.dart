import 'package:dio/dio.dart';
import 'package:upd8s/core/helper/api_client.dart';
import 'package:upd8s/core/helper/endpoint.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient.instance;

  Future<Response> login({
    required String userName,
    required String password,
  }) async {
    final body = {"userName": userName, "password": password};

    return await _apiClient.post(Endpoints.login, data: body, useToken: false);
  }

  Future<Response> register({
    String? profileImage,
    required String firstName,
    required String lastName,
    required String userName,
    required String nrcNumber,
    required String mobileNumber,
    required String viberNumber,
    String? email,
    required String dateOfBirth,
    required String gender,
    required String password,
    required bool canTravel,
    required bool isExperienced,
    String? role,
    bool? isActive,
    String? city,
    String? town,
    String? street,
    String? state,
    String? zipCode,
  }) async {
    final Map<String, dynamic> body = {
      "firstName": firstName,
      "lastName": lastName,
      "userName": userName,
      "nrcNumber": nrcNumber,
      "mobileNumber": mobileNumber,
      "viberNumber": viberNumber,
      "dateOfBirth": dateOfBirth,
      "gender": gender,
      "password": password,
      "canTravel": canTravel,
      "isExperienced": isExperienced,
    };

    if (profileImage?.isNotEmpty == true) body["profileImage"] = profileImage;
    if (email?.isNotEmpty == true) body["email"] = email;

    if (isActive != null) body["isActive"] = isActive;
    if (city?.isNotEmpty == true) body["city"] = city;
    if (town?.isNotEmpty == true) body["town"] = town;
    if (street?.isNotEmpty == true) body["street"] = street;
    if (state?.isNotEmpty == true) body["state"] = state;
    if (zipCode?.isNotEmpty == true) body["zipCode"] = zipCode;

    return await _apiClient.post(
      Endpoints.register,
      data: body,
      useToken: false,
    );
  }

  Future<Response> verifyOtp({
    required String mobileNumber,
    required String otp,
  }) async {
    final body = {"mobileNumber": mobileNumber, "otp": otp};

    return await _apiClient.post(
      Endpoints.verifyOtp,
      data: body,
      useToken: false,
    );
  }

  Future<Response> resendOtp({required String mobileNumber}) {
    return _apiClient.post(
      Endpoints.resendOtp,
      data: {"mobileNumber": mobileNumber},
      useToken: false,
    );
  }

  // ======================
  // FORGOT PASSWORD - SEND OTP
  // ======================
  Future<Response> forgotPassword({required String email}) async {
    final body = {"email": email};

    return await _apiClient.post(
      Endpoints.forgotPassword,
      data: body,
      useToken: false,
    );
  }

  // ======================
  // FORGOT PASSWORD - VERIFY OTP
  // ======================
  Future<Response> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    final body = {"email": email, "otp": otp};

    return await _apiClient.post(
      Endpoints.verifyForgotPasswordOtp,
      data: body,
      useToken: false,
    );
  }

  // ======================
  // RESET PASSWORD
  // ======================
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

    return await _apiClient.post(
      Endpoints.resetPassword,
      data: body,
      useToken: false,
    );
  }
}
