import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:upd8s/core/helper/app_validations.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/app_button.dart';
import 'package:upd8s/core/widgets/app_snackbar.dart';
import 'package:upd8s/core/widgets/custom_text_field.dart';
import 'package:upd8s/features/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:upd8s/features/auth/presentation/cubit/forgot_password_state.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  final validator = Validator(errorText: "");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: Scaffold(
        body: SafeArea(
          child: AppBackground(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(),
                child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state.successMessage != null &&
                        state.successMessage!.isNotEmpty) {
                      AppSnackbar.showSuccess(context, state.successMessage!);
                    }
                    if (state.errorMessage != null &&
                        state.errorMessage!.isNotEmpty) {
                      AppSnackbar.showError(context, state.errorMessage!);
                    }
                    if (state.isPasswordReset) {
                      context.pop();
                    }
                  },
                  child: Form(
                    key: formKey,
                    child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder: (context, state) {
                        final cubit = context.read<ForgotPasswordCubit>();

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),

                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: const Icon(Icons.arrow_back),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Forgot password",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "We have sent a reset code to your registered email.",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 30),

                                Stack(
                                  children: [
                                    AbsorbPointer(
                                      absorbing: state.isOtpSent,
                                      child: CustomTextField(
                                        heading: "Email address",
                                        labelText: "Enter your email",
                                        controller: emailController,
                                        // focusNode: emailFocus,
                                        readOnly: state.isOtpSent,
                                        validator: validator.email,
                                      ),
                                    ),
                                    if (state.isOtpSent &&
                                        emailController.text.isNotEmpty)
                                      Positioned(
                                        right: 0,
                                        top: 20,
                                        bottom: 0,
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                            ),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            onPressed: () {
                                              otpController.clear();
                                              cubit.editEmail();
                                              Future.delayed(
                                                const Duration(
                                                  milliseconds: 50,
                                                ),
                                                () {
                                                  if (emailFocus
                                                      .canRequestFocus)
                                                    emailFocus.requestFocus();
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                  ],
                                ),

                                if (state.isOtpSent &&
                                    !state.isPasswordReset) ...[
                                  const SizedBox(height: 10),
                                  AbsorbPointer(
                                    absorbing: state.isOtpVerified,
                                    child: CustomTextField(
                                      heading: "OTP",
                                      labelText: "Enter OTP",
                                      controller: otpController,
                                      keyboardType: TextInputType.number,
                                      validator: validator.notEmpty,
                                      readOnly: state.isOtpVerified,
                                    ),
                                  ),
                                ],

                                if (state.isOtpVerified &&
                                    !state.isPasswordReset) ...[
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    heading: "New Password",
                                    labelText: "Enter new password",
                                    controller: passwordController,
                                    validator: validator.password,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    heading: "Confirm Password",
                                    labelText: "Re-enter new password",
                                    controller: confirmPasswordController,
                                    validator: (value) =>
                                        validator.confirmPassword(
                                          value,
                                          passwordController.text,
                                        ),
                                  ),
                                ],

                                const SizedBox(height: 30),
                                AppButton(
                                  text: state.isPasswordReset
                                      ? 'Done'
                                      : state.isOtpVerified
                                      ? 'Reset Password'
                                      : state.isOtpSent
                                      ? 'Verify OTP'
                                      : 'Send OTP',
                                  isLoading: state.isLoading,
                                  onPressed: () {
                                    if (!formKey.currentState!.validate())
                                      return;

                                    if (!state.isOtpSent) {
                                      cubit.sendOtp(
                                        emailController.text.trim(),
                                      );
                                    } else if (!state.isOtpVerified) {
                                      cubit.verifyOtp(
                                        email: emailController.text.trim(),
                                        otp: otpController.text.trim(),
                                      );
                                    } else {
                                      cubit.resetPassword(
                                        email: emailController.text.trim(),
                                        otp: otpController.text.trim(),
                                        newPassword: passwordController.text
                                            .trim(),
                                        confirmPassword:
                                            confirmPasswordController.text
                                                .trim(),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
