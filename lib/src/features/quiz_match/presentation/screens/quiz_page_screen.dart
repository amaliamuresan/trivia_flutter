import 'package:flutter/material.dart';
import 'package:trivia_app/src/features/profile/data/firestore_user_public_repository.dart';
import 'package:trivia_app/src/features/profile/domain/firestore_user_public_data.dart';
import 'package:trivia_app/src/features/quiz_menu/domain/quiz_category.dart';

class QuizPageScreen extends StatefulWidget {
  const QuizPageScreen({
    required this.category,
    super.key,
  });

  final QuizCategory category;

  @override
  State<QuizPageScreen> createState() => _QuizPageScreenState();
}

class _QuizPageScreenState extends State<QuizPageScreen> {
  late bool isLoading;
  late FirestoreUserPublicData debugUser;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugUser = await FirestoreUserPublicRepository().getUserPublicDataById('EPMxezSBUdNr5Nuvln8xLMBWLNm1');
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('This is category: ${widget.category.name}'),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Challenge debug user with name: ${debugUser.displayName}!'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
