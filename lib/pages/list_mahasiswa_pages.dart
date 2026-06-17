import 'package:flutter/material.dart';
import '../models/student.dart';
import '../data/app_data.dart';
import '../theme/app_theme.dart';

class ListMahasiswaPages extends StatefulWidget {
  const ListMahasiswaPages({super.key});

  @override
  State<ListMahasiswaPages> createState() => _ListMahasiswaPagesState();
}

class _ListMahasiswaPagesState extends State<ListMahasiswaPages> {
  late List<Student> students;
  OverlayEntry? _notificationEntry;

  @override
  void initState() {
    super.initState();
    students =
        initialStudentsData.map((data) => Student.fromMap(data)).toList();
  }

  @override
  void dispose() {
    _notificationEntry?.remove();
    _notificationEntry = null;
    super.dispose();
  }

  void _showNotification({
    required String message,
    required IconData icon,
    required Color backgroundColor,
  }) {
    if (_notificationEntry != null) {
      _notificationEntry!.remove();
      _notificationEntry = null;
    }

    _notificationEntry = OverlayEntry(
      builder: (context) => _AnimatedNotification(
        message: message,
        icon: icon,
        backgroundColor: backgroundColor,
        onDismissed: () {
          _notificationEntry?.remove();
          _notificationEntry = null;
        },
      ),
    );

    Overlay.of(context).insert(_notificationEntry!);
  }

  void _addStudent() async {
    final result = await Navigator.pushNamed(context, '/tambah-mahasiswa');
    if (result != null && result is Student) {
      setState(() {
        students.add(result);
      });
      _showNotification(
        message: '${result.name} berhasil ditambahkan',
        icon: Icons.check_circle_outline_rounded,
        backgroundColor: const Color(0xFF16A34A), // Success Green
      );
    }
  }

  void _viewProfile(int index) async {
    final studentName = students[index].name;
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
      _showNotification(
        message: '$studentName telah dihapus dari daftar',
        icon: Icons.delete_outline_rounded,
        backgroundColor: const Color(0xFFDC2626), // Destructive Red
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Student',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textPrimary,
                            height: 1.1,
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Directory',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.accent,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Tiny indicator dot
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppTheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Soft pill count
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${students.length} mahasiswa terdaftar',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppTheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // S1 badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.primary.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.school_rounded,
                            color: AppTheme.primary, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'S1',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
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
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
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
              color: AppTheme.primary.withOpacity(0.06),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.people_outline_rounded,
                color: AppTheme.primary, size: 36),
          ),
          const SizedBox(height: 16),
          const Text(
            'Belum ada mahasiswa',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary),
          ),
          const SizedBox(height: 6),
          Text(
            'Tap tombol + untuk menambahkan mahasiswa baru',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
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

  const _StudentCard({required this.student, required this.onTap});

  Color _accentFor(String name) {
    if (name.isEmpty) return AppTheme.cardAccents[0];
    return AppTheme.cardAccents[
        name.codeUnitAt(0) % AppTheme.cardAccents.length];
  }

  @override
  Widget build(BuildContext context) {
    final accent = _accentFor(student.name);
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: AppTheme.primary.withOpacity(0.06),
            highlightColor: AppTheme.primary.withOpacity(0.02),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Center dynamic avatar container
                  Container(
                    width: 78,
                    height: 78,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accent.withOpacity(0.35),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(student.avatar),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    student.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                      color: AppTheme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on_rounded,
                            size: 11, color: AppTheme.accent),
                        const SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            student.domisili,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
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
      ),
    );
  }
}

// ── FAB ──────────────────────────────────────────────────────

class _AddFab extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddFab({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: AppTheme.primary,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      icon: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
      label: const Text(
        'Tambah',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 13.5,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ── CUSTOM ANIMATED NOTIFICATION OVERLAY ─────────────────────

class _AnimatedNotification extends StatefulWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onDismissed;

  const _AnimatedNotification({
    required this.message,
    required this.icon,
    required this.backgroundColor,
    required this.onDismissed,
  });

  @override
  State<_AnimatedNotification> createState() => _AnimatedNotificationState();
}

class _AnimatedNotificationState extends State<_AnimatedNotification>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _yTranslation;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    // Springy easeOutBack bounce animation
    _yTranslation = Tween<double>(begin: 80.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();

    // Auto dismiss after 2.6 seconds
    Future.delayed(const Duration(milliseconds: 2600), () {
      if (mounted) {
        _controller
            .animateTo(0.0,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeIn)
            .then((_) {
          widget.onDismissed();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          bottom: 40 + _yTranslation.value,
          left: 16,
          right: 16,
          child: Opacity(
            opacity: _opacity.value,
            child: child,
          ),
        );
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: widget.backgroundColor.withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}