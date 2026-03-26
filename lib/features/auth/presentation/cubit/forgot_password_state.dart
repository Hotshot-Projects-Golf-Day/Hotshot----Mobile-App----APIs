import 'package:equatable/equatable.dart';

class ForgotPasswordState extends Equatable {
  final bool isLoading;
  final bool isOtpSent;
  final bool isOtpVerified;
  final bool isPasswordReset;
  final String? successMessage;
  final String? errorMessage;

  const ForgotPasswordState({
    this.isLoading = false,
    this.isOtpSent = false,
    this.isOtpVerified = false,
    this.isPasswordReset = false,
    this.successMessage,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    bool? isOtpSent,
    bool? isOtpVerified,
    bool? isPasswordReset,
    String? successMessage,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      isOtpSent: isOtpSent ?? this.isOtpSent,
      isOtpVerified: isOtpVerified ?? this.isOtpVerified,
      isPasswordReset: isPasswordReset ?? this.isPasswordReset,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isOtpSent,
        isOtpVerified,
        isPasswordReset,
        successMessage,
        errorMessage,
      ];
}