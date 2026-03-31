import 'package:equatable/equatable.dart';
import 'package:upd8s/features/settings/data/faq_model.dart';
import 'package:upd8s/features/settings/data/policy_model.dart';



enum AccountStatus {
  initial,
  loading,
  passwordChanged,    // change password success
  helpCenterSuccess,  // help-center submit success
  faqsLoaded,         // FAQs fetched
  policiesLoaded,     // Policies fetched
  failure,
}

class AccountState extends Equatable {
  final AccountStatus status;
  final String? successMessage;
  final String? errorMessage;
  final List<FaqModel> faqs;
  final List<PolicyModel> policies;

  const AccountState({
    this.status = AccountStatus.initial,
    this.successMessage,
    this.errorMessage,
    this.faqs = const [],
    this.policies = const [],
  });

  AccountState copyWith({
    AccountStatus? status,
    String? successMessage,
    String? errorMessage,
    List<FaqModel>? faqs,
    List<PolicyModel>? policies,
  }) {
    return AccountState(
      status: status ?? this.status,
      successMessage: successMessage,
      errorMessage: errorMessage,
      faqs: faqs ?? this.faqs,
      policies: policies ?? this.policies,
    );
  }

  // Convenience getters
  bool get isLoading => status == AccountStatus.loading;

  /// Returns the privacy policy from the loaded policies list, or null.
  PolicyModel? get privacyPolicy =>
      policies.where((p) => p.isPrivacyPolicy).firstOrNull;

  /// Returns the terms & conditions from the loaded policies list, or null.
  PolicyModel? get termsAndConditions =>
      policies.where((p) => p.isTermsAndConditions).firstOrNull;

  @override
  List<Object?> get props => [
        status,
        successMessage,
        errorMessage,
        faqs,
        policies,
      ];
}