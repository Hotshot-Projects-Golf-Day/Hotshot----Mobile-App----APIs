import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:upd8s/core/constants/app_images.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';
import 'package:upd8s/features/settings/presentation/widgets/logout_dialog.dart';
import 'package:upd8s/routes/app_router.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Widget settingItem({
    required String title,
    required String icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon, height: 24, width: 24),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppBackground(
          child: Column(
            children: [
              const CustomAppBarWidget(title: 'Settings', showBackButton: true),

              const SizedBox(height: 20),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: [
                      settingItem(
                        title: "Change password",
                        icon: AppAssets.changePassword,
                        onTap: () {
                          context.pushNamed(AppRoute.changePassword.name);
                        },
                      ),
                      settingItem(
                        title: "Help Center",
                        icon: AppAssets.helpCentre,
                        onTap: () {
                          context.pushNamed(AppRoute.helpCenter.name);
                        },
                      ),

                      settingItem(
                        title: "FAQ’s",
                        icon: AppAssets.faq,

                        onTap: () {
                          context.pushNamed(AppRoute.faq.name);
                        },
                      ),

                      settingItem(
                        title: "Membership plan",
                        icon: AppAssets.membership,
                        onTap: () {
                          context.pushNamed(AppRoute.membership.name);
                        },
                      ),

                      settingItem(
                        title: "Policies",
                        icon: AppAssets.policies,

                        onTap: () {
                          context.pushNamed(AppRoute.policies.name);
                        },
                      ),

                      settingItem(
                        title: "Logout",
                        icon: AppAssets.logout,
                        onTap: () => showLogoutDialog(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
