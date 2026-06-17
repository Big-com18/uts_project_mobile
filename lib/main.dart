// lib/main.dart
import 'package:flutter/material.dart';
import 'package:uts_project_mobile/pages/home_page.dart';
import 'package:uts_project_mobile/pages/add_student_page.dart';
import 'package:uts_project_mobile/pages/delete_student_page.dart';

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
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/add': (context) => const AddStudentPage(),
        '/delete': (context) => const DeleteStudentPage(),
      },
    );
  }
}