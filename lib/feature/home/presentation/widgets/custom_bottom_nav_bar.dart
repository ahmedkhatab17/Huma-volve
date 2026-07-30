import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onItemTapped;

  const CustomBottomNavBar({
    super.key,
    this.selectedIndex = 1, // Search tab active by default in screenshot
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = [
      _NavItemData(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
      _NavItemData(icon: Icons.search, activeIcon: Icons.search, label: 'Search'),
      _NavItemData(icon: Icons.bookmark_border_rounded, activeIcon: Icons.bookmark_rounded, label: 'Saved'),
      _NavItemData(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
    ];

    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: const Border(
          top: BorderSide(
            color: AppColors.subtleBorder,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          final isSelected = index == selectedIndex;
          final item = navItems[index];

          return GestureDetector(
            onTap: () => onItemTapped?.call(index),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected ? item.activeIcon : item.icon,
                  size: 24,
                  color: isSelected ? AppColors.navSelected : AppColors.navUnselected,
                ),
                const SizedBox(height: 4),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? AppColors.navSelected : AppColors.navSelected,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItemData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
