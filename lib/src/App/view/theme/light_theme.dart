import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Constant that defines the [Primary] color.
const primary = Color(0xfff3d01a);

/// Constant that defines the [Primary variant] color.
const primaryVariant = Color(0xffecc608);

/// Constant that defines the [Secondary] color.
const secondary = Color(0xffed2026);

/// Constant that defines the [Secondary variant] color.
const secondaryVariant = Color(0xff9b0a0e);

/// Constant that defines the [Background] color.
const background = Color(0xfffefefe);

/// Constant that defines the [Surface] color.
const surface = Color(0xfffefefe);

/// Constant that defines the [White] color.
const white = Color(0xffffffff);

/// Constant that defines the [Error] color.
const error = Color(0xff8e2b3f);

/// Constant that defines the [Text light] color.
const blackText = Color(0xff181818);

/// Constant that defines the [Text dark] color.
const whiteText = Color(0xffb2b2b2);

const lightAppScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: blackText,
    secondary: secondary,
    onSecondary: whiteText,
    error: error,
    onError: whiteText,
    surface: surface,
    onSurface: blackText,
    background: background,
    onBackground: blackText);

final lightTheme = ThemeData(
  colorScheme: lightAppScheme,
  useMaterial3: true,
  fontFamily: GoogleFonts.ptSans().fontFamily,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primary,
      foregroundColor: blackText,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: primary,
  ),
);
