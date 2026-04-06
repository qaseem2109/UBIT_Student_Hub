import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary      = Color(0xFF1A56DB);
  static const primaryDark  = Color(0xFF1347C0);
  static const primaryLight = Color(0xFFEBF2FF);
  static const textDark     = Color(0xFF111928);
  static const textMuted    = Color(0xFF6B7280);
  static const borderColor  = Color(0xFFD1D5DB);
  static const background   = Color(0xFFF3F4F6);
  static const cardBg       = Colors.white;
  static const error        = Color(0xFFE02424);
  static const errorLight   = Color(0xFFFDE8E8);
  static const success      = Color(0xFF0E9F6E);
  static const successLight = Color(0xFFDEF7EC);
  static const warning      = Color(0xFFD97706);
  static const warningLight = Color(0xFFFEF3C7);
}

class AppTextStyles {
  AppTextStyles._();

  static const heading = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    letterSpacing: -0.5,
  );
  static const sectionTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );
  static const label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );
  static const muted = TextStyle(
    fontSize: 12,
    color: AppColors.textMuted,
  );
  static const link = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
  static const footerText = TextStyle(
    fontSize: 11,
    color: AppColors.textMuted,
  );
}

// Shared input decoration factory
InputDecoration appInputDecoration({
  String? hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool readOnly = false,
}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(fontSize: 14, color: AppColors.textMuted),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: readOnly ? AppColors.background : AppColors.cardBg,
    contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.8),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.error, width: 1.8),
    ),
  );
}
