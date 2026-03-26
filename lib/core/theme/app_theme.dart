import 'package:flutter/material.dart';
import 'package:upd8s/core/constants/dimensions.dart';
import 'package:upd8s/core/theme/app_colors.dart';

class AppFonts {
  static const String aptos = "Aptos";
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: AppFonts.aptos,
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: AppColor.natural100,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColor.natural70,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Color(0xff979797),
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColor.natural100,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColor.natural70,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: AppColor.natural100,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: AppColor.natural3,
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      hintStyle: const TextStyle(color: AppColor.hintTextColor, fontSize: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: AppColor.natural3),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: AppColor.natural3),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: AppColor.natural3),
      ),
    ),

    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColor.primaryColor,
          brightness: Brightness.light,
        ).copyWith(
          surface: Colors.white,
          onSurface: Colors.black,
          primary: AppColor.primaryColor,
          secondary: AppColor.secondaryColor,
        ),

    primaryColor: AppColor.primaryColor,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: AppFonts.aptos,
    scaffoldBackgroundColor: Colors.black,
    useMaterial3: true,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: Colors.white70,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      hintStyle: const TextStyle(color: AppColor.natural100),
      labelStyle: const TextStyle(
        color: AppColor.natural100,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: Colors.grey),
      ),
    ),

    colorScheme:
        ColorScheme.fromSeed(
          seedColor: AppColor.primaryColor,
          brightness: Brightness.dark,
        ).copyWith(
          surface: const Color(0xFF1E1E1E),
          onSurface: Colors.white,
          primary: AppColor.primaryColor,
          secondary: AppColor.secondaryColor,
        ),

    primaryColor: AppColor.primaryColor,
  );

  static TextStyle loginStyle(BuildContext context) {
    return TextStyle(
      fontSize: Dimensions.font20,
      fontWeight: FontWeight.w700,
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : AppColor.natural100,
    );
  }
}
