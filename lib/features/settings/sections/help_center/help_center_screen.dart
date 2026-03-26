import 'package:flutter/material.dart';
import 'package:upd8s/core/helper/app_validations.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/app_button.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';
import 'package:upd8s/core/widgets/custom_text_field.dart';

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
                  title: "Help center",
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                debugPrint("Title: ${titleController.text}");
                                debugPrint(
                                  "Message: ${descriptionController.text}",
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
    );
  }
}
