import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trivia_app/src/extensions/string_extensions.dart';
import 'package:trivia_app/src/features/quiz_menu/domain/quiz_question.dart';
import 'package:trivia_app/src/style/style.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget(
      {super.key, required this.question, required this.onAnswerChosen});

  final QuizQuestion question;
  final void Function(String?) onAnswerChosen;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  static const int questionTimeSeconds = 15;
  String? chosenAnswer;
  late List<String> answers;
  int remainingTimeSeconds = questionTimeSeconds;
  bool showCorrectAnswer = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    initializeAnswers();
    startTimer();
  }

  @override
  void didUpdateWidget(covariant QuestionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      initializeAnswers();
      chosenAnswer = null;
      showCorrectAnswer = false;
      startTimer();
    }
  }

  void initializeAnswers() {
    answers = List<String>.from(widget.question.incorrectAnswers)
      ..add(widget.question.correctAnswer)
      ..shuffle();
    chosenAnswer = null;
  }

  void startTimer() {
    timer?.cancel();
    remainingTimeSeconds = questionTimeSeconds;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (remainingTimeSeconds == 0) {
        timer.cancel();
        setState(() => showCorrectAnswer = true);
        await Future.delayed(const Duration(milliseconds: 1000));
        widget.onAnswerChosen(null);
      } else {
        setState(() => remainingTimeSeconds--);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final progressBarWidth = MediaQuery.of(context).size.width / 1.1;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: AppMargins.regularMargin),
        Stack(
          children: [
            Container(
              height: 8,
              width: progressBarWidth,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Container(
              height: 8,
              width:
                  remainingTimeSeconds * progressBarWidth / questionTimeSeconds,
              decoration: BoxDecoration(
                color: AppColors.accentColor,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppMargins.bigMargin),
        Text(
          widget.question.question.convertFromHtmlText(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppMargins.bigMargin),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ElevatedButton(
                onPressed: () async {
                  setState(() => chosenAnswer = answers[index]);
                  await Future.delayed(const Duration(milliseconds: 1000));
                  widget.onAnswerChosen(answers[index]);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: getAnswerButtonColor(answers[index]),
                ),
                child: Text(answers[index].convertFromHtmlText()),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: AppMargins.regularMargin);
            },
            itemCount: answers.length,
          ),
        )
      ],
    );
  }

  Color getAnswerButtonColor(String answer) {
    if (chosenAnswer == null) {
      if (answer == widget.question.correctAnswer &&
          showCorrectAnswer == true) {
        return Colors.green;
      }
      return AppColors.surface;
    } else if (answer == widget.question.correctAnswer) {
      return Colors.green;
    } else if (answer == chosenAnswer &&
        answer != widget.question.correctAnswer) {
      return Colors.red;
    }
    return AppColors.surface;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
