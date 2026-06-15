import 'package:flutter/material.dart';

class ListMahasiswaPages extends StatefulWidget {
  const ListMahasiswaPages({super.key});

  @override
  State<ListMahasiswaPages> createState() => _ListMahasiswaPagesState();
}

class _ListMahasiswaPagesState extends State<ListMahasiswaPages> {
  // Data awal yang diwajibkan dari dokumen UTS
  final List<Map<String, String>> students = [
    {
      'name': 'Budi Santoso',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'domisili': 'Jakarta Selatan',
      'phone': '081234567890'
    },
    {
      'name': 'Sari Dewi',
      'avatar': 'https://i.pravatar.cc/150?img=5',
      'domisili': 'Bekasi',
      'phone': '087654321098'
    },
    {
      'name': 'Ahmad Fauzi',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'domisili': 'Depok',
      'phone': '082198765432'
    },
    {
      'name': 'Rina Kusuma',
      'avatar': 'https://i.pravatar.cc/150?img=8',
      'domisili': 'Tangerang Selatan',
      'phone': '089876543210'
    },
    {
      'name': 'Dian Pratama',
      'avatar': 'https://i.pravatar.cc/150?img=11',
      'domisili': 'Bogor',
      'phone': '085678901234'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: const Text(
          'Student Directory',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade100,
            height: 1.0,
          ),
        ),
      ),
      // PERBAIKAN: Menggunakan GridView 2 kolom sesuai spesifikasi ujian
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 Kolom
          crossAxisSpacing: 16, // Jarak horizontal antar kartu
          mainAxisSpacing: 16, // Jarak vertikal antar kartu
          childAspectRatio: 0.85, // Mengatur proporsi tinggi dan lebar kartu
        ),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: () {
                // TODO: Navigasi ke Halaman 3 (Profile) bawa data student
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.grey.shade100,
                      // Menampilkan foto avatar dari URL
                      backgroundImage: NetworkImage(student['avatar']!),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      student['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      student['domisili']!,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigasi ke Halaman 2 (Tambah Mahasiswa)
        },
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        elevation: 3,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}