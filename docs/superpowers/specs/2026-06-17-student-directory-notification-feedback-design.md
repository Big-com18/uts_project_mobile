# Design Specification: Student Directory Notification Feedback

**Project Context:** Student Directory (Tugas UTS Mobile Computing)  
**Date:** 2026-06-17  
**Author:** Senior UI/UX Designer & Flutter Developer  
**Status:** Approved by User  

---

## 1. Executive Summary & Context

Saat ini, aplikasi **Student Directory** tidak memberikan umpan balik visual (*visual feedback*) setelah pengguna berhasil menambahkan mahasiswa baru dari Halaman 2 (Tambah Mahasiswa) atau menghapus mahasiswa dari Halaman 3 (Profile). 

Dokumen spesifikasi ini mendefinisikan implementasi **Custom Floating SnackBar** sebagai mekanisme notifikasi standar pada Halaman 1 (Home) setelah transisi navigasi kembali (*pop*) selesai dilakukan. Desain ini mengikuti prinsip **Human-Centered Design (HCD)** dan **Usability Heuristics** (terutama *Visibility of system status* dan *Aesthetic & minimalist design*) yang selaras dengan tema **Minimalist Soft UI** saat ini.

---

## 2. Pendekatan Desain & Usability

### A. Human-Centered Design (HCD)
Demo aplikasi berlangsung sangat singkat (maksimal 5 menit). Notifikasi harus:
1.  **Terlihat Jelas (*High Discoverability*):** Menggunakan warna gelap solid dari palet utama (*Nordic Graphite*) yang sangat kontras di atas latar belakang halaman abu-abu/putih gading hangat.
2.  **Non-intrusif (*Smooth Flow*):** SnackBar akan melayang di atas konten bawah layar tanpa menutupi area interaksi utama secara permanen. FAB secara otomatis akan bergeser ke atas secara animasi saat SnackBar muncul.
3.  **Ketersediaan Informasi Kontekstual:** Menampilkan nama mahasiswa secara dinamis dalam pesan konfirmasi (contoh: *"Budi Santoso berhasil ditambahkan"* atau *"Budi Santoso telah dihapus dari daftar"*).

### B. Usability Heuristics (Nielsen's 10 Heuristics)
1.  **Visibility of System Status:** Memberikan kepastian visual instan kepada pengguna bahwa database lokal telah sukses diperbarui tanpa memaksa mereka melihat daftar secara manual.
2.  **Consistency & Standards:** Menggunakan struktur SnackBar yang sama untuk kedua aksi (tambah & hapus). Perbedaan fungsi diwakili oleh ikon dan warna aksen yang berbeda (Aksen Amber untuk penambahan, Aksen Merah untuk penghapusan).
3.  **Aesthetic & Minimalist Design:** Menghindari warna latar merah atau hijau menyala yang terlalu mencolok, melainkan menggunakan warna latar belakang tema abu-abu gelap terpadu dengan border lengkung halus (`BorderRadius.circular(12)`).

---

## 3. Visual & Technical Specification

### A. Parameter Desain Notifikasi
*   **Warna Latar Belakang:** `AppTheme.primary` (`Color(0xFF1E293B)`) - Nordic Graphite.
*   **Efek Layang:** `behavior: SnackBarBehavior.floating` dengan margin `EdgeInsets.fromLTRB(16, 0, 16, 20)`.
*   **Kecekungan Sudut:** `BorderRadius.circular(12)`.
*   **Durasi Tampil:** 3 detik (`Duration(seconds: 3)`).
*   **Tipografi Teks:** `Plus Jakarta Sans`, `13px`, `FontWeight.w600` (Medium/Semi-Bold), warna putih bersih (`Colors.white`).

### B. Konfigurasi Aksi Notifikasi
1.  **Skenario Tambah Sukses:**
    *   *Pesan:* `"${studentName} berhasil ditambahkan"`
    *   *Ikon:* `Icons.check_circle_rounded`
    *   *Warna Ikon:* `AppTheme.accent` (`Color(0xFFD97706)`) - Warm Amber.
2.  **Skenario Hapus Sukses:**
    *   *Pesan:* `"${studentName} telah dihapus dari daftar"`
    *   *Ikon:* `Icons.delete_outline_rounded`
    *   *Warna Ikon:* Crimson Red (`Color(0xFFEF4444)`).

---

## 4. Alur Integrasi Navigasi (Navigational Integration Flow)

Mengingat aksi navigasi dilakukan secara asynchronous, SnackBar akan dipicu tepat setelah hasil navigasi ditangkap pada Halaman 1 ([list_mahasiswa_pages.dart](file:///D:/Study/Cakrawala%20University/Semester%204/Mobile%20Computing/uas_project_mobile/lib/pages/list_mahasiswa_pages.dart)):

### A. Skenario Tambah Mahasiswa
```dart
void _addStudent() async {
  final result = await Navigator.pushNamed(context, '/tambah-mahasiswa');
  if (result != null && result is Student) {
    setState(() {
      students.add(result);
    });
    // Tampilkan notifikasi sukses tambah
    _showNotification(
      message: '${result.name} berhasil ditambahkan',
      icon: Icons.check_circle_rounded,
      iconColor: AppTheme.accent,
    );
  }
}
```

### B. Skenario Hapus Mahasiswa
```dart
void _viewProfile(int index) async {
  final studentName = students[index].name; // Simpan nama sebelum dihapus
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
    // Tampilkan notifikasi sukses hapus
    _showNotification(
      message: '$studentName telah dihapus dari daftar',
      icon: Icons.delete_outline_rounded,
      iconColor: const Color(0xFFEF4444),
    );
  }
}
```
---

## 5. Rencana Pengujian
1.  **Uji Tambah Data:** Mengisi form tambah mahasiswa, menekan tombol simpan, kembali ke halaman utama, dan memverifikasi bahwa SnackBar penambahan muncul tepat setelah data baru dirender di GridView.
2.  **Uji Hapus Data:** Masuk ke halaman profil, menekan tombol "Hapus Akun Ini", mengonfirmasi di Bottom Sheet, kembali ke halaman utama, dan memverifikasi bahwa SnackBar penghapusan muncul tepat setelah data mahasiswa tersebut hilang dari GridView.
3.  **Uji Aksesibilitas & Tumpang Tindih:** Memastikan SnackBar tidak menutupi Floating Action Button secara kasar, dan FAB bergeser ke atas secara halus mengikuti animasi naiknya SnackBar.
