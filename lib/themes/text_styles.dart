// Text styles definitions
import 'package:flutter/material.dart';
import 'package:stay_travel_v3/themes/colors.dart';

class AppTextStyles {
  static const TextStyle headerStyle = TextStyle(
      color: AppColors.black,
      fontFamily: 'Lexend',
      fontSize: 32,
      fontWeight: FontWeight.bold,
      height: 1.5);

  static const TextStyle subheaderStyle = TextStyle(
    color: AppColors.grey2,
    fontFamily: 'Lexend',
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle subheaderBoldStyle = TextStyle(
    color: AppColors.grey2,
    fontFamily: 'Lexend',
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    color: AppColors.grey2,
    fontFamily: 'Manrope',
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle titleTextStyle = TextStyle(
    color: AppColors.grey2,
    fontFamily: 'Manrope',
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );
}
