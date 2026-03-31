// create_post_state.dart

import 'dart:io';
import 'package:upd8s/core/repository/create_post_repository.dart';


class CreatePostState {
  final PostType postType;
  final MediaType? mediaType;
  final List<File> selectedFiles;
  final String? adUrl;
  final String? adDuration;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const CreatePostState({
    this.postType = PostType.feed,
    this.mediaType,
    this.selectedFiles = const [],
    this.adUrl,
    this.adDuration,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  bool get isAdvertisement => postType == PostType.advertisement;

  CreatePostState copyWith({
    PostType? postType,
    MediaType? mediaType,
    bool clearMediaType = false,
    List<File>? selectedFiles,
    String? adUrl,
    bool clearAdUrl = false,
    String? adDuration,
    bool clearAdDuration = false,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CreatePostState(
      postType: postType ?? this.postType,
      mediaType: clearMediaType ? null : (mediaType ?? this.mediaType),
      selectedFiles: selectedFiles ?? this.selectedFiles,
      adUrl: clearAdUrl ? null : (adUrl ?? this.adUrl),
      adDuration: clearAdDuration ? null : (adDuration ?? this.adDuration),
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}