import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.blue,
    useMaterial3: true,
  );

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue,
    useMaterial3: true,
  );
}
