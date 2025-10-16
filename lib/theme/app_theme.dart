import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    final base = GoogleFonts.mulishTextTheme();
    final textTheme = base.copyWith(
      displaySmall: (base.displaySmall ?? const TextStyle()).copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      headlineSmall: (base.headlineSmall ?? const TextStyle()).copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleLarge: (base.titleLarge ?? const TextStyle()).copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: (base.titleMedium ?? const TextStyle()).copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: (base.bodyLarge ?? const TextStyle()).copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      bodyMedium: (base.bodyMedium ?? const TextStyle()).copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
      bodySmall: (base.bodySmall ?? const TextStyle()).copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
      labelLarge: (base.labelLarge ?? const TextStyle()).copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      labelMedium: (base.labelMedium ?? const TextStyle()).copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
    );
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      useMaterial3: true,
      textTheme: textTheme,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primary,
        onPrimary: AppColors.textPrimary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.textPrimary,
        error: Colors.redAccent,
        onError: AppColors.textPrimary,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        surfaceTint: Colors.transparent,
        tertiary: AppColors.accent,
        onTertiary: AppColors.textPrimary,
        outline: AppColors.border,
        outlineVariant: AppColors.surfaceVariant,
        shadow: Colors.black,
        scrim: Colors.black87,
        inverseSurface: AppColors.textPrimary,
        onInverseSurface: AppColors.background,
        inversePrimary: AppColors.primaryDark,
      ),
      cardColor: AppColors.surface,
      dividerColor: AppColors.border,
      iconTheme: const IconThemeData(color: AppColors.textSecondary),
    );
  }
}
