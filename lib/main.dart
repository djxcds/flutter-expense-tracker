import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

ColorScheme kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 166, 225, 250));

ColorScheme darkColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 0, 7, 45),
    brightness: Brightness.dark);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) =>
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: darkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: darkColorScheme.primaryContainer,
          foregroundColor: darkColorScheme.onPrimaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: darkColorScheme.onTertiary,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: darkColorScheme.primaryContainer),
        ),
        textTheme: const TextTheme().copyWith(
          titleLarge: TextStyle(
              fontWeight: FontWeight.normal,
              color: darkColorScheme.primary,
              fontSize: 14),
          bodyLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: darkColorScheme.primary,
              fontSize: 16),
          bodyMedium: TextStyle(
              fontWeight: FontWeight.normal,
              color: darkColorScheme.primary,
              fontSize: 12),
        ),
      ),
      theme: ThemeData.light(useMaterial3: true).copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.onTertiary,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer),
        ),
        textTheme: const TextTheme().copyWith(
          titleLarge: TextStyle(
              fontWeight: FontWeight.normal,
              color: kColorScheme.onPrimary,
              fontSize: 14),
          bodyLarge: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
          bodyMedium: const TextStyle(
              fontWeight: FontWeight.normal, color: Colors.black, fontSize: 12),
        ),
      ),
      home: const Expenses(),
      themeMode: ThemeMode.system,
    ),
  );
  // ));
}
