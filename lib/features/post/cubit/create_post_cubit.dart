// create_post_cubit.dart

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upd8s/core/repository/create_post_repository.dart';
import 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final CreatePostRepository _repository;
  final ImagePicker _picker = ImagePicker();

  CreatePostCubit({CreatePostRepository? repository})
    : _repository = repository ?? CreatePostRepository(),
      super(const CreatePostState());

  // ── Toggle Feed / Advertisement ───────────────────────────────
  void setPostType(PostType type) {
    emit(
      state.copyWith(
        postType: type,
        clearAdUrl: type == PostType.feed,
        clearAdDuration: type == PostType.feed,
        clearError: true,
      ),
    );
  }

  // ── Advertisement fields ──────────────────────────────────────
  void setAdUrl(String url) =>
      emit(state.copyWith(adUrl: url, clearError: true));

  void setAdDuration(String duration) =>
      emit(state.copyWith(adDuration: duration, clearError: true));

  // ── Media pickers ─────────────────────────────────────────────
  Future<void> pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      emit(
        state.copyWith(
          selectedFiles: [File(picked.path)],
          mediaType: MediaType.image,
          clearError: true, // ✅ FIX 2
        ),
      );
    }
  }

  Future<void> pickVideo() async {
    final picked = await _picker.pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      emit(
        state.copyWith(
          selectedFiles: [File(picked.path)],
          mediaType: MediaType.video,
          clearError: true,
        ),
      );
    }
  }

  Future<void> pickFromCamera() async {
    final picked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (picked != null) {
      emit(
        state.copyWith(
          selectedFiles: [File(picked.path)],
          mediaType: MediaType.image,
          clearError: true,
        ),
      );
    }
  }

  void removeMedia() {
    emit(
      state.copyWith(selectedFiles: [], clearMediaType: true, clearError: true),
    );
  }

  // ── Submit ────────────────────────────────────────────────────
  Future<void> submitPost(String content) async {
    emit(state.copyWith(clearError: true));

    if (content.trim().isEmpty) {
      emit(state.copyWith(errorMessage: "Post content cannot be empty."));
      return;
    }
    if (state.isAdvertisement) {
      if (state.adDuration == null || state.adDuration!.isEmpty) {
        emit(state.copyWith(errorMessage: "Please select an ad duration."));
        return;
      }
      if (state.adUrl == null || state.adUrl!.isEmpty) {
        emit(
          state.copyWith(errorMessage: "Please enter an advertisement URL."),
        );
        return;
      }
    }

    emit(state.copyWith(isSubmitting: true));

    try {
      await _repository.createPost(
        content: content.trim(),
        postType: state.postType,
        mediaFiles: state.selectedFiles.isEmpty ? null : state.selectedFiles,
        mediaType: state.mediaType,
        adUrl: state.adUrl,
        adDuration: state.adDuration,
      );
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
    }
  }

  void reset() => emit(const CreatePostState());
}
