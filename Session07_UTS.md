# **Ujian Tengah Semester — Mobile Computing**

Sesi 7 | Semester Genap 2025/2026 

| Mata Kuliah | Mobile Computing |
| :---- | :---- |
| **Program Studi** | Sains Data — Fakultas Ilmu Komputer |
| **Universitas** | Universitas Cakrawala |
| **Bobot Penilaian** | 20% dari nilai akhir semester |
| **Bentuk** | Proyek Tim (4 anggota per tim) |
| **Deadline** | Sebelum Sesi 9 dimulai |

## **Deskripsi Tugas**

Buatlah sebuah aplikasi Flutter bernama **Student Directory** — aplikasi untuk menampilkan dan mengelola daftar mahasiswa secara sederhana.

Aplikasi terdiri dari tiga halaman yang saling terhubung menggunakan navigasi. Struktur halaman, alur navigasi, dan spesifikasi form ditentukan dalam dokumen ini. Desain visual — termasuk pilihan warna, tipografi, spacing, dan tata letak kartu — merupakan keputusan tim dan menjadi bagian dari penilaian.

Kode harus dapat dijalankan tanpa error pada emulator atau perangkat fisik pada saat pengumpulan.

## **Alur Navigasi**

Halaman 1 — Home  
(Daftar mahasiswa dalam GridView)  
        |  
        |--- tap kartu mahasiswa \---------\> Halaman 3 — Profile  
        |                                  (kirim data mahasiswa)  
        |                                           |  
        |                                           |--- tap "Hapus Akun Ini"  
        |                                                \-\> kembali ke Home,  
        |\<-------------------------------------------    mahasiswa dihapus dari daftar  
        |  
        |--- tap Floating Action Button \--\> Halaman 2 — Tambah Mahasiswa  
                                          (kembali ke Home setelah submit,  
                                           daftar mahasiswa diperbarui)

## **Spesifikasi Halaman**

### **Halaman 1 — Home**

Halaman ini menampilkan daftar seluruh mahasiswa yang telah ditambahkan.

* Tampilkan mahasiswa menggunakan GridView dengan 2 kolom

* Setiap item dalam grid menampilkan: foto avatar, nama mahasiswa, dan domisili

* Terdapat FloatingActionButton di sudut kanan bawah untuk membuka Halaman 2

* Saat aplikasi pertama dibuka, daftar **wajib** menampilkan data awal yang telah disediakan (lihat initialStudentsData di bagian Data yang Disediakan) — halaman Home tidak boleh dimulai dalam kondisi kosong

* Setelah mahasiswa berhasil ditambahkan dari Halaman 2, data baru langsung muncul di daftar tanpa perlu restart aplikasi

* Tap pada kartu mahasiswa membuka Halaman 3 dengan data mahasiswa yang dipilih

### **Halaman 2 — Tambah Mahasiswa**

Halaman ini berisi form untuk menambahkan data mahasiswa baru.

1. **Avatar**

   * Avatar ditentukan secara acak dari avatarList yang disediakan (lihat bagian Data yang Disediakan)

   * Avatar dipilih saat halaman dibuka dan ditampilkan pada form sebelum pengguna mengisi data lain

   * Avatar yang tampil adalah avatar yang akan tersimpan — tidak perlu tombol "acak ulang"

2. **Nama** — input teks bebas, wajib diisi

3. **Domisili** — pilihan menggunakan DropdownButton atau DropdownButtonFormField; daftar pilihan menggunakan domisiliList yang disediakan

4. **Persetujuan (Consent)** — Checkbox dengan label: "Saya menyatakan bahwa data yang saya masukkan adalah benar."

5. **Nomor HP** — input angka, wajib diisi

6. **Tombol Submit**

   * Dalam kondisi **nonaktif** (disabled) selama checkbox persetujuan belum dicentang

   * Ketika checkbox dicentang, tombol menjadi aktif

   * Saat ditekan: validasi bahwa nama dan nomor HP tidak kosong

   * Jika validasi berhasil: kembali ke Halaman 1 dan tambahkan mahasiswa baru ke daftar

   * Jika validasi gagal: tampilkan pesan error yang sesuai (tidak perlu kembali ke Halaman 1\)

### **Halaman 3 — Profile**

Halaman ini menampilkan detail lengkap seorang mahasiswa dan memberikan opsi untuk menghapusnya dari daftar.

* Data diterima dari Halaman 1 melalui arguments pada Navigator.pushNamed()

* Tampilkan: foto avatar, nama, domisili, dan nomor HP

* Terdapat tombol atau mekanisme untuk kembali ke Halaman 1

* Terdapat tombol **"Hapus Akun Ini"** dengan ketentuan:

  * Saat ditekan, kembali ke Halaman 1 dan mahasiswa dihapus dari daftar (tidak muncul lagi di GridView)

  * Gunakan Navigator.pop(context, result) agar Halaman 1 dapat memproses penghapusan melalui setState()

  * **Batas minimum daftar:** apabila jumlah mahasiswa saat ini tepat berjumlah 3, tombol "Hapus Akun Ini" harus dalam kondisi nonaktif (disabled)

  * Informasi jumlah mahasiswa (totalStudents) dikirim dari Halaman 1 ke Halaman 3 bersama data mahasiswa yang dipilih

## **Data yang Disediakan**

Salin variabel-variabel berikut ke dalam project. Penempatan di file terpisah (misalnya lib/data/app\_data.dart) sangat disarankan.

### **Data Awal Mahasiswa**

Gunakan data berikut sebagai isi awal daftar mahasiswa di Halaman 1\. Sesuaikan dengan struktur class Student yang tim kamu buat.

