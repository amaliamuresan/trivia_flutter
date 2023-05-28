import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/src/enums/page_state_enum.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/notifications/presentation/blocs/manage_friend_requests_bloc/manage_friend_requests_bloc.dart';
import 'package:trivia_app/src/features/notifications/presentation/widgets/friend_request_item_widget.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_public_data.dart';
import 'package:trivia_app/src/features/profile/domain/user_data_service.dart';

class FriendRequestsListWidget extends StatelessWidget {
  const FriendRequestsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManageFriendRequestsBloc(context.read<AuthBloc>().state.authUserData.id),
      child: BlocBuilder<ManageFriendRequestsBloc, ManageFriendRequestsState>(
        builder: (context, state) {
          if (state.pageStateEnum == PageStateEnum.loaded) {
            return state.friendRequests.isEmpty
                ? const Text('No friend requests yet')
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return FriendRequestItemWidget(
                              onTapAccept: () =>
                                  context.read<ManageFriendRequestsBloc>().add(AcceptPressed(state.friendRequests[index].id)),
                              displayName: state.friendRequests[index].displayName ?? '',
                              photoUrl: state.friendRequests[index].photoUrl,
                              onTapDeny: () => context.read<ManageFriendRequestsBloc>().add(DenyPressed(state.friendRequests[index].id)),
                              onTapUser: () {},
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 6);
                          },
                          itemCount: state.friendRequests.length,
                        ),
                      ),
                    ],
                  );
          } else if (state.pageStateEnum == PageStateEnum.error) {
            return Text('Something went wrong');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
