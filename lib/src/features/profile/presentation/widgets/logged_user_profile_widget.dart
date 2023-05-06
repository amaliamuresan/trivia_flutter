import 'package:flutter/material.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/avatar_widget.dart';
import 'package:trivia_app/src/style/style.dart';

class LoggedUserProfileWidget extends StatelessWidget {
  const LoggedUserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(16),
      //     topRight: Radius.circular(16),
      //   ),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(AppMargins.regularMargin),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const AvatarWidget(),
                GestureDetector(
                  onTap: () {},
                  child: const _EditProfileIcon(),
                ),
              ],
            ),
            const SizedBox(height: AppMargins.regularMargin),
            const Text(
              'Andrei Popescu',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppMargins.bigMargin),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const _UserInfoWidget(upperText: '170', lowerText: 'games played'),
                divider,
                const _UserInfoWidget(upperText: '47%', lowerText: 'win rate'),
                divider,
                const _UserInfoWidget(upperText: '14', lowerText: 'friends'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget get divider => const SizedBox(
        height: 36,
        child: VerticalDivider(
          thickness: .8,
          color: AppColors.greyLight,
        ),
      );
}

class _EditProfileIcon extends StatelessWidget {
  const _EditProfileIcon();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.white,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          Icons.edit_rounded,
          color: AppColors.white,
          size: 16,
        ),
      ),
    );
  }
}

class _UserInfoWidget extends StatelessWidget {
  const _UserInfoWidget({required this.upperText, required this.lowerText});

  final String upperText;
  final String lowerText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          upperText,
          style: const TextStyle(color: AppColors.primary),
        ),
        const SizedBox(height: AppMargins.extraSmallMargin),
        Text(
          lowerText,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
