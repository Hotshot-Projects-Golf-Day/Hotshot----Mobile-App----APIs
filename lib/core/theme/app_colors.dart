import 'package:flutter/material.dart';

class AppColor {
  static const Color primaryColor = Color(0xff0075FB);
  static const Color primaryColor2 = Color(0xff5FE335);

  static const Color secondaryColor = Color(0xff083793);

  static const Color natural = Color(0xFF555555);
  // primary
  static const Color primary5 = Color(0xffEAF5E5);
  static const Color primary10 = Color(0xffD5EBCC);
  static const Color primary40 = Color(0xff9CD17B);
  static const Color primary70 = Color(0xff5BAB52);
  static const Color primary100 = Color(0xff0075FB);

  // secondary
  static const Color secondary5 = Color(0xffF5F6F8);
  static const Color secondary10 = Color(0xffCCD9F5);
  static const Color secondary40 = Color(0xff6690D9);
  static const Color secondary70 = Color(0xff194BB3);
  static const Color secondary100 = Color(0xff5FE335);

  // Shades for Natural
  static const Color natural0 = Color(0xFFFFFFFF);
  static const Color natural3 = Color(0xFFF8F8F8);

  static const Color natural5 = Color(0xFFF2F2F2);
  static const Color natural10 = Color(0xFFD9D9D9);
  static const Color natural40 = Color(0xFFAAAAAA);
  static const Color natural70 = Color(0xFF555555);
  static const Color natural100 = Color(0xff0C0C0C);

  // Other colors
  static const Color blackColor = Color(0xff000000);
  static const Color greyColor = Color(0xffF3F3F3);
  static const Color redColor = Color(0xFFFF3A6F);
  static const Color hintTextColor = Color(0xFFC7C5C5);
  static const Color greyShadeColor = Color(0xFFD8D8D8);
  static const Color brownColor = Color(0xFF686868);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color orangeColor = Color(0xFFFFA500);

  //
  static const Color appColor = Color(0xFF1F333C);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xff00A3E0), Color(0xff0078A3)],
  );

  static const LinearGradient customGradient = LinearGradient(
    colors: [Color(0xFF36556A), Color(0x99000000)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
