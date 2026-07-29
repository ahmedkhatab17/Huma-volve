import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class FilterHeaderRow extends StatelessWidget {
  final int count;
  final VoidCallback? onFilterTap;

  const FilterHeaderRow({
    super.key,
    required this.count,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Recipe Count
          Text(
            '$count Recipes Found',
            style: const TextStyle(
              color: AppColors.primaryBrown,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Filter Button
          InkWell(
            onTap: onFilterTap,
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
              child: Row(
                children: [
                  Icon(
                    Icons.tune_rounded,
                    color: AppColors.primaryBrown,
                    size: 18,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Filter',
                    style: TextStyle(
                      color: AppColors.primaryBrown,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
