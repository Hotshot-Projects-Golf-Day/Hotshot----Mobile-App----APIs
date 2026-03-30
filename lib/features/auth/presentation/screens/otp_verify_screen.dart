import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:upd8s/core/helper/app_validations.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/app_button.dart';
import 'package:upd8s/core/widgets/app_snackbar.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';
import 'package:upd8s/core/widgets/custom_text_field.dart';
import 'package:upd8s/core/widgets/loader.dart';
import 'package:upd8s/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:upd8s/features/auth/presentation/cubit/auth_state.dart';
import 'package:upd8s/routes/app_router.dart';

class OtpVerifyScreen extends StatefulWidget {
  final String email;

  const OtpVerifyScreen({super.key, required this.email});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final validator = Validator(errorText: '');

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.errorMessage?.isNotEmpty == true) {
            AppSnackbar.showError(context, state.errorMessage!);
          }
          if (state.successMessage?.isNotEmpty == true) {
            AppSnackbar.showSuccess(context, state.successMessage!);
          }
          if (state.status == AuthStatus.otpVerified) {
            context.goNamed(AppRoute.login.name);
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();

           return Scaffold(
  body: SafeArea(
    child: AppBackground(
      child: Stack(                          // ✅ Stack is required for AppLoader
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CustomAppBarWidget(
                    title: "Verify Email",
                    showBackButton: true,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Enter OTP",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "A verification code was sent to\n${widget.email}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),
                          CustomTextField(
                            heading: "OTP Code",
                            labelText: "Enter 6-digit OTP",
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            validator: validator.otp,
                            maxLength: 6,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: state.isLoading
                                  ? null
                                  : () => cubit.resendVerificationOtp(
                                        email: widget.email,
                                      ),
                              child: const Text("Resend OTP"),
                            ),
                          ),
                          const SizedBox(height: 16),
                          AppButton(
                            text: "Verify OTP",
                            isLoading: false,
                            onPressed: state.isLoading
                                ? null
                                : () {
                                    if (!_formKey.currentState!.validate())
                                      return;
                                    cubit.verifySignupOtp(
                                      email: widget.email,
                                      otp: _otpController.text.trim(),
                                    );
                                  },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ✅ AppLoader sits as second child of Stack — overlays everything
          if (state.isLoading) const AppLoader(),
        ],
      ),
    ),
  ),
);
          },
        ),
      ),
    );
  }
}
