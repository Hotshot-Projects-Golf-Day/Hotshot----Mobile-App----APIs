// create_post_repository.dart

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:upd8s/core/helper/api_client.dart';
import 'package:upd8s/core/helper/endpoint.dart';

enum MediaType { image, video }

enum PostType { feed, advertisement }

class CreatePostRepository {
  final ApiClient _apiClient = ApiClient.instance;

  Future<String> createPost({
    required String content,
    required PostType postType,
    List<File>? mediaFiles,
    MediaType? mediaType,
    String? adUrl,
    String? adDuration,
  }) async {
    final formData = FormData();

    // ── Core fields ───────────────────────────────────────────
    formData.fields.addAll([
      MapEntry("content", content),
      MapEntry("postType", postType.name),
    ]);

    // ── Advertisement-only fields ──────────────────────────────
    if (postType == PostType.advertisement) {
      if (adUrl != null) formData.fields.add(MapEntry("adUrl", adUrl));
      if (adDuration != null)
        formData.fields.add(MapEntry("duration", adDuration));
    }

    // ── Media files (multipart) ────────────────────────────────
    if (mediaFiles != null && mediaFiles.isNotEmpty) {
      formData.fields.add(MapEntry("mediaType", mediaType!.name));

      for (final file in mediaFiles) {
        final fileName = file.path.split('/').last;
        final mimeType = _resolveMime(mediaType, fileName);

        formData.files.add(
          MapEntry(
            "files",
            await MultipartFile.fromFile(
              file.path,
              filename: fileName,
              contentType: DioMediaType.parse(mimeType),
            ),
          ),
        );
      }
    }

    final response = await _apiClient.post(
      Endpoints.createPost,
      data: formData,
      useToken: true,
    );

    // Response shape: { data: { message: "..." }, message: "..." }
    return response.data?["data"]?["message"] as String? ??
        response.data?["message"] as String? ??
        "Post created successfully.";
  }

  // ── MIME resolver ─────────────────────────────────────────────
  String _resolveMime(MediaType type, String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    if (type == MediaType.video) {
      return switch (ext) {
        'mp4' => 'video/mp4',
        'mov' => 'video/quicktime',
        'avi' => 'video/x-msvideo',
        'mkv' => 'video/x-matroska',
        _ => 'video/mp4',
      };
    }
    return switch (ext) {
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'webp' => 'image/webp',
      'heic' => 'image/heic',
      _ => 'image/jpeg',
    };
  }
}
