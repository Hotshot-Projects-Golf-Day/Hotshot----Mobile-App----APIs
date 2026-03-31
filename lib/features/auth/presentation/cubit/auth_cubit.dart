import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:upd8s/core/helper/secure_storage.dart';
import 'package:upd8s/core/repository/account_repository.dart';
import 'package:upd8s/core/repository/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repo;
  final AccountRepository _accountRepo;

  AuthCubit({
    AuthRepository? authRepository,
    AccountRepository? accountRepository,
  }) : _repo = authRepository ?? AuthRepository(),
       _accountRepo = accountRepository ?? AccountRepository(), // ← NEW
       super(const AuthState());

  // =====================
  // REGISTER
  // =====================
  Future<void> register({
    required String role,
    required String name,
    required String email,
    required String mobile,
    required String province,
    required String city,
    required String address,
    required String password,
  }) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final response = await _repo.register(
        role: role,
        name: name,
        email: email,
        mobile: mobile,
        province: province,
        city: city,
        address: address,
        password: password,
        consentAccepted: true,
      );

      final data = response.data?["data"];
      final message =
          response.data?["message"] ??
          "Registration successful. Please check your email for the OTP.";

      if (data?["token"] != null) {
        await SecureStorage.instance.saveTempSignupToken(data["token"]);
      }
      if (data?["userId"] != null) {
        await SecureStorage.instance.saveUserId(data["userId"]);
      }

      emit(
        state.copyWith(
          status: AuthStatus.registerSuccess,
          successMessage: message,
          registeredEmail: email,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: _extractMessage(
            e,
            "Registration failed. Please try again.",
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  // =====================
  // VERIFY OTP (after signup)
  // =====================
  Future<void> verifySignupOtp({
    required String email,
    required String otp,
  }) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final response = await _repo.verifyOtp(email: email, otp: otp);
      final message =
          response.data?["message"] ??
          "Email verified successfully. You can now log in.";

      await SecureStorage.instance.clearTempSignupToken();

      emit(
        state.copyWith(status: AuthStatus.otpVerified, successMessage: message),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: _extractMessage(e, "Invalid OTP. Please try again."),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  // =====================
  // RESEND VERIFICATION OTP
  // =====================
  Future<void> resendVerificationOtp({required String email}) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final response = await _repo.resendVerificationOtp(email: email);
      final message = response.data?["message"] ?? "OTP resent successfully.";

      emit(
        state.copyWith(
          status: AuthStatus.registerSuccess, // stay on OTP screen
          successMessage: message,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: _extractMessage(e, "Failed to resend OTP."),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  // =====================
  // LOGIN
  // =====================
  Future<void> login({required String email, required String password}) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final response = await _repo.login(email: email, password: password);
      final data = response.data?["data"];
      final message = response.data?["message"] ?? "Login successful";

      if (data?["accessToken"] != null) {
        await SecureStorage.instance.saveToken(data["accessToken"]);
      }
      if (data?["refreshToken"] != null) {
        await SecureStorage.instance.saveRefreshToken(data["refreshToken"]);
      }
      final user = data?["user"];
      if (user != null) {
        if (user["id"] != null) {
          await SecureStorage.instance.saveUserId(user["id"]);
        }
        if (user["role"] != null) {
          await SecureStorage.instance.saveRoles([user["role"]]);
        }
      }

      emit(
        state.copyWith(
          status: AuthStatus.loginSuccess,
          successMessage: message,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: _extractMessage(e, "Login failed. Please try again."),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  // =====================
  // REFRESH TOKEN
  // =====================
  Future<void> refreshToken() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final savedRefreshToken = await SecureStorage.instance.getRefreshToken();
      if (savedRefreshToken == null) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: "No refresh token found. Please log in again.",
          ),
        );
        return;
      }

      final response = await _repo.refreshToken(
        refreshToken: savedRefreshToken,
      );
      final data = response.data?["data"];
      final message = response.data?["message"] ?? "Token refreshed";

      if (data?["accessToken"] != null) {
        await SecureStorage.instance.saveToken(data["accessToken"]);
      }

      emit(
        state.copyWith(
          status: AuthStatus.tokenRefreshed,
          successMessage: message,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: _extractMessage(
            e,
            "Session expired. Please log in again.",
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  // =====================
  // FORGOT PASSWORD - SEND OTP
  // =====================
  Future<void> forgotPassword({required String email}) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final response = await _repo.forgotPassword(email: email);
      final message = response.data?["message"] ?? "OTP sent successfully.";

      emit(
        state.copyWith(
          status: AuthStatus.otpSent,
          successMessage: message,
          registeredEmail: email,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: _extractMessage(e, "Failed to send OTP."),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  // =====================
  // FORGOT PASSWORD - RESEND OTP
  // =====================
  Future<void> resendResetOtp({required String email}) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final response = await _repo.resendResetOtp(email: email);
      final message = response.data?["message"] ?? "OTP resent successfully.";

      emit(state.copyWith(status: AuthStatus.otpSent, successMessage: message));
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: _extractMessage(e, "Failed to resend OTP."),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  // =====================
  // FORGOT PASSWORD - VERIFY OTP
  // =====================
  Future<void> verifyForgotPasswordOtp({
    required String email,
    required String otp,
  }) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final response = await _repo.verifyForgotPasswordOtp(
        email: email,
        otp: otp,
      );
      final message = response.data?["message"] ?? "OTP verified successfully.";

      emit(
        state.copyWith(
          status: AuthStatus.forgotOtpVerified,
          successMessage: message,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: _extractMessage(e, "Invalid OTP. Please try again."),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  // =====================
  // RESET PASSWORD WITH OTP
  // =====================
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final response = await _repo.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      final message =
          response.data?["message"] ?? "Password reset successfully.";

      emit(
        state.copyWith(
          status: AuthStatus.passwordReset,
          successMessage: message,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: _extractMessage(e, "Failed to reset password."),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  // =====================
  // GET POLICIES
  // =====================
  Future<void> getPolicies() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      final policies = await _accountRepo.getPolicies();

      emit(
        state.copyWith(status: AuthStatus.policiesLoaded, policies: policies),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: _extractMessage(e, "Failed to load policies."),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  // =====================
  // RESET TO INITIAL
  // =====================
  void resetState() {
    emit(const AuthState());
  }

  // =====================
  // HELPER
  // =====================
  String _extractMessage(DioException e, String fallback) {
    return e.response?.data?["message"] ??
        e.response?.data?["data"]?["message"] ??
        fallback;
  }
}
