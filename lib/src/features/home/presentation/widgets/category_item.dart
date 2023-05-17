import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    required this.categoryTitle,
    super.key,
  });

  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    final cleanTitle = categoryTitle.contains(': ') ? categoryTitle.split(': ').last : categoryTitle;
    return Column(
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
    );
  }
}
