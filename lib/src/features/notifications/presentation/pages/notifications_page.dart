import 'package:flutter/material.dart';
import 'package:trivia_app/src/features/notifications/presentation/widgets/friend_requests_list_widget.dart';
import 'package:trivia_app/src/features/notifications/temp_notification_challenges.dart';
import 'package:trivia_app/src/style/style.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Challenges',
              ),
              Tab(
                text: 'Friend requests',
              )
            ],
            indicatorPadding: EdgeInsets.symmetric(horizontal: AppMargins.bigMargin),
            indicatorColor: AppColors.accentColor,
          ),
        ),
        body: const TabBarView(
          children: [
            //MatchRequestsListWidget(),
            TempNotificationChallenges(),
            FriendRequestsListWidget(),
          ],
        ),
      ),
    );
  }
}
