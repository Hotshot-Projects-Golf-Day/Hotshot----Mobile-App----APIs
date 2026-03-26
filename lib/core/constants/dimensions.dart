import 'package:flutter/material.dart';

class Dimensions {
  static late double screenHeight;
  static late double screenWidth;

  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }

  static double get height5 => screenHeight / 156;
  static double get height10 => screenHeight / 78;
  static double get height15 => screenHeight / 52;
  static double get height20 => screenHeight / 39;
  static double get height30 => screenHeight / 26;
  static double get height45 => screenHeight / 17.33;
  static double get height50 => screenHeight / 15.6;
  static double get height60 => screenHeight / 13;
  static double get height70 => screenHeight / 11.14;
  static double get height80 => screenHeight / 9.75;
  static double get height100 => screenHeight / 7.8;
  static double get height120 => screenHeight / 6.5;
  static double get height130 => screenHeight / 6;
  static double get height140 => screenHeight / 5.57;
  static double get height150 => screenHeight / 5.2;
  static double get height160 => screenHeight / 4.87;
  static double get height170 => screenHeight / 4.58;
  static double get height180 => screenHeight / 4.33;
  static double get height190 => screenHeight / 4.1;
  static double get height200 => screenHeight / 3.9;
  static double get height210 => screenHeight / 3.71;
  static double get height220 => screenHeight / 3.54;
  static double get height230 => screenHeight / 3.39;
  static double get height240 => screenHeight / 3.25;
  static double get height250 => screenHeight / 3.12;

  static double get width5 => screenWidth / 156;
  static double get width10 => screenWidth / 78;
  static double get width15 => screenWidth / 52;
  static double get width20 => screenWidth / 39;
  static double get width30 => screenWidth / 26;
  static double get width45 => screenWidth / 17.33;
  static double get width50 => screenWidth / 15.6;
  static double get width60 => screenWidth / 13;
  static double get width80 => screenWidth / 9.75;
  static double get width100 => screenWidth / 7.8;
  static double get width120 => screenWidth / 6.5;
  static double get width130 => screenWidth / 6;
  static double get width140 => screenWidth / 5.57;

  static double get font8 => screenHeight / 97.5;
  static double get font10 => screenHeight / 78;
  static double get font12 => screenHeight / 65;
  static double get font13 => screenHeight / 60;
  static double get font14 => screenHeight / 55.72;
  static double get font15 => screenHeight / 52;
  static double get font16 => screenHeight / 48.75;
  static double get font18 => screenHeight / 43.33;
  static double get font20 => screenHeight / 39;
  static double get font22 => screenHeight / 35.45;
  static double get font23 => screenHeight / 34;

  static double get font24 => screenHeight / 32.5;
  static double get font26 => screenHeight / 30;
  static double get font28 => screenHeight / 27.86;
  static double get font30 => screenHeight / 26;
  static double get font32 => screenHeight / 24.38;
  static double get font36 => screenHeight / 21.67;
  static double get font40 => screenHeight / 19.5;
  static double get font44 => screenHeight / 17.73;

  static double get radius5 => screenHeight / 156;
  static double get radius8 => screenHeight / 97.5;
  static double get radius10 => screenHeight / 78;
  static double get radius12 => screenHeight / 65;
  static double get radius15 => screenHeight / 52;
  static double get radius18 => screenHeight / 43.33;
  static double get radius20 => screenHeight / 39;
  static double get radius22 => screenHeight / 35.45;
  static double get radius25 => screenHeight / 31.2;
  static double get radius28 => screenHeight / 27.86;
  static double get radius30 => screenHeight / 26;
  static double get radius40 => screenHeight / 19.5;
  static double get radius50 => screenHeight / 15.6;
  static double get radius60 => screenHeight / 13;
  static double get radius70 => screenHeight / 11.14;
  static double get radius100 => screenHeight / 7.8;
  static double get radius120 => screenHeight / 6.5;

  static double get iconSize16 => screenHeight / 48.75;
  static double get iconSize20 => screenHeight / 39;
  static double get iconSize24 => screenHeight / 32.5;
}
