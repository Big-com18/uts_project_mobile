import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/student.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Student> students = initialStudentsData.map<Student>((data) => Student(
    name: data['name']!,
    avatar: data['avatar']!,
    domisili: data['domisili']!,
    phone: data['phone']!,
  )).toList();

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC), // Warna background aplikasi lebih premium
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Student Directory',
          style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.w800),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade100, height: 1.0),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0), // Padding layar dilebarkan
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 0.82, // Proporsi yang sangat pas untuk form factor HP saat ini
        ),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24), // Sudut lebih membulat
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF334155).withOpacity(0.06), // Shadow biru gelap transparan
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () async {
                  final result = await Navigator.pushNamed(
                    context, '/delete', 
                    arguments: {'student': student, 'totalStudents': students.length},
                  );
                  if (result == true) setState(() => students.removeAt(index));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3.5),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)], // Gradien Biru Cerah
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 34,
                            backgroundImage: NetworkImage(student.avatar),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Text(
                        student.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 16, 
                          color: Color(0xFF1E293B) 
                        ),
                        maxLines: 1, 
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9), // Slate 100
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.location_on_rounded, size: 14, color: Color(0xFF64748B)),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                student.domisili,
                                style: const TextStyle(
                                  color: Color(0xFF64748B), // Slate 500
                                  fontSize: 12, 
                                  fontWeight: FontWeight.w600
                                ),
                                maxLines: 1, 
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newStudent = await Navigator.pushNamed(context, '/add');
          if (newStudent != null && newStudent is Student) {
            setState(() => students.add(newStudent));
          }
        },
        backgroundColor: const Color(0xFF1E293B),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}