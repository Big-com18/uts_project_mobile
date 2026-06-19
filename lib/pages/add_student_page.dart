import 'dart:math';

import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/student.dart';
import '../theme/app_theme.dart';

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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
      appBar: AppBar(
        title: const Text('Tambah Mahasiswa'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Divider line
            Container(height: 1, color: AppTheme.border),

            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                child: Form(
                  key: _formKey,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar Card
                      Center(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.primary.withOpacity(0.08),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 46,
                                backgroundImage: NetworkImage(_randomAvatar),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shuffle_rounded,
                                    size: 11,
                                    color: AppTheme.primary,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Avatar diacak otomatis',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Section: Nama
                      const _FieldLabel(label: 'Nama Lengkap'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _nameController,
                        hint: 'Masukkan nama lengkap',
                        prefixIcon: Icons.person_rounded,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Nama wajib diisi'
                            : null,
                      ),

                      const SizedBox(height: 20),

                      // Section: Domisili
                      const _FieldLabel(label: 'Domisili'),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _selectedDomisili,
                        decoration: _inputDecoration(
                          hint: 'Pilih kota / wilayah',
                          prefixIcon: Icons.location_on_rounded,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        elevation: 4,
                        selectedItemBuilder: (BuildContext context) {
                          return domisiliList.map((String value) {
                            return Text(
                              value,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textPrimary,
                              ),
                            );
                          }).toList();
                        },
                        items: domisiliList.map((String value) {
                          final isSelected = value == _selectedDomisili;
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.transparent
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    value,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? AppTheme.primary
                                          : AppTheme.textPrimary,
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.check_rounded,
                                      color: AppTheme.accent,
                                      size: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedDomisili = newValue;
                          });
                        },
                        validator: (v) =>
                            v == null ? 'Domisili wajib dipilih' : null,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppTheme.textSecondary,
                          size: 20,
                        ),
                        dropdownColor: Colors.white,
                        menuMaxHeight: 300,
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Section: Nomor HP
                      const _FieldLabel(label: 'Nomor HP'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _phoneController,
                        hint: 'Contoh: 081234567890',
                        prefixIcon: Icons.phone_rounded,
                        keyboardType: TextInputType.phone,
                        maxLength: 13,
                        validator: (v) {
                          final value = v?.trim() ?? '';
                          if (value.isEmpty) {
                            return 'Nomor HP wajib diisi';
                          }
                          if (value.length < 11) {
                            return 'Nomor HP harus minimal 11 angka';
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
                        onTap: () => setState(() => _isAgreed = !_isAgreed),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: _isAgreed
                                ? AppTheme.primary.withOpacity(0.04)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _isAgreed
                                  ? AppTheme.primary
                                  : AppTheme.border,
                              width: _isAgreed ? 1.2 : 1.0,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: _isAgreed
                                      ? AppTheme.primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: _isAgreed
                                        ? AppTheme.primary
                                        : Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                ),
                                child: _isAgreed
                                    ? const Icon(
                                        Icons.check_rounded,
                                        size: 14,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Saya menyatakan bahwa data yang saya masukkan adalah benar.',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: _isAgreed
                                        ? AppTheme.textPrimary
                                        : AppTheme.textSecondary,
                                    fontWeight: _isAgreed
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    height: 1.4,
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
                        duration: const Duration(milliseconds: 150),
                        child: SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _isAgreed ? _submit : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primary,
                              disabledBackgroundColor: Colors.grey.shade200,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.save_rounded,
                                  size: 18,
                                  color: _isAgreed
                                      ? Colors.white
                                      : Colors.grey.shade500,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Simpan Mahasiswa',
                                  style: TextStyle(
                                    fontSize: 14.5,
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

  InputDecoration _inputDecoration({
    required String hint,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppTheme.textSecondary, fontSize: 13.5),
      prefixIcon: Icon(
        prefixIcon,
        color: AppTheme.textSecondary.withOpacity(0.7),
        size: 18,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade300),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
      ),
      errorStyle: TextStyle(
        color: Colors.red.shade600,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.textPrimary,
      ),
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
        fontWeight: FontWeight.w800,
        fontSize: 12.5,
        color: AppTheme.textPrimary,
        letterSpacing: 0.1,
      ),
    );
  }
}
