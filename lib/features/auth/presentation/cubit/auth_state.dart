import 'package:equatable/equatable.dart';
import 'package:upd8s/features/settings/data/policy_model.dart';

enum AuthStatus {
  initial,
  loading,
  loginSuccess,
  registerSuccess,
  otpVerified,
  otpSent,
  forgotOtpVerified,
  passwordReset,
  passwordChanged,
  tokenRefreshed,
  policiesLoaded, 
  failure,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String? successMessage;
  final String? errorMessage;
  final String? registeredEmail;
  final List<PolicyModel> policies; // ← NEW

  const AuthState({
    this.status = AuthStatus.initial,
    this.successMessage,
    this.errorMessage,
    this.registeredEmail,
    this.policies = const [], // ← NEW
  });

  AuthState copyWith({
    AuthStatus? status,
    String? successMessage,
    String? errorMessage,
    String? registeredEmail,
    List<PolicyModel>? policies, // ← NEW
  }) {
    return AuthState(
      status: status ?? this.status,
      successMessage: successMessage,
      errorMessage: errorMessage,
      registeredEmail: registeredEmail ?? this.registeredEmail,
      policies: policies ?? this.policies, // ← NEW
    );
  }

  bool get isLoading => status == AuthStatus.loading;

  // Convenience getters for policy types
  PolicyModel? get privacyPolicy =>
      policies.where((p) => p.isPrivacyPolicy).firstOrNull;

  PolicyModel? get termsAndConditions =>
      policies.where((p) => p.isTermsAndConditions).firstOrNull;

  @override
  List<Object?> get props => [
    status,
    successMessage,
    errorMessage,
    registeredEmail,
    policies,
  ];
}
