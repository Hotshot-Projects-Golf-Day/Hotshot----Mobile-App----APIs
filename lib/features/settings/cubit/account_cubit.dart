import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upd8s/core/repository/account_repository.dart';
import 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final AccountRepository _repo;

  AccountCubit({AccountRepository? accountRepository})
    : _repo = accountRepository ?? AccountRepository(),
      super(const AccountState());

  // =====================
  // CHANGE PASSWORD
  // =====================
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      emit(state.copyWith(status: AccountStatus.loading));

      final response = await _repo.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      final message =
          response.data?["message"] ?? "Password changed successfully.";

      emit(
        state.copyWith(
          status: AccountStatus.passwordChanged,
          successMessage: message,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: AccountStatus.failure,
          errorMessage: _extractMessage(
            e,
            "Failed to change password. Please try again.",
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AccountStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // =====================
  // RESET TO INITIAL
  // =====================
  void resetState() {
    emit(const AccountState());
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
