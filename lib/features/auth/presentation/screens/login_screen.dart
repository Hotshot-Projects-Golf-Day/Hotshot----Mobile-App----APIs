import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:upd8s/core/constants/app_images.dart';
import 'package:upd8s/core/helper/app_validations.dart';
import 'package:upd8s/core/theme/app_colors.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/app_button.dart';
import 'package:upd8s/core/widgets/app_snackbar.dart';
import 'package:upd8s/core/widgets/custom_text_field.dart';
import 'package:upd8s/features/auth/presentation/cubit/auth_state.dart';
import 'package:upd8s/features/auth/presentation/widgets/auth_bottom_text.dart';
import 'package:upd8s/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:upd8s/routes/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final validator = Validator(errorText: '');

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
          if (state.status == AuthStatus.loginSuccess) {
            context.goNamed(AppRoute.home.name);
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: AppBackground(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(AppAssets.logo, height: 60),
                                const SizedBox(height: 40),
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.natural100,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CustomTextField(
                                  heading: "Email address",
                                  labelText: "Enter your email",
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: validator.email,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  heading: "Password",
                                  labelText: "Enter your password",
                                  controller: passwordController,
                                  isPassword: true,
                                  validator: validator.password,
                                ),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () => context.pushNamed(
                                      AppRoute.forgotPassword.name,
                                    ),
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColor.natural100,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                AppButton(
                                  text: "Login",
                                  isLoading: state.isLoading,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthCubit>().login(
                                        email: emailController.text.trim(),
                                        password: passwordController.text
                                            .trim(),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(height: 16),
                                AuthBottomText(
                                  firstText: "Create a new account?",
                                  secondText: "Sign up",
                                  onTap: () =>
                                      context.pushNamed(AppRoute.signup.name),
                                ),
                              ],
                            ),
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
