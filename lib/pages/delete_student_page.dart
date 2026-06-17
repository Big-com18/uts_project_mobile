import 'package:flutter/material.dart';
import '../models/student.dart';

class DeleteStudentPage extends StatelessWidget {
  const DeleteStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)!.settings.arguments as Map;
    final Student student = args['student']; 
    final int totalStudents = args['totalStudents'];
    final bool canDelete = totalStudents > 3;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Detail & Hapus Mahasiswa', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundImage: NetworkImage(student.avatar),
                ),
                const SizedBox(height: 24),
                Text(
                  student.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  student.domisili,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 4),
                Text(
                  student.phone,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          
          // Tombol Hapus Section
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: canDelete ? () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Konfirmasi Hapus'),
                        content: Text('Apakah kamu yakin ingin menghapus akun ${student.name}? Data yang dihapus tidak dapat dikembalikan.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context), // Tutup dialog
                            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Tutup dialog konfirmasi
                              Navigator.pop(context, true); // Kembali ke Home dengan nilai TRUE
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            child: const Text('Ya, Hapus', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      );
                    },
                  );
                } : null, 
                icon: const Icon(Icons.delete),
                label: Text(
                  canDelete ? 'Hapus Akun Ini' : 'Minimal 3 Mahasiswa Tersisa',
                  style: const TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                  disabledForegroundColor: Colors.grey,
                  disabledBackgroundColor: Colors.grey.shade200,
                  elevation: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}