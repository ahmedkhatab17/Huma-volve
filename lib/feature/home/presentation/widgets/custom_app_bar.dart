import 'package:flutter/material.dart';
import 'package:recipy_app_offline/core/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onProfilePressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onMenuPressed,
    this.onProfilePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      titleSpacing: 16,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: AppColors.darkBrown),
        onPressed: onMenuPressed,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryBrown,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person_outline, color: AppColors.darkBrown),
          onPressed: onProfilePressed,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
