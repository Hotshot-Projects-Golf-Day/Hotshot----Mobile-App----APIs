// create_post_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upd8s/core/constants/app_images.dart';
import 'package:upd8s/core/data/location_data.dart';
import 'package:upd8s/core/repository/create_post_repository.dart';
import 'package:upd8s/core/theme/app_colors.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/app_snackbar.dart';
import 'package:upd8s/core/widgets/app_toggle_switch.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';
import 'package:upd8s/core/widgets/app_button.dart';
import 'package:upd8s/core/widgets/custom_text_field.dart';
import 'package:upd8s/features/post/cubit/create_post_cubit.dart';
import 'package:upd8s/features/post/cubit/create_post_state.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreatePostCubit(),
      child: const _CreatePostView(),
    );
  }
}

class _CreatePostView extends StatefulWidget {
  const _CreatePostView();

  @override
  State<_CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<_CreatePostView> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreatePostCubit, CreatePostState>(
      // ✅ FIX 1: Only listen when these specific fields actually CHANGE
      listenWhen: (previous, current) =>
          previous.isSuccess != current.isSuccess ||
          previous.errorMessage != current.errorMessage,

      listener: (context, state) {
        if (state.isSuccess) {
          AppSnackbar.showSuccess(context, 'Post created successfully!');
          Navigator.pop(context);
        }
        if (state.errorMessage != null) {
          AppSnackbar.showError(context, state.errorMessage!);
        }
      },
      builder: (context, state) {
        final cubit = context.read<CreatePostCubit>();

        return Scaffold(
          body: SafeArea(
            child: AppBackground(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).unfocus(),
                child: Column(
                  children: [
                    const CustomAppBarWidget(
                      title: "Create Post",
                      leadingIcon: Icons.close,
                      showBackButton: true,
                    ),
                    const SizedBox(height: 10),

                    // ── Toggle ───────────────────────────────────
                    AppToggleSwitch(
                      firstTitle: "Feed",
                      secondTitle: "Advertisement",
                      isFirstSelected: state.postType == PostType.feed,
                      selectedColor: AppColor.primaryColor2,
                      onChanged: (val) => cubit.setPostType(
                        val ? PostType.feed : PostType.advertisement,
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ── Content field ─────────────────
                              CustomTextField(
                                controller: _contentController,
                                labelText: "What's on your mind",
                                maxLines: 5,
                                maxLength: 100,
                              ),
                              const SizedBox(height: 30),

                              // ── Media action buttons ──────────
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildAction(
                                    AppAssets.images,
                                    "Add a photo",
                                    onTap: cubit.pickImage,
                                  ),
                                  _buildAction(
                                    AppAssets.gallery,
                                    "Add a video",
                                    onTap: cubit.pickVideo,
                                  ),
                                  _buildAction(
                                    AppAssets.camera,
                                    "Camera",
                                    onTap: cubit.pickFromCamera,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // ── Selected media preview ────────
                              if (state.selectedFiles.isNotEmpty)
                                _MediaPreview(
                                  file: state.selectedFiles.first,
                                  mediaType: state.mediaType!,
                                  onRemove: cubit.removeMedia,
                                ),

                              const SizedBox(height: 20),

                              // ── Advertisement fields ──────────
                              if (state.isAdvertisement) ...[
                                CustomDropdownField(
                                  heading: 'Duration',
                                  hintText: "Select duration",
                                  value: state.adDuration,
                                  items: AdsDurationData.durations,
                                  onChanged: (val) {
                                    if (val != null) cubit.setAdDuration(val);
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
                                  heading: "Enter Advertisement URL",
                                  controller: _urlController,
                                  labelText: 'Enter Advertisement URL',
                                  keyboardType: TextInputType.url,
                                  onChanged: cubit.setAdUrl,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ── Post button ──────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: AppButton(
                        text: state.isSubmitting ? "Posting..." : "Post",
                        backgroundColor: AppColor.primary100,
                        onPressed: state.isSubmitting
                            ? null
                            : () => cubit.submitPost(_contentController.text),
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

  Widget _buildAction(
    String icon,
    String label, {
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}

// ── Media Preview Widget ──────────────────────────────────────────
class _MediaPreview extends StatelessWidget {
  final File file;
  final MediaType mediaType;
  final VoidCallback onRemove;

  const _MediaPreview({
    required this.file,
    required this.mediaType,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: mediaType == MediaType.image
              ? Image.file(
                  file,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.black12,
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill,
                      size: 56,
                      color: Colors.white,
                    ),
                  ),
                ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}
