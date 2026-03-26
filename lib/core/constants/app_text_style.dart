
import 'package:flutter/material.dart';
import 'package:upd8s/core/constants/dimensions.dart';
import 'package:upd8s/core/theme/app_colors.dart';



class AppTextStyle {
  static TextStyle signupStyle = TextStyle(
    fontSize: Dimensions.font18,
    fontWeight: FontWeight.w400,
    color: const Color(0xff979797),
  );

  static TextStyle loginStyle = TextStyle(
    fontSize: Dimensions.font23,
    fontWeight: FontWeight.w700,
  );

  static TextStyle loginTiny = TextStyle(
    fontSize: Dimensions.font12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle onboardingTitle = TextStyle(
    fontSize: Dimensions.font23,
    fontWeight: FontWeight.bold,
    height: 1.4,
    letterSpacing: -0.345,
  );

  static TextStyle onboardingSubtitle = TextStyle(
    fontSize: Dimensions.font15,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: -0.15,
    color: AppColor.natural70,
  );

  // Home
  static TextStyle heading = TextStyle(
    fontSize: Dimensions.font20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle subheading = TextStyle(
    fontSize: Dimensions.font14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleBold = TextStyle(
    fontSize: Dimensions.font16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle captionLightPrimary = TextStyle(
    fontSize: Dimensions.font12,
    fontWeight: FontWeight.w300,
    color: AppColor.primary100,
  );

  static TextStyle caption = TextStyle(
    fontSize: Dimensions.font10,
    fontWeight: FontWeight.w300,
  );
}
