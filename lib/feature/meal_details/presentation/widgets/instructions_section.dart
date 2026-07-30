import 'package:flutter/material.dart';
import 'package:reciepe_app/core/constants/app_colors.dart';

class InstructionsSection extends StatelessWidget {
  final String instructions;

  const InstructionsSection({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    if (instructions.trim().isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(
              Icons.description_outlined,
              color: AppColors.primaryBrown,
              size: 22,
            ),
            SizedBox(width: 8),
            Text(
              'Instructions',
              style: TextStyle(
                color: AppColors.primaryBrown,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            instructions.trim(),
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
