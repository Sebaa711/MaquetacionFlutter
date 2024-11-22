import "package:flutter/material.dart";

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
      primaryColor: const Color.fromARGB(255, 118, 26, 94),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color.fromARGB(30, 0, 0, 0),
      ),
    );
  }
}
