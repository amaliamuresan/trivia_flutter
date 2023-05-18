import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_public_data.dart';
import 'package:trivia_app/src/features/profile/presentation/blocs/friend_request_bloc/friend_request_bloc.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/avatar_widget.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/user_statistics_widget.dart';
import 'package:trivia_app/src/style/style.dart';
import 'package:trivia_app/src/widgets/buttons/custom_button.dart';

class OtherUserProfile extends StatelessWidget {
  const OtherUserProfile({super.key, required this.userPublicData});

  final FirestoreUserPublicData userPublicData;

  static void showUserDialog(
      BuildContext context, FirestoreUserPublicData userPublicData) {
    showDialog<Widget>(
      context: context,
      builder: (builder) {
        return Dialog(
          backgroundColor: AppColors.surfaceLight,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: OtherUserProfile(userPublicData: userPublicData),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SizedBox(
          width: 700,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AvatarWidget(),
                const SizedBox(height: AppMargins.regularMargin),
                Text(
                  userPublicData.displayName ?? '',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppMargins.bigMargin),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: UserStatisticsWidget(
                        upperText: '${userPublicData.nrOfMatchesPlayed ?? 0}',
                        lowerText: 'matches',
                      ),
                    ),
                    divider,
                    Flexible(
                      child: UserStatisticsWidget(
                        upperText:
                            '${(userPublicData.nrOfMatchesWon ?? 0) ~/ (userPublicData.nrOfMatchesPlayed ?? 1)}%',
                        lowerText: 'win rate',
                      ),
                    ),
                    divider,
                    Flexible(
                      child: UserStatisticsWidget(
                        upperText: '${userPublicData.friendsUids?.length ?? 0}',
                        lowerText: 'friends',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppMargins.regularMargin * 2),
                if (isFriend(context) ?? false)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: CustomButton.primary(
                          text: 'Challenge!',
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: AppMargins.smallMargin),
                      Flexible(
                        child: CustomButton.outlined(
                          text: 'Friends',
                          onPressed: () {},
                          leadingIcon: const Icon(
                            Icons.check,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    ],
                  )
                else
                  BlocProvider(
                    create: (context) => FriendRequestBloc(
                      context.read<AuthBloc>().state.publicUserData.id,
                      userPublicData.id,
                    ),
                    child: BlocBuilder<FriendRequestBloc, FriendRequestState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const CircularProgressIndicator();
                        } else if (state.isFriendRequestSent) {
                          return CustomButton.primary(
                            text: 'Cancel friend request',
                            onPressed: () => context
                                .read<FriendRequestBloc>()
                                .add(CancelFriendRequestPressed()),
                          );
                        } else {
                          return CustomButton.primary(
                            text: 'Send friend request',
                            onPressed: () => context
                                .read<FriendRequestBloc>()
                                .add(SendFriendRequestPressed()),
                          );
                        }
                      },
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }

  bool? isFriend(BuildContext context) => context
      .read<AuthBloc>()
      .state
      .publicUserData
      .friendsUids
      ?.contains(userPublicData.id);

  Widget get divider => const SizedBox(
        height: 36,
        child: VerticalDivider(
          thickness: .8,
          color: AppColors.greyLight,
        ),
      );
}
