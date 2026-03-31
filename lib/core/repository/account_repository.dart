import 'package:dio/dio.dart';
import 'package:upd8s/core/helper/api_client.dart';
import 'package:upd8s/core/helper/endpoint.dart';
import 'package:upd8s/features/settings/data/faq_model.dart';
import 'package:upd8s/features/settings/data/policy_model.dart';

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

  // =====================
  // HELP CENTER
  // =====================
  Future<String> submitHelpCenter({
    required String title,
    required String description,
  }) async {
    final body = {"title": title, "description": description};

    final response = await _apiClient.post(
      Endpoints.helpCenter,
      data: body,
      useToken: true,
    );

    return response.data?["data"]?["message"] as String? ??
        response.data?["message"] as String? ??
        "Query submitted successfully.";
  }

  // =====================
  // FAQs
  // =====================
  Future<List<FaqModel>> getFaqs() async {
    final response = await _apiClient.get(Endpoints.faqs, useToken: true);

    final List<dynamic> data = response.data?["data"] as List<dynamic>? ?? [];
    return data
        .map((e) => FaqModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // =====================
  // POLICIES
  // =====================
  Future<List<PolicyModel>> getPolicies() async {
    final response = await _apiClient.get(Endpoints.policies, useToken: true);

    final List<dynamic> data = response.data?["data"] as List<dynamic>? ?? [];
    return data
        .map((e) => PolicyModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
