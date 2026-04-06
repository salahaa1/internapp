import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const headline1 = TextStyle(
    fontFamily: 'Tajawal',
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    height: 1.3,
  );

  static const headline3 = TextStyle(
    fontFamily: 'Tajawal',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    height: 1.3,
  );

  static const body1 = TextStyle(
    fontFamily: 'Tajawal',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const fieldLabel = TextStyle(
    fontFamily: 'Tajawal',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const buttonText = TextStyle(
    fontFamily: 'Tajawal',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static const hintText = TextStyle(
    fontFamily: 'Tajawal',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.hint,
  );

  static const errorText = TextStyle(
    fontFamily: 'Tajawal',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
  );
}
