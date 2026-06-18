import 'package:flutter/material.dart';

// ====================================================================
// APP THEME DEFINITION
// ====================================================================
// Anda dapat menukar seluruh palet warna aplikasi secara instan
// dengan menukar komentar pada blok opsi tema di bawah ini.

// --------------------------------------------------------------------
// OPSI UTAMA: Opsi 7 (Nordic Graphite & Warm Amber) - Default
// --------------------------------------------------------------------
class AppTheme {
  static const Color primary = Color(0xFF1E293B); // Nordic Graphite
  static const Color accent = Color(0xFFD97706); // Warm Amber
  static const Color background = Color(0xFFFAF9F6); // Warm Off-White
  static const Color cardBg = Colors.white; // Pure White
  static const Color textPrimary = Color(0xFF0F172A); // Charcoal Slate
  static const Color textSecondary = Color(0xFF64748B); // Slate Gray
  static const Color border = Color(0xFFE2E8F0); // Soft Slate Border

  // Warna-warna aksen latar belakang kartu inisial
  static const List<Color> cardAccents = [
    Color(0xFFF1F5F9), // Slate Light
    Color(0xFFFEF3C7), // Amber Light
    Color(0xFFFEE2E2), // Red Light
    Color(0xFFF0FDF4), // Green Light
    Color(0xFFEFF6FF), // Blue Light
  ];
}

// --------------------------------------------------------------------
// OPSI CADANGAN: Opsi 6 (Oceanic Teal & Sage Mint)
// Untuk menggunakan opsi ini, silakan hapus komentar pada blok di bawah
// dan beri komentar pada blok Opsi 7 di atas.
// --------------------------------------------------------------------
/*
class AppTheme {
  static const Color primary = Color(0xFF0D9488);      // Oceanic Teal
  static const Color accent = Color(0xFF0F766E);       // Darker Teal
  static const Color background = Color(0xFFF4F9F6);   // Sage Mint
  static const Color cardBg = Colors.white;            // Pure White
  static const Color textPrimary = Color(0xFF115E59);  // Dark Spruce
  static const Color textSecondary = Color(0xFF5F9EA0);// Light Slate
  static const Color border = Color(0xFFE6F2ED);       // Soft Mint Border

  static const List<Color> cardAccents = [
    Color(0xFFE6F4F1), // Soft Teal
    Color(0xFFF0FDF4), // Soft Green
    Color(0xFFFFF7ED), // Soft Orange
    Color(0xFFFDF4FF), // Soft Purple
    Color(0xFFF0F9FF), // Soft Blue
  ];
}
*/
