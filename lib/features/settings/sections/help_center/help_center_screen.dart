import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:upd8s/core/helper/app_validations.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/app_button.dart';
import 'package:upd8s/core/widgets/app_snackbar.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';
import 'package:upd8s/core/widgets/custom_text_field.dart';
import 'package:upd8s/features/settings/cubit/account_cubit.dart';
import 'package:upd8s/features/settings/cubit/account_state.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final Validator validator = Validator(errorText: "");

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<AccountCubit>().submitHelpCenter(
        title: titleController.text,
        description: descriptionController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state.status == AccountStatus.helpCenterSuccess) {
          AppSnackbar.showSuccess(
            context,
            state.successMessage ?? "Query submitted successfully.",
          );
          context.pop();
        } else if (state.status == AccountStatus.failure) {
          AppSnackbar.showError(
            context,
            state.errorMessage ?? "Something went wrong.",
          );

          Future.delayed(const Duration(milliseconds: 100), () {
            if (context.mounted) {
              context.read<AccountCubit>().resetState();
            }
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: AppBackground(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).unfocus(),
                child: Column(
                  children: [
                    const CustomAppBarWidget(
                      title: "Help Center",
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
                                heading: "Title",
                                labelText: "Enter here",
                                controller: titleController,
                                validator: validator.notEmpty,
                              ),

                              const SizedBox(height: 16),

                              CustomTextField(
                                heading: "Description",
                                labelText: "Write your message...",
                                controller: descriptionController,
                                maxLines: 5,
                                validator: validator.notEmpty,
                              ),

                              const Spacer(),

                              AppButton(
                                text: "Submit",
                                onPressed: state.isLoading ? null : _onSubmit,
                                isLoading: state.isLoading,
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
      },
    );
  }
}
