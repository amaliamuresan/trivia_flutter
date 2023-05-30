import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/features/home/helpers/category_image_selector_helper.dart';
import 'package:trivia_app/src/features/quiz_menu/domain/quiz_category.dart';
import 'package:trivia_app/src/routes/routes.dart';
import 'package:trivia_app/src/style/style.dart';
import 'package:trivia_app/src/widgets/buttons/custom_button.dart';

class CategoryDialog extends StatelessWidget {
  const CategoryDialog({super.key, required this.category});

  final QuizCategory category;

  static void showCategoryDialog(BuildContext context, QuizCategory category) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          contentPadding: const EdgeInsets.all(24),
          backgroundColor: AppColors.surfaceLight,
          content: CategoryDialog(
            category: category,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 110,
              width: 110,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  CategoryImageSelectorHelper.getImageForCategory(
                        category.name,
                      ) ??
                      '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  Text(
                    category.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  const Text('10 questions')
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: AppMargins.bigMargin),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton.primary(
                width: 110,
                text: 'Challenge!',
                onPressed: () =>
                    context.pushNamed(RouteNames.quizPage, extra: category)),
            CustomButton.outlined(
              width: 110,
              text: 'Play alone',
              onPressed: () =>
                  context.pushNamed(RouteNames.singleGame, extra: category),
            )
          ],
        ),
      ],
    );
  }
}
