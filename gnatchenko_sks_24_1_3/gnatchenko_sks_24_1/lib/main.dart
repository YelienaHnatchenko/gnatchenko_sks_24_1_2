import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnatchenko_sks_24_1/screens/tabs.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData createTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 24, 8, 19)
    ),
    textTheme: GoogleFonts.latoTextTheme(),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: createTheme(),
        home: const TabsScreen(),
      ),
    ),
  );
}
