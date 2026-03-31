import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upd8s/core/theme/app_colors.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';
import 'package:upd8s/features/settings/cubit/account_cubit.dart';
import 'package:upd8s/features/settings/cubit/account_state.dart';

/// API-driven policies screen used from the Settings shell.
/// Requires [AccountCubit] to be provided by the ShellRoute above it.
class PoliciesScreen extends StatefulWidget {
  const PoliciesScreen({super.key});

  @override
  State<PoliciesScreen> createState() => _PoliciesScreenState();
}

class _PoliciesScreenState extends State<PoliciesScreen> {
  /// true  → Privacy Policy tab selected
  /// false → Terms & Conditions tab selected
  bool _showPrivacy = true;

  @override
  void initState() {
    super.initState();
    context.read<AccountCubit>().getPolicies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: AppBackground(
              child: Column(
                children: [
                  const CustomAppBarWidget(
                    title: "Policies",
                    showBackButton: true,
                  ),

                  const SizedBox(height: 10),

                  // Toggle bar — always shown
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.all(6),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppColor.whiteColor,
                    ),
                    child: Row(
                      children: [
                        _toggleButton(
                          title: "Privacy Policy",
                          isSelected: _showPrivacy,
                          onTap: () => setState(() => _showPrivacy = true),
                        ),
                        _toggleButton(
                          title: "Terms & Conditions",
                          isSelected: !_showPrivacy,
                          onTap: () => setState(() => _showPrivacy = false),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Expanded(child: _buildBody(state)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(AccountState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == AccountStatus.failure) {
      return Center(
        child: Text(
          state.errorMessage ?? "Failed to load policies.",
          style: const TextStyle(color: Colors.black54),
        ),
      );
    }

    final policy = _showPrivacy
        ? state.privacyPolicy
        : state.termsAndConditions;

    if (policy == null && state.status == AccountStatus.policiesLoaded) {
      return const Center(
        child: Text(
          "Content not available.",
          style: TextStyle(color: Colors.black54),
        ),
      );
    }

    if (policy == null) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Text(
        policy.content,
        style: const TextStyle(
          fontFamily: 'Aptos',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.4,
          letterSpacing: -0.065,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _toggleButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColor.primary100 : AppColor.whiteColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
