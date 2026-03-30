import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:upd8s/core/data/location_data.dart';
import 'package:upd8s/core/helper/app_validations.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/app_button.dart';
import 'package:upd8s/core/widgets/app_snackbar.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';
import 'package:upd8s/core/widgets/custom_text_field.dart';
import 'package:upd8s/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:upd8s/features/auth/presentation/cubit/auth_state.dart';
import 'package:upd8s/routes/app_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final validator = Validator(errorText: '');

  String selectedRole = "School";
  bool acceptedTerms = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String? selectedProvince;
  String? selectedCity;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    addressController.dispose();
    passwordController.dispose();
    otpController.dispose();
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
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const CustomAppBarWidget(
                            title: "Create Account",
                            showBackButton: true,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// ROLE
                                    const Text(
                                      "Select your role",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        _roleButton("School"),
                                        _roleButton("Parents"),
                                        _roleButton("Advertiser"),
                                      ],
                                    ),
                                    const SizedBox(height: 16),

                                    /// FULL NAME
                                    CustomTextField(
                                      heading: "Full Name",
                                      labelText: "Enter full name",
                                      controller: nameController,
                                      validator: validator.fullName,
                                    ),
                                    const SizedBox(height: 16),

                                    /// EMAIL
                                    CustomTextField(
                                      heading: "Email Address",
                                      labelText: "Enter your email",
                                      controller: emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: validator.email,
                                    ),
                                    const SizedBox(height: 16),

                                    /// MOBILE
                                    CustomMobileTextField(
                                      heading: "Mobile Number",
                                      controller: mobileController,
                                      isRequired: true,
                                      validator: validator.mobileInternational,
                                    ),
                                    const SizedBox(height: 16),

                                    /// PROVINCE + CITY
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomDropdownField(
                                            heading: "Province",
                                            hintText: "Select province",
                                            value: selectedProvince,
                                            items: LocationData.provinces,
                                            validator: validator.notEmpty,
                                            onChanged: (val) {
                                              setState(() {
                                                selectedProvince = val;
                                                selectedCity = null;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: CustomDropdownField(
                                            heading: "City",
                                            hintText: "Select city",
                                            value: selectedCity,
                                            items: selectedProvince == null
                                                ? []
                                                : LocationData.getCities(
                                                    selectedProvince!,
                                                  ),
                                            validator: validator.notEmpty,
                                            onChanged: (val) {
                                              setState(() {
                                                selectedCity = val;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),

                                    /// ADDRESS
                                    CustomTextField(
                                      heading: "Address",
                                      labelText: "Enter your address",
                                      controller: addressController,
                                      validator: validator.notEmpty,
                                    ),
                                    const SizedBox(height: 16),

                                    /// PASSWORD
                                    CustomTextField(
                                      heading: "Password",
                                      labelText: "Enter your password",
                                      controller: passwordController,
                                      isPassword: true,
                                      validator: validator.password,
                                    ),
                                    const SizedBox(height: 16),

                                    /// OTP FIELD — shown only after successful registration
                                    if (state.status ==
                                        AuthStatus.registerSuccess) ...[
                                      CustomTextField(
                                        heading: "OTP",
                                        labelText:
                                            "Enter OTP sent to your email",
                                        controller: otpController,
                                        keyboardType: TextInputType.number,
                                        validator: validator.notEmpty,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: state.isLoading
                                              ? null
                                              : () =>
                                                    cubit.resendVerificationOtp(
                                                      email: state
                                                          .registeredEmail!,
                                                    ),
                                          child: const Text("Resend OTP"),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                    ],

                                    /// TERMS
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          value: acceptedTerms,
                                          onChanged: (val) {
                                            setState(() {
                                              acceptedTerms = val ?? false;
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              style: const TextStyle(
                                                fontFamily: 'Aptos',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                                height: 1.4,
                                                letterSpacing: -0.065,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                const TextSpan(
                                                  text: "I accept all ",
                                                ),
                                                TextSpan(
                                                  text: "Terms and Conditions",
                                                  style: const TextStyle(
                                                    color: Colors.blue,
                                                  ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () =>
                                                            context.pushNamed(
                                                              AppRoute
                                                                  .terms
                                                                  .name,
                                                            ),
                                                ),
                                                const TextSpan(text: " and "),
                                                TextSpan(
                                                  text: "Privacy Policy",
                                                  style: const TextStyle(
                                                    color: Colors.blue,
                                                  ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () =>
                                                            context.pushNamed(
                                                              AppRoute
                                                                  .privacy
                                                                  .name,
                                                            ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),

                                    /// BUTTON
                                    AppButton(
                                      text:
                                          state.status ==
                                              AuthStatus.registerSuccess
                                          ? "Verify OTP"
                                          : "Signup",
                                      isLoading: state.isLoading,
                                      onPressed: () {
                                        if (!_formKey.currentState!.validate())
                                          return;
                                        if (!acceptedTerms) {
                                          AppSnackbar.showWarning(
                                            context,
                                            "Please accept terms and conditions",
                                          );
                                          return;
                                        }
                                        if (state.status !=
                                            AuthStatus.registerSuccess) {
                                          cubit.register(
                                            role: selectedRole,
                                            name: nameController.text.trim(),
                                            email: emailController.text.trim(),
                                            mobile: mobileController.text
                                                .trim(),
                                            province: selectedProvince ?? '',
                                            city: selectedCity ?? '',
                                            address: addressController.text
                                                .trim(),
                                            password: passwordController.text
                                                .trim(),
                                          );
                                        } else {
                                          cubit.verifySignupOtp(
                                            email: state.registeredEmail!,
                                            otp: otpController.text.trim(),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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

  Widget _roleButton(String role) {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedRole = role),
        child: Row(
          children: [
            Radio<String>(
              value: role,
              groupValue: selectedRole,
              onChanged: (value) => setState(() => selectedRole = value!),
            ),
            Expanded(
              child: Text(
                role,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  height: 1.4,
                  letterSpacing: -0.15,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
