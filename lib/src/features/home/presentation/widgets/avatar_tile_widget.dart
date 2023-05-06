import 'package:flutter/material.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/avatar_widget.dart';
import 'package:trivia_app/src/style/colors.dart';
import 'package:trivia_app/src/style/margins.dart';

class AvatarTileWidget extends StatelessWidget {
  const AvatarTileWidget({
    required this.username,
    required this.onTap,
    this.avatarUrl,
    super.key,
  });

  final String? avatarUrl;
  final String username;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppMargins.smallMargin),
          child: Row(
            children: [
              AvatarWidget(
                photoUrl: avatarUrl,
                avatarSize: 26,
              ),
              const SizedBox(width: AppMargins.regularMargin),
              Text(
                username,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios_outlined, color: AppColors.white)
            ],
          ),
        ),
      ),
    );
  }
}
