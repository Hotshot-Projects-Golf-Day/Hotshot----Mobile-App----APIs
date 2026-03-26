import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upd8s/core/constants/app_images.dart';
import 'package:upd8s/core/widgets/custom_text_field.dart';
import 'package:upd8s/features/profile/presentation/widgets/comment_title.dart';

class CommentsBottomSheet extends StatelessWidget {
  const CommentsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // This makes the bottom sheet move up when the keyboard appears
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        // You can remove fixed height or keep it as max height
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            // Title
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "All comments",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 12),

            // Comments list
            Expanded(
              child: ListView(
                children: [
                  CommentTile(),
                  const SizedBox(height: 10),
                  CommentTile(),
                  const SizedBox(height: 10),
                  CommentTile(),
                ],
              ),
            ),

            // Input field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Expanded(
                    child: CustomTextField(labelText: 'Write your message'),
                  ),
                  const SizedBox(width: 5),
                  CircleAvatar(
                    child: SvgPicture.asset(AppAssets.sendMessage, height: 50),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
