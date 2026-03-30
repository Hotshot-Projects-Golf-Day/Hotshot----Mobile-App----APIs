import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upd8s/core/constants/app_images.dart';
import 'package:upd8s/core/data/location_data.dart';
import 'package:upd8s/core/theme/app_colors.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/app_toggle_switch.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';
import 'package:upd8s/core/widgets/app_button.dart';
import 'package:upd8s/core/widgets/custom_text_field.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  bool isFirstSelected = true;

  String? selectedDuration;
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
                  title: "Create Post",
                  leadingIcon: Icons.close,
                  showBackButton: true,
                ),
                SizedBox(height: 10),
                AppToggleSwitch(
                  firstTitle: "Feed",
                  secondTitle: "Advertisement",
                  isFirstSelected: isFirstSelected,
                  selectedColor: AppColor.primaryColor2,
                  onChanged: (val) {
                    setState(() => isFirstSelected = val);
                  },
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextField(
                            labelText: 'What’s on your mind',
                            maxLines: 5,
                            maxLength: 100,
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildAction(AppAssets.images, "Add a photo"),
                              _buildAction(AppAssets.gallery, "Add a video"),
                              _buildAction(AppAssets.camera, "Camera"),
                            ],
                          ),
                          SizedBox(height: 20),
                          isFirstSelected
                              ? SizedBox.shrink()
                              : Column(
                                  children: [
                                    CustomDropdownField(
                                      heading: 'Duration',
                                      hintText: "Select duration",
                                      value: selectedDuration,
                                      items: AdsDurationData.durations,
                                      onChanged: (val) {
                                        setState(() => selectedDuration = val);
                                      },
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Please select duration";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),

                                    CustomTextField(
                                      heading: "Enter Advertisement URl",
                                      controller: _urlController,
                                      labelText: 'Enter Advertisement URL',
                                      keyboardType: TextInputType.url,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: AppButton(
                    text: "Post",
                    backgroundColor: AppColor.primary100,
                    onPressed: () {
                      print(_controller.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAction(String icon, String label) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
