import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upd8s/core/constants/app_images.dart';
import 'package:upd8s/core/theme/app_colors.dart';

class HomeTopBar extends StatelessWidget {
  final String schoolName;
  final String logoUrl;

  final VoidCallback? onNotificationTap;
  final VoidCallback? onCreateTap;
  final VoidCallback? onFilterTap;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onLogoTap;
  HomeTopBar({
    super.key,
    required this.schoolName,
    required this.logoUrl,
    this.onLogoTap,
    this.onNotificationTap,
    this.onCreateTap,
    this.onFilterTap,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              InkWell(
                onTap: onLogoTap,
                borderRadius: BorderRadius.circular(30),
                child: CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(logoUrl),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  schoolName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              InkWell(
                onTap: onNotificationTap,
                child: SvgPicture.asset(AppAssets.notification),
              ),

              const SizedBox(width: 16),

              InkWell(
                onTap: onCreateTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.primary100,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssets.add),
                      const SizedBox(width: 6),
                      const Text(
                        "Create",
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.search),

                const SizedBox(width: 12),

                Expanded(
                  child: TextField(
                    autofocus: false,
                    onChanged: onSearch,
                    enabled: false,
                    decoration: const InputDecoration(
                      hintText: "Search what you need...",
                      filled: true,
                      fillColor: Colors.white,

                      hintStyle: TextStyle(
                        color: Color(0xFF9B9E9F),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,

                        // height: 1.4,
                        // fontFamily: "Aptos",
                      ),

                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,

                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),

                InkWell(
                  onTap: onFilterTap,
                  child: SvgPicture.asset(AppAssets.filter),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
