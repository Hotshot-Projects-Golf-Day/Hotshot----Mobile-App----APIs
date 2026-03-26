import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upd8s/core/constants/app_images.dart';
import 'package:upd8s/core/helper/app_validations.dart';
import 'package:upd8s/core/theme/app_colors.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/app_button.dart';
import 'package:upd8s/core/widgets/app_snackbar.dart';
import 'package:upd8s/core/widgets/custom_text_field.dart';
import 'package:upd8s/features/auth/presentation/widgets/auth_bottom_text.dart';
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

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
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
                            onTap: () {
                              context.pushNamed(AppRoute.forgotPassword.name);
                            },
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
                          onPressed: () {
                            // if (_formKey.currentState!.validate()) {
                            //   // AppSnackbar.showSuccess(context, 'Under development');
                            //   context.goNamed(AppRoute.home.name);
                            // }
                            context.goNamed(AppRoute.home.name);
                          },
                        ),

                        const SizedBox(height: 16),

                        AuthBottomText(
                          firstText: "Create a new account?",
                          secondText: "Sign up",
                          onTap: () {
                            context.pushNamed(AppRoute.signup.name);
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
      ),
    );
  }
}
