import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upd8s/core/constants/app_images.dart';
import 'package:upd8s/core/widgets/app_button.dart';

class ProfileHeaderSection extends StatelessWidget {
  final String coverImage;
  final String profileImage;
  final String name;
  final String email;

  final bool isOwnProfile;

  final VoidCallback? onBack;
  final VoidCallback? onEditProfile;
  final VoidCallback? onSettings;

  const ProfileHeaderSection({
    super.key,
    required this.coverImage,
    required this.profileImage,
    required this.name,
    required this.email,
    this.isOwnProfile = true,
    this.onBack,
    this.onEditProfile,
    this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// HEADER
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(coverImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                onTap: onBack ?? () => Navigator.pop(context),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),

            Positioned(
              bottom: -40,
              left: 0,
              right: 0,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(profileImage),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 50),

        /// NAME
        Text(
          name,
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 2),

        /// EMAIL
        Text(
          email,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
        ),

        const SizedBox(height: 16),

        /// ACTIONS (Only if own profile)
        if (isOwnProfile)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: AppBorderButton(
                    text: 'Edit Profile',
                    onPressed: onEditProfile ?? () {},
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: onSettings,
                  child: SvgPicture.asset(AppAssets.edit, height: 44),
                ),
              ],
            ),
          ),

        if (isOwnProfile) const SizedBox(height: 20),
      ],
    );
  }
}
