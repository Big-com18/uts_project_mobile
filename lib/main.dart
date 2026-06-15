import 'package:flutter/material.dart';
import 'pages/list_mahasiswa_pages.dart';
import 'pages/tambah_mahasiswa.dart';

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
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ListMahasiswaPages(),
        '/tambah-mahasiswa': (context) => const TambahMahasiswaPage(),

      },
    );
  }
}