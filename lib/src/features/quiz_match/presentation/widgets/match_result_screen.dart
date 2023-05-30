import 'package:flutter/material.dart';
import 'package:trivia_app/src/features/quiz_match/presentation/widgets/match_result_message.dart';

class MatchResultScreen extends StatelessWidget {
  const MatchResultScreen({
    super.key,
    required this.playerCorrectQuestions,
    required this.opponentCorrectQuestions,
    required this.playerName,
    required this.opponentName,
    required this.onExitTap,
  });

  final int playerCorrectQuestions;
  final int opponentCorrectQuestions;

  final String playerName;
  final String opponentName;

  final VoidCallback onExitTap;

  @override
  Widget build(BuildContext context) {
    final isWinner = playerCorrectQuestions > opponentCorrectQuestions;
    final isDraw = playerCorrectQuestions == opponentCorrectQuestions;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MatchResultMessage(
            isWinner: isWinner,
            isDraw: isDraw,
          ),
          const SizedBox(height: 8),
          Text('$playerCorrectQuestions  -  $opponentCorrectQuestions'),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: onExitTap, child: const Text('Exit')),
        ],
      ),
    );
  }
}
