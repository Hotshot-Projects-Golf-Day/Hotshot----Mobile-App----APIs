import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:upd8s/core/repository/auth_repository.dart';
import 'package:upd8s/features/auth/presentation/cubit/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;

  ForgotPasswordCubit({AuthRepository? authRepository})
    : _authRepository = authRepository ?? AuthRepository(),
      super(const ForgotPasswordState());

  /// SEND OTP
  Future<void> sendOtp(String email) async {
    try {
      emit(state.copyWith(isLoading: true));

      final response = await _authRepository.forgotPassword(email: email);
      final data = response.data; // <-- Access response.data for JSON

      emit(
        state.copyWith(
          isLoading: false,
          isOtpSent: true,
          successMessage: data["message"] ?? "OTP sent successfully",
          errorMessage: null,
        ),
      );
    } on DioException catch (e) {
      final message = e.response?.data?["message"] ?? "Something went wrong";
      emit(state.copyWith(isLoading: false, errorMessage: message));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// VERIFY OTP
  Future<void> verifyOtp({required String email, required String otp}) async {
    try {
      emit(state.copyWith(isLoading: true));

      final response = await _authRepository.verifyForgotPasswordOtp(
        email: email,
        otp: otp,
      );
      final data = response.data;

      emit(
        state.copyWith(
          isLoading: false,
          isOtpVerified: true,
          successMessage: data["message"] ?? "OTP verified successfully",
          errorMessage: null,
        ),
      );
    } on DioException catch (e) {
      final message = e.response?.data?["message"] ?? "Invalid OTP";
      emit(state.copyWith(isLoading: false, errorMessage: message));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// RESET PASSWORD
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      emit(state.copyWith(isLoading: true));

      final response = await _authRepository.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      final data = response.data;

      emit(
        state.copyWith(
          isLoading: false,
          isPasswordReset: true,
          successMessage: data["message"] ?? "Password reset successfully",
          errorMessage: null,
        ),
      );
    } on DioException catch (e) {
      final message =
          e.response?.data?["message"] ?? "Failed to reset password";
      emit(state.copyWith(isLoading: false, errorMessage: message));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// EDIT EMAIL - reset state
  void editEmail() {
    emit(
      state.copyWith(
        isOtpSent: false,
        isOtpVerified: false,
        isPasswordReset: false,
        errorMessage: null,
        successMessage: null,
      ),
    );
  }
}
