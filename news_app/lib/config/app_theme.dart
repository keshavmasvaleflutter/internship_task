import 'package:flutter/material.dart';
import 'package:news_app/config/config.dart';

final ThemeData appTheme = ThemeData(
  textSelectionTheme: textSelectionTheme(),
  textTheme: buildAppTextTheme(),
  scaffoldBackgroundColor: Colors.grey.withAlpha(20),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(
      color: Colors.white.withAlpha(200),
      fontWeight: FontWeight.w300,
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 1.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white.withAlpha(150)),
    ),
  ),
);

TextSelectionThemeData textSelectionTheme() => TextSelectionThemeData(
  cursorColor: Colors.black,
  selectionColor: Colors.grey.withAlpha(100),
  selectionHandleColor: Colors.black,
);
