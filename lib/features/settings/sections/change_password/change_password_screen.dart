import 'package:flutter/material.dart';
import 'package:upd8s/core/helper/app_validations.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/app_button.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';
import 'package:upd8s/core/widgets/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final Validator validator = Validator(errorText: "");

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      print("Current: ${oldPasswordController.text}");
      print("New: ${newPasswordController.text}");
      print("Confirm: ${confirmPasswordController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppBackground(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                const CustomAppBarWidget(
                  title: "Change Password",
                  showBackButton: true,
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            heading: "Current Password",
                            labelText: "Enter current password",
                            controller: oldPasswordController,
                            validator: validator.password,
                            isPassword: true,
                          ),
                          const SizedBox(height: 16),

                          CustomTextField(
                            heading: "New Password",
                            labelText: "Enter new password",
                            controller: newPasswordController,
                            validator: validator.password,
                            isPassword: true,
                          ),
                          const SizedBox(height: 16),

                          CustomTextField(
                            heading: "Confirm Password",
                            labelText: "Re-enter new password",
                            isPassword: true,
                            controller: confirmPasswordController,
                            validator: (value) => validator.confirmPassword(
                              value,
                              newPasswordController.text,
                            ),
                          ),

                          const Spacer(),

                          AppButton(
                            text: "Update Password",
                            onPressed: _onSubmit,
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
    );
  }
}
