# Implementation Plan: Domisili Input Redesign (Dropdown to Modal Bottom Sheet)

**Project Context:** Student Directory (Tugas UTS Mobile Computing)  
**Date:** 2026-06-18  
**Author:** Senior UI/UX Designer & Flutter Developer  
**Status:** Ready to execute  

This plan outlines the concrete steps to execute the approved redesign of the Domisili input field on Halaman 2 (Tambah Mahasiswa) to use a Custom FormField trigger and a Modal Bottom Sheet.

---

## Phase 1: Code Refactor on tambah_mahasiswa.dart
- [ ] **Step 1.1:** Open `lib/pages/tambah_mahasiswa.dart` and add a private method `_showDomisiliBottomSheet` inside `_TambahMahasiswaPageState`:
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
            return Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                16,
                0,
                MediaQuery.of(context).padding.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag Handle
                  Center(
                    child: Container(
                      width: 36,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Title
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Pilih Domisili',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // List content bounded with Scrollbar
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemCount: domisiliList.length,
                        itemBuilder: (context, index) {
                          final item = domisiliList[index];
                          final isSelected = item == _selectedDomisili;
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primary
                                  : AppTheme.primary.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 2),
                              title: Text(
                                item,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : AppTheme.textPrimary,
                                ),
                              ),
                              trailing: isSelected
                                  ? const Icon(Icons.check_rounded,
                                      color: Colors.white, size: 20)
                                  : null,
                              onTap: () {
                                setModalState(() {
                                  _selectedDomisili = item;
                                });
                                state.didChange(item);
                                setState(() {});
                                Navigator.pop(ctx);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
  ```
- [ ] **Step 1.2:** Locate the `DropdownButtonFormField<String>` inside `lib/pages/tambah_mahasiswa.dart` and replace it with a custom `FormField<String>` trigger that replicates the TextField styling:
  ```dart
  FormField<String>(
    initialValue: _selectedDomisili,
    validator: (v) => v == null ? 'Domisili wajib dipilih' : null,
    builder: (FormFieldState<String> state) {
      final hasError = state.hasError;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => _showDomisiliBottomSheet(state),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: hasError
                      ? Colors.red.shade400
                      : AppTheme.border,
                  width: hasError ? 1.2 : 1.0,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppTheme.textSecondary.withOpacity(0.7),
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _selectedDomisili ?? 'Pilih kota / wilayah',
                      style: TextStyle(
                        color: _selectedDomisili == null
                            ? AppTheme.textSecondary
                            : AppTheme.textPrimary,
                        fontSize: 13.5,
                        fontWeight: _selectedDomisili == null
                            ? FontWeight.w400
                            : FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (hasError) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.left(16),
              child: Text(
                state.errorText ?? '',
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      );
    },
  )
  ```

## Phase 2: Verification & Quality Assurance
- [ ] **Step 2.1:** Run `flutter analyze` to ensure no warnings or compilation issues.
- [ ] **Step 2.2:** Verify that the validation operates properly and that selecting a domisili updates the field immediately and clears any validation errors.
