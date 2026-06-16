# Design Specification: Student Directory UI/UX Redesign

**Project Context:** Student Directory (Tugas UTS Mobile Computing)  
**Date:** 2026-06-16  
**Author:** Senior UI/UX Designer & Flutter Developer  
**Status:** Approved by User  

---

## 1. Executive Summary & Context

Aplikasi **Student Directory** adalah aplikasi direktori mahasiswa berbasis Flutter yang terdiri dari 3 halaman utama dengan alur navigasi yang baku:
1. **Halaman 1 (Home):** GridView 2 kolom daftar mahasiswa.
2. **Halaman 2 (Tambah Mahasiswa):** Form input dengan avatar otomatis, dropdown domisili, dan checkbox consent.
3. **Halaman 3 (Profile):** Detail profile dengan tombol hapus (dinonaktifkan jika data tepat berjumlah 3).

Tujuan dari dokumen ini adalah menjabarkan spesifikasi **redesign visual (UI/UX)** tanpa mengubah logika bisnis, alur navigasi, struktur data, dan fungsionalitas yang sudah berjalan menggunakan pendekatan **Human-Centered Design (HCD)** dan **Usability Heuristics (Nielsen's 10 Heuristics)**.

---

## 2. Pendekatan Desain

### A. Human-Centered Design (HCD)
Untuk kebutuhan demo cepat (durasi maksimal 5 menit), aplikasi harus memiliki daya tarik visual yang kuat (*"wow factor"*), hierarki informasi yang sangat jelas, serta kenyamanan mata audiens saat melihat proyeksi layar. Gaya **Opsi A: Minimalist Soft UI (Premium & Clean)** dipilih karena menyajikan ruang bernapas yang cukup (*whitespace*), tipografi profesional, dan warna latar belakang yang menenangkan.

### B. Usability Heuristics (Nielsen's 10 Heuristics)
1. **Visibility of System Status (Feedback):** Mengganti `GestureDetector` pada kartu dengan `InkResponse`/`InkWell` di dalam `Material` untuk memberikan efek riak air (*ripple/splash effect*) yang interaktif saat di-tap.
2. **Consistency & Standards:** Memusatkan seluruh definisi warna dan tema tipografi ke dalam `ThemeData` global di `main.dart` agar seragam di seluruh halaman, tidak lagi di-*hardcode* di masing-masing file halaman.
3. **Aesthetic & Minimalist Design:** Menghilangkan ornamen warna mencolok di bagian atas kartu mahasiswa, diganti dengan kartu berlatar belakang putih bersih dengan border tipis abu-abu yang elegan.
4. **Error Prevention & Recognition:** Menerapkan `autovalidateMode: AutovalidateMode.onUserInteraction` pada field input untuk memberikan validasi instan (*inline error feedback*) saat pengguna selesai mengetik.

---

## 3. Visual Design System

### A. Palet Warna (Switchable Color Themes)
Tema warna didefinisikan secara modular di dalam `ThemeData` atau class warna terpusat agar mudah ditukar.

#### **Opsi Utama: Pilihan 7 (Nordic Graphite & Warm Amber)**
*   **Primary Accent:** `#1E293B` (`Color(0xFF1E293B)`) - Nordic Graphite (solid, profesional, kontras tinggi).
*   **FAB & Highlight:** `#D97706` (`Color(0xFFD97706)`) - Warm Amber (memberikan kehangatan estetik pada tombol aksi).
*   **Background:** `#FAF9F6` (`Color(0xFFFAF9F6)`) - Warm Off-White (lembut di mata, memberikan kontras natural terhadap kartu putih).
*   **Card Background:** `#FFFFFF` (Pure White).
*   **Text Primary:** `#0F172A` (`Color(0xFF0F172A)`) - Charcoal Slate.
*   **Text Secondary:** `#64748B` (`Color(0xFF64748B)`) - Slate Gray.
*   **Border:** `#E2E8F0` (`Color(0xFFE2E8F0)`) - Soft Slate.

#### **Opsi Cadangan (Tinggal Tukar Komentar): Pilihan 6 (Oceanic Teal & Sage Mint)**
*   **Primary Accent:** `#0D9488` (`Color(0xFF0D9488)`) - Deep Teal.
*   **Background:** `#F4F9F6` (`Color(0xFFF4F9F6)`) - Sage Mint.
*   **Card Background:** `#FFFFFF` (Pure White).
*   **Text Primary:** `#115E59` (`Color(0xFF115E59)`) - Dark Spruce.
*   **Text Secondary:** `#5F9EA0` (`Color(0xFF5F9EA0)`) - Light Slate.
*   **Border:** `#E6F2ED` (`Color(0xFFE6F2ED)`) - Soft Mint Border.

### B. Typography (Tipografi)
*   **Font Family:** `Plus Jakarta Sans` (diimpor menggunakan package `google_fonts`).
*   **Ukuran & Weight:**
    *   *App Bar / Page Title:* 24pt, `FontWeight.w800` (Extra Bold).
    *   *Card Title (Nama):* 14pt, `FontWeight.w700` (Bold).
    *   *Body / Info:* 12pt - 13pt, `FontWeight.w500` (Medium) & `w400` (Regular).

---

## 4. Spesifikasi Halaman & Komponen

### A. Halaman 1 — Home
*   **Header:** Layout teks judul halaman diatur ulang agar presisi, badge jumlah mahasiswa menggunakan format pill minimalis `primary.withOpacity(0.08)` dengan teks berwarna `primary`.
*   **Kartu Mahasiswa (`_StudentCard`):**
    *   Menghilangkan strip warna di bagian atas kartu.
    *   Latar belakang kartu putih penuh dengan lekukan `BorderRadius.circular(16)` dan border tipis `border` (`1.0` width).
    *   Avatar diletakkan di dalam bingkai lingkaran berlatar belakang aksen lembut yang diacak dari list `cardAccents` berdasarkan inisial nama.
    *   Menggunakan `InkWell` untuk respon sentuhan riak air yang natural.
    *   Nama dan pin domisili disusun dengan hierarki tipografi yang tajam.
*   **FAB:** Bentuk kapsul ramping, berlatar belakang `primary` dengan bayangan *soft ambient* yang minim.

### B. Halaman 2 — Tambah Mahasiswa
*   **Avatar Preview Card:** Berbentuk kotak berlekukan halus (`BorderRadius.circular(16)`) berlatar putih dengan bayangan tipis, memuat avatar bulat dan pill label "Avatar diacak otomatis" yang bernuansa senada.
*   **Form Field (Input Teks & Dropdown):**
    *   Warna latar belakang field menggunakan `#F8FAFC` dengan border tipis `#E2E8F0`.
    *   Saat aktif, border bertransisi menjadi warna `primary` dengan ketebalan `1.5`.
    *   Menambahkan `autovalidateMode: AutovalidateMode.onUserInteraction` pada field nama dan nomor HP.
*   **Checkbox Consent:** Wadah persetujuan menggunakan warna latar `primary.withOpacity(0.08)` dan border `primary` saat diaktifkan.
*   **Submit Button:** Tombol solid lebar penuh yang berwarna abu-abu pudar saat dinonaktifkan, dan berubah warna menjadi `primary` secara mulus saat aktif.

### C. Halaman 3 — Profile
*   **Hero Section:** Area atas menggunakan latar belakang `primary.withOpacity(0.04)` dengan border melengkung halus di bagian bawah. Avatar diperbesar dan diberi bingkai putih bersih berbayangan premium.
*   **Detail Info Cards:**
    *   Ikon HP: Latar belakang `primary.withOpacity(0.06)`, warna ikon `primary`.
    *   Ikon Domisili: Latar belakang `accent.withOpacity(0.08)`, warna ikon `accent`.
*   **Banner Batas Penghapusan:** Jika jumlah mahasiswa tepat berjumlah 3, banner peringatan muncul dengan gaya amber hangat (latar `#FEF3C7`, teks `#B45309`, border `#FDE68A`).
*   **Tombol Hapus:** Menggunakan warna merah destruktif premium (`#DC2626`) saat aktif, dan abu-abu tipis saat dinonaktifkan.
*   **Bottom Sheet Konfirmasi:** Lekukan atas `24`, tombol Batal berupa *outlined button* minimalis, tombol Hapus berupa *solid button* Crimson Red (`#DC2626`).

---

## 5. Panduan Teknis & Implementasi
1.  **Package Tambahan:** Tambahkan package `google_fonts` pada `pubspec.yaml` untuk memuat *Plus Jakarta Sans*.
2.  **State Management & Logika:** Tetap menggunakan `setState()` murni dan mempertahankan pemrosesan hasil data dari navigasi pop-push sesuai spesifikasi tugas UTS.
3.  **Refaktor Parameter Warna:** Ganti semua konstanta statis warna lokal di masing-masing file agar merujuk ke skema warna global `Theme.of(context).colorScheme` atau class `AppTheme` yang didefinisikan terpusat.
