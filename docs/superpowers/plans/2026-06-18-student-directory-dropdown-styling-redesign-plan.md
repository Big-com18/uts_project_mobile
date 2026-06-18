# Implementation Plan: Domisili Dropdown Styling Redesign

**Project Context:** Student Directory (Tugas UTS Mobile Computing)  
**Date:** 2026-06-18  
**Author:** Senior UI/UX Designer & Flutter Developer  
**Status:** Ready to execute  

This plan outlines the concrete steps to execute the approved redesign styling of the Domisili input field on Halaman 2 (Tambah Mahasiswa) using native `DropdownButtonFormField` styling configurations.

---

## Phase 1: Code Customization on tambah_mahasiswa.dart
- [ ] **Step 1.1:** Open `lib/pages/tambah_mahasiswa.dart` and locate the `DropdownButtonFormField<String>` widget.
- [ ] **Step 1.2:** Update the properties of `DropdownButtonFormField<String>` to support rounded corners for the popup menu and soft elevation:
  - Add `borderRadius: BorderRadius.circular(12)`
  - Add `elevation: 4`
  - Ensure `menuMaxHeight: 300` and `dropdownColor: Colors.white` are correctly configured.
- [ ] **Step 1.3:** Redesign the `items` mapping builder to style each item dynamically based on whether it is selected or not:
  ```dart
  items: domisiliList.map((String value) {
    final isSelected = value == _selectedDomisili;
    return DropdownMenuItem<String>(
      value: value,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primary.withOpacity(0.06)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppTheme.primary : AppTheme.textPrimary,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_rounded,
                color: AppTheme.accent,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }).toList(),
  ```

## Phase 2: Verification & Quality Assurance
- [ ] **Step 2.1:** Run `flutter analyze` to ensure no warnings or compilation issues.
- [ ] **Step 2.2:** Verify that the dropdown visual styling matches the specification:
  - Selected item is highlighted with soft background and checkmark.
  - Border and height match other fields.
  - Dropdown popup menu has rounded corners.
