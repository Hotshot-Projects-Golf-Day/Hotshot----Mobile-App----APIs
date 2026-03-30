import 'package:equatable/equatable.dart';

enum AccountStatus {
  initial,
  loading,
  passwordChanged, // change password success
  failure,
}

class AccountState extends Equatable {
  final AccountStatus status;
  final String? successMessage;
  final String? errorMessage;

  const AccountState({
    this.status = AccountStatus.initial,
    this.successMessage,
    this.errorMessage,
  });

  AccountState copyWith({
    AccountStatus? status,
    String? successMessage,
    String? errorMessage,
  }) {
    return AccountState(
      status: status ?? this.status,
      successMessage: successMessage,
      errorMessage: errorMessage,
    );
  }

  // Convenience getters
  bool get isLoading => status == AccountStatus.loading;

  @override
  List<Object?> get props => [status, successMessage, errorMessage];
}