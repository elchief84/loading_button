import 'package:flutter/material.dart';

class CustomTheme {
  static final purple = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  static final purpleSquared = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ))),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ))),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ))),
      ));

  static final orange = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
    useMaterial3: true,
  );

  static final orangeSquared = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ))),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ))),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ))),
      ));
}
