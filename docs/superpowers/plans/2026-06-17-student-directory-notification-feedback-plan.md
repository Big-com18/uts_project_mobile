# Implementation Plan: Student Directory Notification Feedback

**Project Context:** Student Directory (Tugas UTS Mobile Computing)  
**Date:** 2026-06-17  
**Author:** Senior UI/UX Designer & Flutter Developer  
**Status:** Ready to execute  

This plan outlines the concrete steps to execute the approved visual notification feedback using a **Custom Floating SnackBar** on the Home page.

---

## Phase 1: Code Integration on list_mahasiswa_pages.dart
- [ ] **Step 1.1:** Open `lib/pages/list_mahasiswa_pages.dart` and add a helper method `_showNotification` inside `_ListMahasiswaPagesState`:
  ```dart
  void _showNotification({
    required String message,
    required IconData icon,
    required Color iconColor,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.primary,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        duration: const Duration(seconds: 3),
      ),
    );
  }
  ```
- [ ] **Step 1.2:** Update the `_addStudent()` method in `_ListMahasiswaPagesState` to trigger `_showNotification` when a student is successfully added:
  ```dart
  void _addStudent() async {
    final result = await Navigator.pushNamed(context, '/tambah-mahasiswa');
    if (result != null && result is Student) {
      setState(() {
        students.add(result);
      });
      _showNotification(
        message: '${result.name} berhasil ditambahkan',
        icon: Icons.check_circle_rounded,
        iconColor: AppTheme.accent,
      );
    }
  }
  ```
- [ ] **Step 1.3:** Update the `_viewProfile()` method in `_ListMahasiswaPagesState` to save the student's name before deletion, and trigger `_showNotification` when a student is successfully deleted:
  ```dart
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
        iconColor: const Color(0xFFEF4444),
      );
    }
  }
  ```

## Phase 2: Verification & Quality Assurance
- [ ] **Step 2.1:** Run static analysis check `flutter analyze` to ensure there are no compilation warnings or errors.
- [ ] **Step 2.2:** Verify that visual animations of the FAB sliding up dynamically work correctly when the SnackBar is displayed.
