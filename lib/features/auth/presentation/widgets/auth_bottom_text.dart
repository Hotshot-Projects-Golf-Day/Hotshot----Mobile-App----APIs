import 'package:flutter/material.dart';
import 'package:upd8s/core/theme/app_colors.dart';

class AuthBottomText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback onTap;

  const AuthBottomText({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            firstText,
            style: const TextStyle(
              fontFamily: 'Aptos',
              fontSize: 14,
              color: AppColor.natural70,
            ),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: onTap,
            child: const Text(
              "Sign up",
              style: TextStyle(
                fontFamily: 'Aptos',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColor.primary100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
