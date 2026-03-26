import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upd8s/core/constants/app_images.dart';
import 'package:upd8s/core/theme/app_colors.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/custom_app_bar.dart';
import 'package:upd8s/core/widgets/app_button.dart';

class MembershipPlanScreen extends StatelessWidget {
  const MembershipPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppBackground(
          child: Column(
            children: [
              const CustomAppBarWidget(
                title: "Membership Plan",
                showBackButton: true,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    children: const [
                      MembershipCard(
                        title: "Basic Plan",
                        price: "Free",
                        features: [
                          "Limited access",
                          "Basic support",
                          "Standard features",
                        ],
                        isActive: true,
                      ),

                      MembershipCard(
                        title: "Premium Plan",
                        price: "\$499 / month",
                        features: [
                          "Unlimited access",
                          "Priority support",
                          "All premium features",
                        ],
                      ),

                      MembershipCard(
                        title: "Pro Plan",
                        price: "\$999 / month",
                        features: [
                          "All Premium benefits",
                          "Dedicated support",
                          "Exclusive features",
                        ],
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

class MembershipCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final bool isActive;

  const MembershipCard({
    super.key,
    required this.title,
    required this.price,
    required this.features,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        // border: Border.all(
        //   color: isActive ? Colors.green : Colors.transparent,
        //   width: 1.5,
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title + Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// Section Title
          const Text(
            'Plan includes',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              height: 1.4, // line-height equivalent
            ),
          ),

          const SizedBox(height: 8),

          /// Features List
          ...features.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  SvgPicture.asset(AppAssets.polygon),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      e,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// Button
          AppButton(
            backgroundColor: isActive
                ? AppColor.primary100
                : AppColor.secondary100,
            text: isActive ? "Current Plan" : "Choose Plan",
            onPressed: isActive ? null : () {},
          ),
        ],
      ),
    );
  }
}
