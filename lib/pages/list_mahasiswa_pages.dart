import 'package:flutter/material.dart';
import '../models/student.dart';
import '../data/app_data.dart';

class ListMahasiswaPages extends StatefulWidget {
  const ListMahasiswaPages({super.key});

  @override
  State<ListMahasiswaPages> createState() => _ListMahasiswaPagesState();
}

class _ListMahasiswaPagesState extends State<ListMahasiswaPages> {
  late List<Student> students;

  @override
  void initState() {
    super.initState();
    // Initialize with provided data
    students = initialStudentsData.map((data) => Student.fromMap(data)).toList();
  }

  void _addStudent() async {
    final result = await Navigator.pushNamed(context, '/tambah-mahasiswa');
    if (result != null && result is Student) {
      setState(() {
        students.add(result);
      });
    }
  }

  void _viewProfile(int index) async {
    final result = await Navigator.pushNamed(
      context,
      '/profile',
      arguments: {
        'student': students[index],
        'totalStudents': students.length,
      },
    );

    if (result == true) {
      setState(() {
        students.removeAt(index);
      });
    }
  }

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
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return GestureDetector(
            onTap: () => _viewProfile(index),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(student.avatar),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      student.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    student.domisili,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStudent,
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
