import 'package:dio/dio.dart';
import 'package:upd8s/core/helper/api_client.dart';
import 'package:upd8s/core/helper/endpoint.dart';

class AccountRepository {
  final ApiClient _apiClient = ApiClient.instance;

  // =====================
  // CHANGE PASSWORD
  // =====================
  Future<Response> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final body = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };

    return await _apiClient.post(
      Endpoints.changePassword,
      data: body,
      useToken: true,
    );
  }
}