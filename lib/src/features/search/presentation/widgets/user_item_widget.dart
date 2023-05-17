import 'package:flutter/material.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/avatar_widget.dart';
import 'package:trivia_app/src/style/style.dart';

class UserItemWidget extends StatelessWidget {
  const UserItemWidget(
      {super.key,
      required this.onTap,
      required this.displayName,
      required this.photoUrl});

  final void Function() onTap;
  final String displayName;
  final String? photoUrl;

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
                photoUrl: photoUrl,
                avatarSize: 24,
              ),
              const SizedBox(width: AppMargins.smallMargin),
              Text(displayName)
            ],
          ),
        ),
      ),
    );
  }
}
