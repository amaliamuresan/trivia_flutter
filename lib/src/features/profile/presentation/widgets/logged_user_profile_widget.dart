import 'package:flutter/material.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_public_data.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/avatar_widget.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/user_statistics_widget.dart';
import 'package:trivia_app/src/style/style.dart';

class LoggedUserProfileWidget extends StatelessWidget {
  const LoggedUserProfileWidget({super.key, required this.userData});

  final FirestoreUserPublicData userData;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          Text(
            userData.displayName ?? '',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppMargins.bigMargin),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              UserStatisticsWidget(
                upperText: '${userData.nrOfMatchesPlayed ?? 0}',
                lowerText: 'matches',
              ),
              divider,
              UserStatisticsWidget(
                upperText:
                    '${(userData.nrOfMatchesWon ?? 0) ~/ (userData.nrOfMatchesPlayed ?? 1)}%',
                lowerText: 'win rate',
              ),
              divider,
              UserStatisticsWidget(
                upperText: '${userData.friendsUids?.length ?? 0}',
                lowerText: 'friends',
              ),
            ],
          )
        ],
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
