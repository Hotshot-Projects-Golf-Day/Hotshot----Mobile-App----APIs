import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:upd8s/core/helper/app_validations.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/app_button.dart';
import 'package:upd8s/core/widgets/app_snackbar.dart';
import 'package:upd8s/core/widgets/custom_text_field.dart';
import 'package:upd8s/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:upd8s/features/auth/presentation/cubit/auth_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  final validator = Validator(errorText: "");

  @override
  void initState() {
    super.initState();
    emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.successMessage?.isNotEmpty == true) {
            AppSnackbar.showSuccess(context, state.successMessage!);
          }
          if (state.errorMessage?.isNotEmpty == true) {
            AppSnackbar.showError(context, state.errorMessage!);
          }
          if (state.status == AuthStatus.passwordReset) {
            context.pop();
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();

            final isOtpSent =
                state.status == AuthStatus.otpSent ||
                state.status == AuthStatus.forgotOtpVerified ||
                state.status == AuthStatus.passwordReset;
            final isOtpVerified = state.status == AuthStatus.forgotOtpVerified;

            return Scaffold(
              body: SafeArea(
                child: AppBackground(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),

                              /// BACK BUTTON
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Icon(Icons.arrow_back),
                              ),
                              const SizedBox(height: 10),

                              /// TITLE
                              const Text(
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

                              /// EMAIL
                              Stack(
                                children: [
                                  AbsorbPointer(
                                    absorbing: isOtpSent,
                                    child: CustomTextField(
                                      heading: "Email address",
                                      labelText: "Enter your email",
                                      controller: emailController,

                                      readOnly: isOtpSent,
                                      validator: validator.email,
                                    ),
                                  ),
                                  if (isOtpSent &&
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
                                            cubit.resetState();
                                            Future.delayed(
                                              const Duration(milliseconds: 50),
                                              () {
                                                if (emailFocus
                                                    .canRequestFocus) {
                                                  emailFocus.requestFocus();
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              /// OTP FIELD
                              if (isOtpSent && !isOtpVerified) ...[
                                const SizedBox(height: 10),
                                AbsorbPointer(
                                  absorbing: isOtpVerified,
                                  child: CustomTextField(
                                    heading: "OTP",
                                    labelText: "Enter OTP",
                                    controller: otpController,
                                    keyboardType: TextInputType.number,
                                    readOnly: isOtpVerified,
                                    validator: validator.notEmpty,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: state.isLoading
                                        ? null
                                        : () => cubit.resendResetOtp(
                                            email: emailController.text.trim(),
                                          ),
                                    child: const Text("Resend OTP"),
                                  ),
                                ),
                              ],

                              /// NEW PASSWORD FIELDS
                              if (isOtpVerified) ...[
                                const SizedBox(height: 10),
                                CustomTextField(
                                  heading: "New Password",
                                  labelText: "Enter new password",
                                  controller: passwordController,
                                  isPassword: true,
                                  validator: validator.password,
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  heading: "Confirm Password",
                                  labelText: "Re-enter new password",
                                  controller: confirmPasswordController,
                                  isPassword: true,
                                  validator: (value) =>
                                      validator.confirmPassword(
                                        value,
                                        passwordController.text,
                                      ),
                                ),
                              ],

                              const SizedBox(height: 30),

                              /// BUTTON
                              AppButton(
                                text: isOtpVerified
                                    ? 'Reset Password'
                                    : isOtpSent
                                    ? 'Verify OTP'
                                    : 'Send OTP',
                                isLoading: state.isLoading,
                                onPressed: () {
                                  if (!formKey.currentState!.validate()) return;

                                  if (!isOtpSent) {
                                    cubit.forgotPassword(
                                      email: emailController.text.trim(),
                                    );
                                  } else if (!isOtpVerified) {
                                    cubit.verifyForgotPasswordOtp(
                                      email: emailController.text.trim(),
                                      otp: otpController.text.trim(),
                                    );
                                  } else {
                                    cubit.resetPassword(
                                      email: emailController.text.trim(),
                                      otp: otpController.text.trim(),
                                      newPassword: passwordController.text
                                          .trim(),
                                      confirmPassword: confirmPasswordController
                                          .text
                                          .trim(),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
