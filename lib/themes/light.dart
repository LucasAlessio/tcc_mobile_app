import 'package:flutter/material.dart';

ThemeData themeLight = ThemeData(
  primaryColor: const Color(0xFF1B254B),
  primaryColorDark: const Color(0xFF1A202C),
  primaryColorLight: const Color(0xFF3311DB),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
    ),
    // Button
    labelLarge: TextStyle(
      fontSize: 14,
    ),
  ).apply(
    bodyColor: const Color(0xFF1B254B),
    displayColor: const Color(0xFF1B254B),
    decorationColor: const Color(0xFF1B254B),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF3311DB),
    primary: const Color(0xFF3311DB),
    background: const Color(0xFFF4F8FE),
    onBackground: Colors.pink,
    brightness: Brightness.light,
    outline: Colors.transparent,
    onSurface: const Color(0xFF1B254B),
    onSurfaceVariant: const Color(0xFF1B254B),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF3311DB),
    titleTextStyle: TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0XFFEBEFF5),
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: Color(0xFF01B574),
  ),
  listTileTheme: const ListTileThemeData(
    selectedColor: Color(0xFF1B254B),
    selectedTileColor: Colors.black26,
  ),
  scaffoldBackgroundColor: const Color(0xFFF4F8FE),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 12),
    labelStyle: TextStyle(
      color: Color(0xFF1B254B),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFA3AED0), width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFA3AED0), width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF3311DB), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFEE5D50), width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFEE5D50), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    suffixIconColor: Color(0xFF3311DB),
    prefixIconColor: Color(0xFF3311DB),
    errorStyle: TextStyle(
      color: Color(0xFFEE5D50),
    ),
  ),
  radioTheme: const RadioThemeData(
    visualDensity: VisualDensity(vertical: -3, horizontal: -4),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
  ),
  useMaterial3: true,
);
