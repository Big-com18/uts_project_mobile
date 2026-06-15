import 'package:flutter/material.dart';
import 'dart:math';
import '../models/student.dart';
import '../data/app_data.dart';

class TambahMahasiswaPage extends StatefulWidget {
  const TambahMahasiswaPage({super.key});

  @override
  State<TambahMahasiswaPage> createState() => _TambahMahasiswaPageState();
}

class _TambahMahasiswaPageState extends State<TambahMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedDomisili;
  bool _isAgreed = false;
  late String _randomAvatar;

  static const Color _indigo = Color(0xFF6366F1);
  static const Color _indigoLight = Color(0xFFEEF2FF);
  static const Color _bgPage = Color(0xFFF8F9FB);

  @override
  void initState() {
    super.initState();
    _randomAvatar = avatarList[Random().nextInt(avatarList.length)];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDomisili == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Silakan pilih domisili'),
            behavior: SnackBarBehavior.floating,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.red.shade400,
          ),
        );
        return;
      }

      final newStudent = Student(
        name: _nameController.text.trim(),
        avatar: _randomAvatar,
        domisili: _selectedDomisili!,
        phone: _phoneController.text.trim(),
      );

      Navigator.pop(context, newStudent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgPage,
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.black87, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Tambah Mahasiswa',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Form ────────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar card
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: _indigoLight, width: 3),
                                ),
                                child: CircleAvatar(
                                  radius: 44,
                                  backgroundImage:
                                  NetworkImage(_randomAvatar),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _indigoLight,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.auto_awesome_rounded,
                                        size: 12, color: _indigo),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Avatar diacak otomatis',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: _indigo,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Section: Nama
                      _FieldLabel(label: 'Nama Lengkap'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _nameController,
                        hint: 'Masukkan nama lengkap',
                        prefixIcon: Icons.person_outline_rounded,
                        validator: (v) =>
                        (v == null || v.trim().isEmpty)
                            ? 'Nama wajib diisi'
                            : null,
                      ),

                      const SizedBox(height: 20),

                      // Section: Domisili
                      _FieldLabel(label: 'Domisili'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedDomisili,
                        decoration: _inputDecoration(
                            hint: 'Pilih kota / wilayah',
                            prefixIcon: Icons.location_on_outlined),
                        items: domisiliList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: const TextStyle(fontSize: 14)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedDomisili = newValue;
                          });
                        },
                        validator: (v) =>
                        v == null ? 'Domisili wajib dipilih' : null,
                        icon: Icon(Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey.shade500),
                        dropdownColor: Colors.white,
                        menuMaxHeight: 300,
                      ),

                      const SizedBox(height: 20),

                      // Section: Nomor HP
                      _FieldLabel(label: 'Nomor HP'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _phoneController,
                        hint: 'Contoh: 081234567890',
                        prefixIcon: Icons.phone_outlined,
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          final value = v?.trim() ?? '';
                          if (value.isEmpty) {
                            return 'Nomor HP wajib diisi';
                          }
                          if (value.length != 12) {
                            return 'Nomor HP harus tepat 12 angka';
                          }
                          if (!value.startsWith('08')) {
                            return 'Nomor HP harus diawali dengan 08';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      // Consent checkbox
                      GestureDetector(
                        onTap: () =>
                            setState(() => _isAgreed = !_isAgreed),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: _isAgreed
                                ? _indigoLight
                                : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _isAgreed
                                  ? _indigo.withOpacity(0.3)
                                  : Colors.grey.shade200,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              AnimatedContainer(
                                duration:
                                const Duration(milliseconds: 150),
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: _isAgreed
                                      ? _indigo
                                      : Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(6),
                                  border: Border.all(
                                    color: _isAgreed
                                        ? _indigo
                                        : Colors.grey.shade300,
                                    width: 1.5,
                                  ),
                                ),
                                child: _isAgreed
                                    ? const Icon(
                                  Icons.check_rounded,
                                  size: 15,
                                  color: Colors.white,
                                )
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Saya menyatakan bahwa data yang saya masukkan adalah benar.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: _isAgreed
                                        ? Colors.black87
                                        : Colors.grey.shade500,
                                    fontWeight: _isAgreed
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Submit button
                      AnimatedOpacity(
                        opacity: _isAgreed ? 1.0 : 0.45,
                        duration: const Duration(milliseconds: 200),
                        child: SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: _isAgreed ? _submit : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _indigo,
                              disabledBackgroundColor:
                              Colors.grey.shade300,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.save_rounded,
                                  size: 20,
                                  color: _isAgreed
                                      ? Colors.white
                                      : Colors.grey.shade500,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Simpan Mahasiswa',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: _isAgreed
                                        ? Colors.white
                                        : Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
      {required String hint, required IconData prefixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      prefixIcon:
      Icon(prefixIcon, color: Colors.grey.shade400, size: 20),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide:
        const BorderSide(color: Color(0xFF6366F1), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red.shade300),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      decoration: _inputDecoration(hint: hint, prefixIcon: prefixIcon),
      validator: validator,
    );
  }
}

// ── Field Label ───────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  final String label;

  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 13,
        color: Colors.black87,
        letterSpacing: 0.2,
      ),
    );
  }
}