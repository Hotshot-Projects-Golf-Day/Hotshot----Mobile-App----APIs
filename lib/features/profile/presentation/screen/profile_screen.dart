import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/features/profile/presentation/widgets/post_tab_bar_widget.dart';
import 'package:upd8s/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:upd8s/routes/app_router.dart';

class ProfileScreen extends StatefulWidget {
  final bool isOwnProfile;
  ProfileScreen({super.key, this.isOwnProfile = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTab = 0;

  final String coverImage =
      "https://img.freepik.com/free-vector/large-school-building-scene_1308-32058.jpg";

  final String profileImage =
      "https://static.vecteezy.com/system/resources/previews/004/641/880/non_2x/illustration-of-high-school-building-school-building-free-vector.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppBackground(
          child: Column(
            children: [
              /// HEADER
              ProfileHeaderSection(
                coverImage: coverImage,
                profileImage: profileImage,
                name: "Hilton College",
                email: "info@hilton.com",
                isOwnProfile: widget.isOwnProfile,
                onEditProfile: () {},
                onSettings: () {
                  context.pushNamed(AppRoute.setting.name);
                },
              ),

              /// TAB
              PostTabBar(
                selectedIndex: selectedTab,
                onTap: (index) {
                  setState(() => selectedTab = index);
                },
              ),

              const SizedBox(height: 10),

              /// GRID
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (_, __) =>
                      Image.network(coverImage, fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
