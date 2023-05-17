import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/other_user_profile.dart';
import 'package:trivia_app/src/features/search/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:trivia_app/src/features/search/presentation/widgets/user_item_widget.dart';
import 'package:trivia_app/src/style/style.dart';
import 'package:trivia_app/src/widgets/text_fields/custom_search_field.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return Column(
                children: [
                  CustomSearchField(
                    onEditingComplete: (displayName) {
                      BlocProvider.of<SearchBloc>(context).add(
                        SearchUser(displayName),
                      );
                    },
                  ),
                  const SizedBox(height: AppMargins.smallMargin),
                  if (state.searchState == SearchStateEnum.data)
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return UserItemWidget(
                            onTap: () => OtherUserProfile.showUserDialog(
                              context,
                              state.users![index],
                            ),
                            displayName: state.users![index].displayName ?? '',
                            photoUrl: state.users![index].photoUrl,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 6);
                        },
                        itemCount: state.users?.length ?? 0,
                      ),
                    ),
                  if (state.searchState == SearchStateEnum.loading)
                    const CircularProgressIndicator(
                      color: AppColors.accentColor,
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
