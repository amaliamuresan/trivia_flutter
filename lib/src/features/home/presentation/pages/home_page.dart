import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/home/presentation/widgets/avatar_tile_widget.dart';
import 'package:trivia_app/src/features/home/presentation/widgets/category_item.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/logged_user_profile_widget.dart';
import 'package:trivia_app/src/features/quiz_menu/data/open_trivia_repository.dart';
import 'package:trivia_app/src/features/quiz_menu/domain/quiz_category.dart';
import 'package:trivia_app/src/routes/routes.dart';
import 'package:trivia_app/src/style/style.dart';
import 'package:trivia_app/src/widgets/text_fields/custom_search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isLoading;
  List<QuizCategory> quizCategories = <QuizCategory>[];
  final OpenTriviaRepository _openTriviaRepository = OpenTriviaRepository();

  @override
  void initState() {
    super.initState();
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      quizCategories = await _openTriviaRepository.getCategories();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
          buildWhen: (previous, current) => previous.publicUserData != current.publicUserData,
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
        ),
        if (isLoading)
          CircularProgressIndicator()
        else
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: quizCategories.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  // height: 800,
                  child: CategoryItem(
                    onTap: () {},
                    categoryTitle: quizCategories[index].name,
                  ),
                );
              },
            ),
          )
      ],
    );
  }
}
