import 'dart:math';
import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/student.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedDomisili;
  bool _isAgreed = false;
  late String _randomAvatar;

  @override
  void initState() {
    super.initState();
    // Mengambil avatar acak di awal (Sesuai Syarat)
    _randomAvatar = avatarList[Random().nextInt(avatarList.length)];
  }

  @override
  void dispose() {
    // Mencegah memory leak saat halaman ditutup
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Label Form
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 16.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF334155))),
    );
  }

  // Desain Input Universal (Minimalis & Elegan)
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF8F9FA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1E293B)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade400),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade700),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Tambah Mahasiswa', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade100, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form( 
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Avatar (Ditentukan secara acak & tidak bisa diubah)
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(_randomAvatar),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('Avatar Diberikan Acak', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 2. Nama Lengkap (Input Teks Bebas)
              _buildLabel('Nama Lengkap'),
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('Masukkan nama'),
                validator: (value) => value == null || value.trim().isEmpty ? 'Nama wajib diisi' : null,
              ),

              // 3. Domisili (DropdownButtonFormField Sesuai Syarat)
              _buildLabel('Domisili'),
              DropdownButtonFormField<String>(
                value: _selectedDomisili,
                decoration: _inputDecoration('Pilih Domisili'),
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(16), 
                elevation: 3, 
                // KUNCI RAHASIANYA DI SINI:
                menuMaxHeight: 300, // Membatasi tinggi maksimal menu agar rapi dan bisa di-scroll
                items: domisiliList.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedDomisili = newValue;
                  });
                },
                validator: (value) => value == null ? 'Pilih domisili terlebih dahulu' : null,
              ),

              // 4. Nomor HP (Input Angka)
              _buildLabel('Nomor HP'),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 13,
                decoration: _inputDecoration('Contoh: 081234567890').copyWith(counterText: ""),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Nomor HP wajib diisi';
                  if (!value.startsWith('0')) return 'Harus diawali angka 0';
                  if (value.length < 10) return 'Minimal 10 angka';
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // 5. Persetujuan Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24, height: 24,
                    child: Checkbox(
                      value: _isAgreed,
                      activeColor: const Color(0xFF1E293B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      onChanged: (value) {
                        setState(() {
                          _isAgreed = value ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Saya menyatakan bahwa data yang saya masukkan adalah benar.',
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 13, height: 1.4),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // 6. Tombol Submit (Disabled jika belum centang)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isAgreed
                      ? () {
                          // Jika divalidasi berhasil, pop ke halaman 1
                          if (_formKey.currentState!.validate()) {
                            final newStudent = Student(
                              name: _nameController.text.trim(),
                              avatar: _randomAvatar,
                              domisili: _selectedDomisili!,
                              phone: _phoneController.text.trim(),
                            );
                            Navigator.pop(context, newStudent);
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E293B),
                    disabledBackgroundColor: Colors.grey.shade300,
                    disabledForegroundColor: Colors.grey.shade500,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('Simpan Mahasiswa', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}