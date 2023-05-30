import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/avatar_widget.dart';
import 'package:trivia_app/src/style/style.dart';

class GameResultsWidget extends StatelessWidget {
  const GameResultsWidget(
      {super.key,
      required this.categoryName,
      required this.nrOfCorrectAnswers});

  final String categoryName;
  final int nrOfCorrectAnswers;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('assets/animations/confetti.json'),
        Column(
          children: [
            AvatarWidget(
              photoUrl: context.read<AuthBloc>().state.publicUserData.photoUrl,
            ),
            const SizedBox(height: AppMargins.bigMargin),
            const Text(
              'Congratulations!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: AppMargins.regularMargin),
            Text(
              "You've got $nrOfCorrectAnswers correct on $categoryName",
              textAlign: TextAlign.center,
            ),
          ],
        )
      ],
    );
  }
}
