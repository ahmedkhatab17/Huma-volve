import 'package:flutter/material.dart';
import 'package:reciepe_app/core/constants/app_colors.dart';

class MealDetailsSliverAppBar extends StatefulWidget {
  final String title;
  final String imageUrl;

  const MealDetailsSliverAppBar({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  State<MealDetailsSliverAppBar> createState() =>
      _MealDetailsSliverAppBarState();
}

class _MealDetailsSliverAppBarState extends State<MealDetailsSliverAppBar> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280.0,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: AppColors.cardBackground.withValues(alpha: 0.85),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primaryBrown,
              size: 20,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.cardBackground.withValues(alpha: 0.85),
            child: IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                color: _isFavorite ? Colors.red : AppColors.primaryBrown,
                size: 22,
              ),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (widget.imageUrl.isNotEmpty)
              Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFFAF2EE),
                    child: const Icon(
                      Icons.restaurant,
                      color: AppColors.primaryBrown,
                      size: 64,
                    ),
                  );
                },
              )
            else
              Container(
                color: const Color(0xFFFAF2EE),
                child: const Icon(
                  Icons.restaurant,
                  color: AppColors.primaryBrown,
                  size: 64,
                ),
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.4),
                    Colors.transparent,
                    AppColors.background.withValues(alpha: 0.9),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
