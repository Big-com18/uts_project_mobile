import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/add_student_page.dart';
import 'pages/list_student_page.dart';
import 'pages/profile_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Directory',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppTheme.background,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppTheme.primary,
          primary: AppTheme.primary,
          secondary: AppTheme.accent,
          background: AppTheme.background,
          surface: AppTheme.cardBg,
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppTheme.background,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.plusJakartaSans(
            color: AppTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          iconTheme: const IconThemeData(color: AppTheme.textPrimary, size: 20),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ListStudentPage(),
        '/add': (context) => const AddStudentPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
