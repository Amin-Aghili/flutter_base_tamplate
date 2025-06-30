import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode(BuildContext context) => ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        onTertiary: const Color.fromARGB(255, 80, 107, 230),
        outline: Colors.black12,
        surface: const Color.fromARGB(255, 245, 243, 243),
        primary: const Color.fromRGBO(33, 150, 243, 1),
        secondary: const Color.fromRGBO(245, 245, 245, 1),
        tertiary: const Color.fromARGB(255, 230, 230, 230),
        inversePrimary: Colors.grey.shade800,
        onSecondary: Color.fromARGB(255, 255, 255, 255),
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: Colors.black87),
      primaryTextTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: const Color.fromRGBO(33, 150, 243, 1),
        ),
      ),
      canvasColor: const Color.fromRGBO(245, 245, 245, 1),
    );

ThemeData darkMode(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
          onTertiary: const Color.fromARGB(255, 215, 253, 3),
          outline: Colors.white10,
          surface: const Color.fromARGB(255, 50, 50, 80),
          primary: const Color.fromRGBO(38, 151, 255, 1),
          secondary: const Color.fromRGBO(42, 45, 62, 1),
          tertiary: const Color.fromARGB(255, 47, 47, 47),
          inversePrimary: Colors.grey.shade300,
          shadow: const Color.fromARGB(125, 184, 184, 184),
          onSecondary: Color.fromARGB(255, 30, 30, 44)),
      scaffoldBackgroundColor: Color.fromARGB(255, 30, 30, 44),
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: Colors.white),
      // textTheme: TextTheme(
      //   displayLarge: GoogleFonts.poppins(
      //     fontSize: 24,
      //     fontWeight: FontWeight.w600,
      //     color: Colors.blue,
      //   ),
      // ),
      primaryTextTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.blue,
        ),
      ),
      canvasColor: Color.fromRGBO(42, 45, 62, 1),
    );
