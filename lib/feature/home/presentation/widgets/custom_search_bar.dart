import 'package:flutter/material.dart';
import 'package:recipy_app_offline/core/constants/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Search recipes...',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: AppColors.cardShadow, blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: TextField(
          onChanged: onChanged,
          style: const TextStyle(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.searchHint),
            prefixIcon: const Icon(Icons.search, color: AppColors.darkBrown),
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ),
    );
  }
}
