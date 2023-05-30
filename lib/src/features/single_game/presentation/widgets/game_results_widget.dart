import 'package:flutter/material.dart';

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
        Text(
          "Congratulations!\nYou've got $nrOfCorrectAnswers correct on $categoryName",
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
