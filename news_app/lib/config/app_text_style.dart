import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme buildAppTextTheme() {
  return GoogleFonts.robotoTextTheme().copyWith(
    displayLarge: GoogleFonts.roboto(
      fontSize: 24.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    displayMedium: GoogleFonts.roboto(
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displaySmall: GoogleFonts.roboto(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headlineLarge: GoogleFonts.roboto(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headlineMedium: GoogleFonts.roboto(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    headlineSmall: GoogleFonts.roboto(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    titleSmall: GoogleFonts.roboto(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    labelLarge: GoogleFonts.roboto(
      fontSize: 10.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );
}