const List\<Map\<String, String\>\> initialStudentsData \= \[  
  { 'name': 'Budi Santoso',  'avatar': 'https://i.pravatar.cc/150?img=1',  'domisili': 'Jakarta Selatan',  'phone': '081234567890' },  
  { 'name': 'Sari Dewi',     'avatar': 'https://i.pravatar.cc/150?img=5',  'domisili': 'Bekasi',           'phone': '087654321098' },  
  { 'name': 'Ahmad Fauzi',   'avatar': 'https://i.pravatar.cc/150?img=3',  'domisili': 'Tangerang Selatan','phone': '082198765432' },  
  { 'name': 'Rina Kusuma',   'avatar': 'https://i.pravatar.cc/150?img=8',  'domisili': 'Depok',            'phone': '089876543210' },  
  { 'name': 'Dian Pratama',  'avatar': 'https://i.pravatar.cc/150?img=11', 'domisili': 'Bogor',            'phone': '085678901234' },  
\];

### **Daftar Avatar**

const List\<String\> avatarList \= \[  
  'https://i.pravatar.cc/150?img=1',  
  'https://i.pravatar.cc/150?img=2',  
  'https://i.pravatar.cc/150?img=3',  
  'https://i.pravatar.cc/150?img=4',  
  'https://i.pravatar.cc/150?img=5',  
  'https://i.pravatar.cc/150?img=6',  
  'https://i.pravatar.cc/150?img=7',  
  'https://i.pravatar.cc/150?img=8',  
  'https://i.pravatar.cc/150?img=9',  
  'https://i.pravatar.cc/150?img=10',  
  'https://i.pravatar.cc/150?img=11',  
  'https://i.pravatar.cc/150?img=12',  
\];

Untuk memilih avatar secara acak saat halaman dibuka:

import 'dart:math';  
   
final String randomAvatar \= avatarList\[Random().nextInt(avatarList.length)\];

### **Daftar Domisili**

const List\<String\> domisiliList \= \[  
  'Jakarta Pusat', 'Jakarta Utara', 'Jakarta Selatan',  
  'Jakarta Barat', 'Jakarta Timur', 'Tangerang',  
  'Tangerang Selatan', 'Bekasi', 'Depok', 'Bogor',  
  'Bandung', 'Surabaya', 'Semarang', 'Yogyakarta',  
  'Medan', 'Makassar', 'Palembang', 'Denpasar',  
  'Malang', 'Lainnya',  
\];

## **Ketentuan Teknis**

* Penambahan mahasiswa baru harus tercermin di Halaman 1 tanpa restart — gunakan Navigator.pop(context, newStudent) dari Halaman 2, tangkap hasilnya di Halaman 1 dengan await Navigator.pushNamed(...), lalu tambahkan ke list menggunakan setState()

* Penghapusan mahasiswa dari Halaman 3 harus tercermin di Halaman 1 tanpa restart — gunakan pola yang sama: Navigator.pop(context, result) dari Halaman 3, tangkap hasilnya di Halaman 1, lalu hapus dari list menggunakan setState()

* Tidak diperbolehkan menggunakan package state management eksternal (Provider, Riverpod, Bloc) — cukup gunakan setState()

* Penggunaan package tambahan lain diperbolehkan selama tidak menggantikan logika utama yang diminta

* Aplikasi harus dapat dijalankan pada emulator Android atau perangkat fisik

## **Struktur Folder yang Disarankan**

Tim bebas menggunakan struktur lain selama kode tetap terorganisir dan mudah dibaca.

lib/  
├── data/  
│   └── app\_data.dart          \# avatarList, domisiliList, initialStudentsData  
├── models/  
│   └── student.dart           \# class Student (name, avatar, domisili, phone)  
├── pages/  
│   ├── home\_page.dart  
│   ├── add\_student\_page.dart  
│   └── profile\_page.dart  
└── main.dart

## **Cara Pengumpulan**

Kumpulkan source code dalam format .zip berisi seluruh folder project Flutter.

Pastikan file .zip dapat langsung di-extract dan dijalankan dengan flutter run tanpa konfigurasi tambahan. Sertakan folder lib/ beserta pubspec.yaml — tidak perlu menyertakan folder build/ atau .dart\_tool/.

* **Platform:** Edlink

* **Deadline:** Sebelum Sesi 9 dimulai (1 Minggu)

* **Keterlambatan:** Pengumpulan setelah deadline tidak diterima kecuali ada konfirmasi sebelumnya dengan dosen

## **Demo Langsung — Sesi 9**

Pada pertemuan Sesi 9, setiap tim akan melakukan demo langsung aplikasi di depan kelas.

* **Durasi:** maksimal 5 menit per tim

* Aplikasi dijalankan langsung dari perangkat fisik atau emulator — bukan screenshot atau rekaman

* Semua anggota tim hadir dan siap menjawab pertanyaan teknis mengenai kode yang ditulis

Tim menunjukkan seluruh alur berikut secara berurutan:

1. Halaman 1 terbuka dengan data awal yang sudah terisi  
2. Tambah mahasiswa baru via FAB — isi form, centang checkbox, Submit — mahasiswa baru muncul di daftar  
3. Tap kartu mahasiswa — Halaman 3 menampilkan data yang benar  
4. Hapus mahasiswa — kembali ke Halaman 1, data terhapus dari daftar  
5. Coba hapus ketika daftar tersisa 3 — tombol "Hapus Akun Ini" tidak dapat ditekan

## **Catatan**

* Seluruh anggota tim bertanggung jawab atas keseluruhan kode — nilai diberikan per tim, bukan per individu

* Kode yang identik dengan tim lain akan didiskualifikasi

* Pertanyaan teknis dapat diajukan melalui ketua kelas (whatsapp)