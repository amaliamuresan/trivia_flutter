import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    required this.categoryTitle,
    required this.onTap,
    super.key,
  });

  final String categoryTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cleanTitle = categoryTitle.contains(': ') ? categoryTitle.split(': ').last : categoryTitle;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            cleanTitle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
