import 'package:flutter/material.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/avatar_widget.dart';
import 'package:trivia_app/src/style/style.dart';
import 'package:trivia_app/src/widgets/buttons/custom_button.dart';

class FriendRequestItemWidget extends StatelessWidget {
  const FriendRequestItemWidget(
      {super.key,
      required this.onTapAccept,
      required this.displayName,
      required this.photoUrl,
      required this.onTapDeny,
      required this.onTapUser});

  final void Function() onTapAccept;
  final void Function() onTapDeny;
  final void Function() onTapUser;
  final String displayName;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapAccept,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppMargins.smallMargin),
          child: Row(
            children: [
              GestureDetector(
                onTap: onTapUser,
                child: AvatarWidget(
                  photoUrl: photoUrl,
                  avatarSize: 24,
                ),
              ),
              const SizedBox(width: AppMargins.smallMargin),
              Text(displayName),
              const Spacer(),
              CustomButton.primary(
                  height: 32,
                  width: 85,
                  text: 'Accept',
                  onPressed: onTapAccept),
              const SizedBox(width: 4),
              CustomButton.outlined(
                  height: 32, width: 80, text: 'Deny', onPressed: onTapDeny)
            ],
          ),
        ),
      ),
    );
  }
}
