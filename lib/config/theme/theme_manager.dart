import 'package:evently/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.blue,
        primary: AppColors.light,
        onPrimary: AppColors.blue,
        secondary: AppColors.light,
        onSecondary: AppColors.blue,
    outline: AppColors.light),
    cardTheme: CardThemeData(
      color: AppColors.light,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: Colors.transparent,
      tabAlignment: TabAlignment.start,
    ),
    iconTheme: IconThemeData(color: AppColors.black),
    primaryColor: AppColors.blue,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.blue,
      foregroundColor: AppColors.light,
      shape: StadiumBorder(side: BorderSide(width: 4, color: AppColors.light)),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppColors.blue,
      shape: CircularNotchedRectangle(),
    ),
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.light,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.light,
      unselectedItemColor: AppColors.light,
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.gray,
      suffixIconColor: AppColors.gray,
      hintStyle: GoogleFonts.inter(
        color: AppColors.gray,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      labelStyle: GoogleFonts.inter(
        color: AppColors.gray,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: AppColors.red, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: AppColors.gray, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: AppColors.gray, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: AppColors.red, width: 1),
      ),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: AppColors.blue
      ),
      elevation: 0,
      backgroundColor: AppColors.light,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: AppColors.blue,
        fontSize: 22.sp,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: GoogleFonts.inter(
          fontSize: 20,
          color: AppColors.light,
          fontWeight: FontWeight.w500,
        ),
        foregroundColor: AppColors.light,
        backgroundColor: AppColors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        foregroundColor: AppColors.blue,
        textStyle: GoogleFonts.inter(
          color: AppColors.blue,
          fontSize: 16.sp,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.blue,
        ),
      ),
    ),
    textTheme: TextTheme(
      titleSmall: GoogleFonts.inter(
        color: AppColors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),

      titleMedium: GoogleFonts.inter(
        color: AppColors.blue,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w500,color:
      AppColors.light),

      labelSmall: GoogleFonts.inter(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),
      titleLarge: GoogleFonts.inter(
        color: AppColors.light,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.blue,
    primary: AppColors.blue,
    onPrimary: AppColors.light,
    secondary: AppColors.blue,
    onSecondary: AppColors.light,
    outline: AppColors.ofWhite),
    cardTheme: CardThemeData(
      color: AppColors.dark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: Colors.transparent,
      tabAlignment: TabAlignment.start,
    ),
    iconTheme: IconThemeData(color: AppColors.ofWhite),
    primaryColor: AppColors.dark,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.dark,
      foregroundColor: AppColors.ofWhite,
      shape: StadiumBorder(side: BorderSide(width: 4, color: AppColors.ofWhite)),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: AppColors.dark,
      shape: CircularNotchedRectangle(),
    ),
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.dark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.ofWhite,
      unselectedItemColor: AppColors.ofWhite,
    ),
    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.ofWhite,
      suffixIconColor: AppColors.ofWhite,
      hintStyle: GoogleFonts.inter(
        color: AppColors.ofWhite,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      labelStyle: GoogleFonts.inter(
        color: AppColors.ofWhite,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: AppColors.red, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: AppColors.blue, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: AppColors.blue, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: AppColors.red, width: 1),
      ),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
          color: AppColors.blue
      ),
      elevation: 0,
      backgroundColor: AppColors.dark,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: AppColors.blue,
        fontSize: 22.sp,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: GoogleFonts.inter(
          fontSize: 20,
          color: AppColors.light,
          fontWeight: FontWeight.w500,
        ),
        foregroundColor: AppColors.light,
        backgroundColor: AppColors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        foregroundColor: AppColors.blue,
        textStyle: GoogleFonts.inter(
          color: AppColors.blue,
          fontSize: 16.sp,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.blue,
        ),
      ),
    ),
    textTheme: TextTheme(
      titleSmall: GoogleFonts.inter(
        color: AppColors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),

      titleMedium: GoogleFonts.inter(
        color: AppColors.blue,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: GoogleFonts.inter(fontSize: 16.sp,fontWeight: FontWeight.w500,color:
      AppColors.light),

      labelSmall: GoogleFonts.inter(
        color: AppColors.ofWhite,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),
      titleLarge: GoogleFonts.inter(
        color: AppColors.ofWhite,
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.ofWhite,
      ),
    ),
  );


}
