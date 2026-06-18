import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/student.dart';

class ListMahasiswaPages extends StatefulWidget {
  const ListMahasiswaPages({super.key});

  @override
  State<ListMahasiswaPages> createState() => _ListMahasiswaPagesState();
}

class _ListMahasiswaPagesState extends State<ListMahasiswaPages> {
  late List<Student> students;

  // Brand colors
  static const Color _indigo = Color(0xFF6366F1);
  static const Color _indigoLight = Color(0xFFEEF2FF);
  static const Color _bgPage = Color(0xFFF8F9FB);
  static const Color _cardBg = Colors.white;

  @override
  void initState() {
    super.initState();
    students = initialStudentsData
        .map((data) => Student.fromMap(data))
        .toList();
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
      arguments: {'student': students[index], 'totalStudents': students.length},
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
      backgroundColor: _bgPage,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Student',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          'Directory',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: _indigo,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${students.length} mahasiswa terdaftar',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Avatar stack badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _indigoLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.school_rounded, color: _indigo, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          'S1',
                          style: TextStyle(
                            color: _indigo,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Grid ────────────────────────────────────────────
            Expanded(
              child: students.isEmpty
                  ? _buildEmpty()
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: 0.78,
                          ),
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        return _StudentCard(
                          student: students[index],
                          onTap: () => _viewProfile(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: _AddFab(onPressed: _addStudent),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _indigoLight,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.people_outline_rounded, color: _indigo, size: 40),
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum ada mahasiswa',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Tap + untuk menambahkan mahasiswa baru',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}

// ── Student Card ──────────────────────────────────────────────

class _StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback onTap;
  static const Color _indigo = Color(0xFF6366F1);

  const _StudentCard({required this.student, required this.onTap});

  // Pick a subtle accent color based on first letter
  Color _accentFor(String name) {
    final colors = [
      const Color(0xFFEEF2FF), // indigo tint
      const Color(0xFFF0FDF4), // green tint
      const Color(0xFFFFF7ED), // orange tint
      const Color(0xFFFDF4FF), // purple tint
      const Color(0xFFF0F9FF), // sky tint
    ];
    if (name.isEmpty) return colors[0];
    return colors[name.codeUnitAt(0) % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final accent = _accentFor(student.name);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top colored band with avatar
            Container(
              height: 110,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 38,
                    backgroundImage: NetworkImage(student.avatar),
                  ),
                ),
              ),
            ),
            // Info section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      student.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 11,
                          color: _indigo,
                        ),
                        const SizedBox(width: 2),
                        Flexible(
                          child: Text(
                            student.domisili,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── FAB ──────────────────────────────────────────────────────

class _AddFab extends StatelessWidget {
  final VoidCallback onPressed;
  static const Color _indigo = Color(0xFF6366F1);

  const _AddFab({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: _indigo,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      icon: const Icon(Icons.person_add_rounded, color: Colors.white, size: 20),
      label: const Text(
        'Tambah',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );
  }
}
