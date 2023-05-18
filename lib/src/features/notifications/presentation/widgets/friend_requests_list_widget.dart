import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/notifications/presentation/widgets/friend_request_item_widget.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_public_data.dart';
import 'package:trivia_app/src/features/profile/domain/user_data_service.dart';

class FriendRequestsListWidget extends StatelessWidget {
  const FriendRequestsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FirestoreUserPublicData>?>(
      future: UserDataService()
          .getFriendsRequests(context.read<AuthBloc>().state.publicUserData.id),
      builder: (BuildContext context,
          AsyncSnapshot<List<FirestoreUserPublicData>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final friendRequests = snapshot.data;
          return friendRequests == null || friendRequests.isEmpty
              ? const Text('No friend requests yet')
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return FriendRequestItemWidget(
                            onTapAccept: () {},
                            displayName:
                                friendRequests[index].displayName ?? '',
                            photoUrl: friendRequests[index].photoUrl,
                            onTapDeny: () {},
                            onTapUser: () {},
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 6);
                        },
                        itemCount: friendRequests.length,
                      ),
                    ),
                  ],
                );
        } else if (snapshot.hasError) {
          return Text('Something went wrong');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
