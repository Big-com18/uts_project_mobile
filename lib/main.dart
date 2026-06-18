// lib/main.dart
import 'package:flutter/material.dart';
import 'package:uts_project_mobile/pages/add_student_page.dart';

import 'pages/list_student_page.dart';
import 'pages/profile_page.dart';

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
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ListStudentPages(),
        '/add-student': (context) => const AddStudentPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
