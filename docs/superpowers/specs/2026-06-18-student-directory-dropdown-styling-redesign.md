# Design Specification: Domisili Dropdown Styling Redesign

**Project Context:** Student Directory (Tugas UTS Mobile Computing)  
**Date:** 2026-06-18  
**Author:** Senior UI/UX Designer & Flutter Developer  
**Status:** Approved by User  

---

## 1. Executive Summary & Context

Sesuai ketentuan wajib pada dokumen tugas (`Session07_UTS.md`), input Domisili pada Halaman 2 (Tambah Mahasiswa) harus menggunakan komponen native `DropdownButton` atau `DropdownButtonFormField`. 

Dokumen spesifikasi ini mendefinisikan **redesign visual (styling/dekorasi)** pada komponen native `DropdownButtonFormField` untuk mewujudkan estetika **Minimalist Soft UI** yang konsisten dengan halaman lain yang telah diredesign, tanpa melanggar kepatuhan fungsionalitas dan jenis widget yang ditentukan.

---

## 2. Pendekatan Desain & Usability

### A. Human-Centered Design (HCD)
1.  **Visual Consistency (Heuristic 4 - Consistency & Standards):** Trigger box dari dropdown didesain identik dengan TextField Nama dan Nomor HP dari segi tinggi (~52dp), radius (`12`), warna border, dan tipografi (Plus Jakarta Sans) agar tidak membingungkan pengguna.
2.  **Contextual Affordance:** Menggunakan ikon dropdown `Icons.keyboard_arrow_down_rounded` untuk memberi isyarat interaksi klik.
3.  **Dropdown Menu Readability (Heuristic 1 - Visibility of System Status):** Menghilangkan sudut kaku (sharp corner) pada kotak popup dropdown bawaan, diganti dengan `borderRadius` melengkung `12`. Untuk mempermudah navigasi di antara 20 kota, tinggi menu dibatasi (`menuMaxHeight: 300`) agar nyaman di-scroll.
4.  **Pre-attentive Visual Cue (Selected Highlight):** Ketika menu popup terbuka, opsi yang sedang terpilih akan mendapatkan penanda visual instan berupa latar belakang berwarna lembut, teks tebal, dan ikon centang (checkmark) berwarna amber hangat.

---

## 3. Spesifikasi Komponen & Visual (Styling Specs)

### A. Dropdown Button Form Field (Trigger Box)
*   **Warna Latar:** Putih bersih (`Colors.white`).
*   **Garis Tepi (Border):** `Border.all(color: AppTheme.border, width: 1.0)`, `borderRadius: BorderRadius.circular(12)`.
*   **Ikon Kiri (Leading):** `Icons.location_on_rounded` berwarna `AppTheme.textSecondary`.
*   **Ikon Kanan (Dropdown Arrow):** `Icons.keyboard_arrow_down_rounded` berwarna `AppTheme.textSecondary`, size `20`.
*   **Padding Konten:** Vertikal `14`, Horizontal `16`.

### B. Dropdown Popup Menu List
*   **Sudut Lengkung Menu:** `borderRadius: BorderRadius.circular(12)`.
*   **Elevasi Bayangan Menu:** `elevation: 4` (bayangan lembut).
*   **Warna Latar Menu:** `Colors.white`.
*   **Batasan Tinggi Menu:** `menuMaxHeight: 300` (Scrollable).

### C. Dropdown Menu Items (`DropdownMenuItem<String>`)
Setiap baris pilihan di dalam menu dikustomisasi dengan layout `Container` lebar penuh:
1.  **State Terpilih (Active Highlight):**
    *   *Warna Latar Belakang:* `AppTheme.primary.withOpacity(0.06)` (Abu-abu gelap ultra-soft).
    *   *Lengkungan Item:* `BorderRadius.circular(8)`.
    *   *Teks Judul:* Warna `AppTheme.primary`, `FontWeight.w700` (Bold), ukuran `14px`.
    *   *Ikon Kanan:* `Icons.check_rounded` berwarna `AppTheme.accent` (Warm Amber), ukuran `16px`.
2.  **State Normal (Unselected):**
    *   *Warna Latar Belakang:* Transparan.
    *   *Teks Judul:* Warna `AppTheme.textPrimary`, `FontWeight.w500` (Medium), ukuran `14px`.
    *   *Ikon Kanan:* None.

---

## 4. Rencana Pengujian
1.  **Uji Konsistensi Form:** Membuka Halaman 2, memverifikasi kotak dropdown Domisili sejajar dan terlihat sama dengan TextField lainnya.
2.  **Uji Tampilan Popup Menu:** Men-tap dropdown, memverifikasi menu popup memiliki sudut membulat (`12`), bayangan melayang yang lembut, dan daftar opsi dibatasi tinggi 300dp dengan scroll yang mulus.
3.  **Uji Indikator Opsi Terpilih:** Memilih opsi (misal: "Bekasi"), lalu membuka kembali menu popup, memverifikasi opsi "Bekasi" mendapatkan warna latar lembut, teks tebal, dan ikon centang berwarna Amber.
