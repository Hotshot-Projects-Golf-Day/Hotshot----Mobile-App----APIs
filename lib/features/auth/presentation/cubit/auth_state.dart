import 'package:equatable/equatable.dart';

enum AuthStatus {
  initial,
  loading,
  loginSuccess,
  registerSuccess,    // registered, OTP sent to email
  otpVerified,        // email verified after signup
  otpSent,            // forgot password OTP sent
  forgotOtpVerified,  // forgot password OTP verified
  passwordReset,      // password reset success
  passwordChanged,    // change password success
  tokenRefreshed,
  failure,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String? successMessage;
  final String? errorMessage;
  final String? registeredEmail; // kept for OTP screens

  const AuthState({
    this.status = AuthStatus.initial,
    this.successMessage,
    this.errorMessage,
    this.registeredEmail,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? successMessage,
    String? errorMessage,
    String? registeredEmail,
  }) {
    return AuthState(
      status: status ?? this.status,
      successMessage: successMessage,
      errorMessage: errorMessage,
      registeredEmail: registeredEmail ?? this.registeredEmail,
    );
  }

  // Convenience getters
  bool get isLoading => status == AuthStatus.loading;

  @override
  List<Object?> get props => [
        status,
        successMessage,
        errorMessage,
        registeredEmail,
      ];
}