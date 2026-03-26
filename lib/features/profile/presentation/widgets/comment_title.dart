import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upd8s/core/constants/app_images.dart';

class CommentTile extends StatelessWidget {
  CommentTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Avatar
        const CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(
            "https://marketplace.canva.com/EAGdue2NOUs/1/0/1600w/canva-blue-and-yellow-modern-school-logo-meJ5KjyNVT4.jpg",
          ),
        ),

        const SizedBox(width: 10),

        /// Comment Content
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE9EDF3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Name + Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Kriston Watshon",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "08:39 am",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                /// Message
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fringilla natoque id aenean.",
                  style: TextStyle(fontSize: 13),
                ),

                const SizedBox(height: 10),

                /// Only Likes (Reply removed)
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.thumbsUp, height: 16),
                    const SizedBox(width: 6),
                    const Text("1,964"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
