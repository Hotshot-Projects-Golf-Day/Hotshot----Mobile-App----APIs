import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upd8s/core/theme/app_colors.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';
import 'package:upd8s/core/widgets/shimmer.dart';
import 'package:upd8s/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:upd8s/features/auth/presentation/cubit/auth_state.dart';

class LegalContentScreen extends StatefulWidget {
  const LegalContentScreen({super.key});

  @override
  State<LegalContentScreen> createState() => _LegalContentScreenState();
}

class _LegalContentScreenState extends State<LegalContentScreen> {
  bool isPrivacySelected = true;

  static const String _privacyTitle = "Privacy Policy";
  static const String _termsTitle = "Terms & Conditions";

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getPolicies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppBackground(
          child: BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (prev, curr) =>
                curr.status == AuthStatus.policiesLoaded ||
                curr.status == AuthStatus.loading ||
                curr.status == AuthStatus.failure,
            builder: (context, state) {
              // ── LOADING ──────────────────────────────
              if (state.isLoading) {
                return const Center(child: TermsShimmerScreen());
              }

              // ── ERROR ─────────────────────────────────
              if (state.status == AuthStatus.failure) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.errorMessage ?? 'Failed to load policy.',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () =>
                            context.read<AuthCubit>().getPolicies(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              // ── SUCCESS ───────────────────────────────
              final privacyContent = state.privacyPolicy?.content ?? '';
              final termsContent = state.termsAndConditions?.content ?? '';

              return Column(
                children: [
                  // AppBar title always reflects selected tab
                  CustomAppBarWidget(
                    title: isPrivacySelected ? _privacyTitle : _termsTitle,
                    showBackButton: true,
                  ),

                  const SizedBox(height: 10),

                  // ── Toggle ─────────────────────────────
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
                          title: _privacyTitle,
                          isSelected: isPrivacySelected,
                          onTap: () => setState(() => isPrivacySelected = true),
                        ),
                        _toggleButton(
                          title: _termsTitle,
                          isSelected: !isPrivacySelected,
                          onTap: () =>
                              setState(() => isPrivacySelected = false),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Content ────────────────────────────
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        isPrivacySelected ? privacyContent : termsContent,
                        style: const TextStyle(
                          fontFamily: 'Aptos',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.4,
                          letterSpacing: -0.065,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
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
