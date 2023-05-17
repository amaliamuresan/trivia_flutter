import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/home/presentation/widgets/avatar_tile_widget.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/logged_user_profile_widget.dart';
import 'package:trivia_app/src/routes/routes.dart';
import 'package:trivia_app/src/style/margins.dart';
import 'package:trivia_app/src/widgets/text_fields/custom_search_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => context.pushNamed(RouteNames.search),
          child: const CustomSearchField(
            isEnabled: false,
          ),
        ),
        const SizedBox(height: AppMargins.smallMargin),
        BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (previous, current) =>
              previous.publicUserData != current.publicUserData,
          builder: (context, state) {
            return AvatarTileWidget(
              username: state.publicUserData.displayName ?? '',
              avatarUrl: state.publicUserData.photoUrl,
              onTap: () {
                showModalBottomSheet<Widget>(
                  context: context,
                  builder: (BuildContext context) {
                    return LoggedUserProfileWidget(
                      userData: state.publicUserData,
                    );
                  },
                );
              },
            );
          },
        )
      ],
    );
  }
}
