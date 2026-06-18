import 'package:flutter/material.dart';
import 'pages/list_student_page.dart';
import 'pages/tambah_mahasiswa.dart';
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
        '/': (context) => const ListStudentPage(),
        '/tambah-mahasiswa': (context) => const TambahMahasiswaPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
