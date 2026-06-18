# Design Specification: Domisili Input Redesign (Dropdown to Modal Bottom Sheet)

**Project Context:** Student Directory (Tugas UTS Mobile Computing)  
**Date:** 2026-06-18  
**Author:** Senior UI/UX Designer & Flutter Developer  
**Status:** Approved by User  

---

## 1. Executive Summary & Context

Halaman 2 (Tambah Mahasiswa) pada aplikasi **Student Directory** saat ini menggunakan `DropdownButtonFormField<String>` standar untuk input Domisili. Untuk meningkatkan kualitas estetika visual dan pengalaman pengguna, input Domisili ini diredesain menjadi **Modal Bottom Sheet** dengan daftar pilihan menggunakan **ListTile** melengkung (*rounded list card*).

Perubahan ini merujuk pada referensi mockup visual [WhatsApp Image 2026-06-16 at 22.24.01.jpeg](file:///D:/Study/Cakrawala%20University/Semester%204/Mobile%20Computing/uas_project_mobile/WhatsApp%20Image%202026-06-16%20at%2022.24.01.jpeg) dan mengikuti pola `showModalBottomSheet` konsisten yang sudah diimplementasikan pada konfirmasi Hapus di Halaman 3 (Profile).

---

## 2. Pendekatan Desain & Usability

### A. Human-Centered Design (HCD)
1.  **Affordance (Keterbacaan Fungsi):** Kotak input dirancang persis menyerupai TextField Nama dan Nomor HP agar pengguna langsung memahami bahwa area tersebut adalah tempat pengisian data, namun dilengkapi ikon panah ke bawah untuk menandakan tipe interaksi pilihan (select-trigger).
2.  **Keyboard Interception Prevention:** Menghindari kemunculan keyboard virtual secara tidak sengaja sewaktu pengguna men-tap field Domisili dengan menggunakan pembungkus kustom `FormField<String>` dan widget `InkWell` (bukan `TextFormField` bertipe *readOnly*).
3.  **Fokus Pemilihan Visual:** Bottom sheet memiliki tinggi maksimum terikat (70% dari tinggi layar) dan scrollbar bawaan yang aktif secara visual. Pilihan terpilih disorot dengan latar belakang gelap kontras untuk konfirmasi visual pre-attentive.

### B. Usability Heuristics (Nielsen's 10 Heuristics)
1.  **Consistency & Standards (Heuristic 4):**
    *   *Visual Input:* Trigger field menggunakan tinggi, radius (`12`), padding, jenis font (Plus Jakarta Sans), dan gaya validasi error yang seragam dengan input form lainnya.
    *   *Modal Style:* Mengikuti struktur rounded top corners `24` dan drag handle yang sama seperti bottom sheet konfirmasi hapus pada [profile_page.dart](file:///D:/Study/Cakrawala%20University/Semester%204/Mobile%20Computing/uas_project_mobile/lib/pages/profile_page.dart).
2.  **Visibility of System Status (Heuristic 1):** State terpilih (`_selectedDomisili`) langsung terupdate secara real-time pada tampilan form setelah sheet ditutup, dan validasi form langsung mendeteksi kelayakan submit secara instan.

---

## 3. Spesifikasi Komponen & Visual

### A. Domisili Trigger Field (`FormField<String>`)
*   **Tinggi Widget:** Sama dengan visual `TextFormField` (~54dp).
*   **Warna Latar:** Putih bersih (`Colors.white`).
*   **Garis Tepi (Border):** `Border.all(color: AppTheme.border, width: 1.0)`, `borderRadius: BorderRadius.circular(12)`.
*   **Ikon Kiri (Leading):** `Icons.location_on_outlined` berwarna `AppTheme.textSecondary`.
*   **Ikon Kanan (Trailing):** `Icons.keyboard_arrow_down_rounded` berwarna `AppTheme.textSecondary`.
*   **Gaya Teks Isi:**
    *   *Kosong:* "Pilih kota / wilayah" (`AppTheme.textSecondary`).
    *   *Terpilih:* `selectedDomisili` value (`AppTheme.textPrimary`, `FontWeight.w600`).
*   **Gaya Validasi Error:**
    *   *Border:* Berubah menjadi merah (`Colors.red.shade400`, `width: 1.0` atau `1.5` saat difokuskan).
    *   *Teks Pesan:* `"Domisili wajib dipilih"` berwarna merah (`Colors.red.shade600`), ukuran font `11px`, `FontWeight.w500` muncul 8px di bawah kontainer.

### B. Pilih Domisili Modal Bottom Sheet
*   **Lengkungan Atas:** `BorderRadius.vertical(top: Radius.circular(24))`.
*   **Drag Handle:** 36dp width, 4dp height, `BorderRadius.circular(2)`, warna `Colors.grey.shade300`.
*   **Header Judul:** "Pilih Domisili", rata kiri dengan padding horizontal `24`, font `Plus Jakarta Sans`, `16px`, `FontWeight.w800`, warna `AppTheme.textPrimary`.
*   **Batasan Tinggi:** Bounded `BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7)`.
*   **Scrollbar:** Menggunakan widget `Scrollbar` bawaan agar indikator scroll aktif secara visual pada list panjang.
*   **ListTile Pilihan:**
    *   Setiap ListTile dibungkus `Container` dengan margin horizontal `16`, margin vertikal `4`, dan `BorderRadius.circular(12)`.
    *   **State Terpilih (Active):**
        *   Latar belakang: `AppTheme.primary` (Nordic Graphite).
        *   Warna Teks: `Colors.white` (`FontWeight.w700`).
        *   Ikon Kanan: `Icons.check_rounded` (`Colors.white`).
    *   **State Normal (Unselected):**
        *   Latar belakang: `AppTheme.primary.withOpacity(0.04)` (abu-abu ultra-light).
        *   Warna Teks: `AppTheme.textPrimary` (`FontWeight.w500`).
        *   Ikon Kanan: none.

---

## 4. Spesifikasi Integrasi Kode (`tambah_mahasiswa.dart`)

1.  **State Management:** Nilai pilihan disimpan pada variabel state `String? _selectedDomisili`.
2.  **Fungsi Pemicu Bottom Sheet (`_showDomisiliBottomSheet`):**
    ```dart
    void _showDomisiliBottomSheet(FormFieldState<String> state) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (ctx) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              // Menghasilkan daftar ListTile dengan highlight pilihan aktif
            }
          );
        }
      );
    }
    ```
3.  **Fungsionalitas Validasi Form:**
    *   Saat salah satu item di-tap:
        1.  Parent state diperbarui: `_selectedDomisili = value`.
        2.  FormField state diperbarui: `state.didChange(value)`.
        3.  Modal ditutup: `Navigator.pop(ctx)`.
    *   Logika validasi tombol submit tetap memvalidasi bahwa `_selectedDomisili != null`.

---

## 5. Rencana Pengujian
1.  **Pengujian Tampilan Kosong & Validasi:** Menekan tombol Simpan tanpa memilih domisili, memverifikasi border input Domisili berubah merah, dan teks *"Domisili wajib dipilih"* tampil di bawahnya.
2.  **Pengujian Interaksi Bottom Sheet:** Men-tap field Domisili, memverifikasi modal muncul dengan lengkungan atas `24`, drag handle, dan scrollbar.
3.  **Pengujian State Selection:** Men-tap opsi (misal: "Bandung"), memverifikasi opsi tersebut mendapatkan highlight warna gelap dengan checkmark putih, modal otomatis tertutup, field Domisili di form terupdate dengan tulisan "Bandung" warna gelap solid, dan status error menghilang secara real-time.
