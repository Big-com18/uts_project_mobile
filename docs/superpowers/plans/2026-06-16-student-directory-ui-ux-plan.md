# Implementation Plan: Student Directory UI/UX Redesign

**Project Context:** Student Directory (Tugas UTS Mobile Computing)  
**Date:** 2026-06-16  
**Author:** Senior UI/UX Designer & Flutter Developer  
**Status:** Ready to execute  

This plan outlines the concrete steps to execute the approved UI/UX redesign specifications based on **Opsi A (Minimalist Soft UI)**.

---

## Phase 1: Environment & Theme Setup
- [ ] **Step 1.1:** Add `google_fonts` package dependency.
  - Run `flutter pub add google_fonts`
- [ ] **Step 1.2:** Create a centralized theme file at `lib/theme/app_theme.dart` containing:
  - `AppTheme` class with `Color` constants for **Opsi 7 (Nordic Graphite & Warm Amber)** as default.
  - Commented block containing colors for **Opsi 6 (Oceanic Teal & Sage Mint)** for easy switching.
  - Soft card accent color arrays.
- [ ] **Step 1.3:** Modify `lib/main.dart` to:
  - Import `google_fonts` and `app_theme.dart`.
  - Configure `ThemeData` to apply `Plus Jakarta Sans` as the default text theme globally.
  - Set `scaffoldBackgroundColor` to `AppTheme.background`.

## Phase 2: Page 1 Redesign (Home Page)
- [ ] **Step 2.1:** Modify `lib/pages/list_mahasiswa_pages.dart` to:
  - Remove local color declarations.
  - Import `app_theme.dart`.
  - Redesign header elements: title fonts, spacing, and student count pill badge (using `AppTheme.primary.withOpacity(0.08)` and `AppTheme.primary` text).
  - Redesign `_StudentCard`:
    - Replace `GestureDetector` with `Material` -> `InkWell` to provide ripple touch feedback.
    - Remove the hardcoded top colored bar container.
    - Place the avatar centrally inside a soft container colored dynamically using `AppTheme.cardAccents` based on the name.
    - Set background to `AppTheme.cardBg` (white), with `BorderRadius.circular(16)`, border `Border.all(color: AppTheme.border)`, and a very soft shadow.
    - Apply `Plus Jakarta Sans` styling and adjust text colors to `AppTheme.textPrimary` and `AppTheme.textSecondary`.
  - Redesign floating action button `_AddFab` to fit Capsule style and use `AppTheme.primary` / `AppTheme.accent` with white text.

## Phase 3: Page 2 Redesign (Tambah Mahasiswa Page)
- [ ] **Step 3.1:** Modify `lib/pages/tambah_mahasiswa.dart` to:
  - Import `app_theme.dart`.
  - Remove local color constants.
  - Redesign Avatar Card preview to use `AppTheme.cardBg`, rounded `16`, light shadow, and soft pill badge.
  - Update `InputDecoration` to use clean background (`AppTheme.cardBg` or slightly off-white) and clean borders (`AppTheme.border`).
  - Enable `autovalidateMode: AutovalidateMode.onUserInteraction` on input text fields for real-time inline validation.
  - Style the custom checkbox consent container and animation to match primary theme colors.
  - Redesign the Submit button colors for disabled/active states using `AppTheme.primary`.

## Phase 4: Page 3 Redesign (Profile Page)
- [ ] **Step 4.1:** Modify `lib/pages/profile_page.dart` to:
  - Import `app_theme.dart`.
  - Remove local colors.
  - Redesign top Hero section: container background `AppTheme.primary.withOpacity(0.04)` with rounded bottom corners. Frame avatar with premium white circle and soft shadow.
  - Standardize `_InfoCard` icon colors to use `AppTheme.primary` (HP) and `AppTheme.accent` (Domisili).
  - Redesign warning banner (when exact 3 students) to use soft Amber background and border, with dark amber text.
  - Style delete button to solid red Crimson (`#DC2626`) with white text and icon.
  - Redesign `_confirmDelete` bottom sheet with circular top corner radius `24`, and standard primary outlines for action buttons.

## Phase 5: Verification & Quality Assurance
- [ ] **Step 5.1:** Run `flutter run` or build sanity checks to ensure no compile errors.
- [ ] **Step 5.2:** Verify all nav callbacks continue to work as expected (adding, deleting, block deletion at 3 students).
- [ ] **Step 5.3:** Validate switchability of themes by toggling Opsi 6 in `lib/theme/app_theme.dart` and testing.
