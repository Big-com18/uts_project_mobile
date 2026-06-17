import 'package:flutter/material.dart';
import 'package:uts_project_mobile/pages/list_mahasiswa_pages.dart';
import 'package:uts_project_mobile/pages/tambah_mahasiswa.dart';
import 'package:uts_project_mobile/pages/hapus_mahasiswa.dart';

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
        '/hapus-mahasiswa': (context) => const HapusMahasiswaPage(),
      },
    );
  }
}