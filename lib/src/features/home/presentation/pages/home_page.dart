import 'package:flutter/material.dart';
import 'package:trivia_app/src/features/home/presentation/widgets/avatar_tile_widget.dart';
import 'package:trivia_app/src/features/home/presentation/widgets/category_item.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/logged_user_profile_widget.dart';
import 'package:trivia_app/src/features/quiz_menu/data/open_trivia_repository.dart';
import 'package:trivia_app/src/features/quiz_menu/domain/quiz_category.dart';

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
        AvatarTileWidget(
          username: 'Andrei Popescu',
          onTap: () {
            showModalBottomSheet<Widget>(
              context: context,
              builder: (BuildContext context) {
                return const LoggedUserProfileWidget();
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
