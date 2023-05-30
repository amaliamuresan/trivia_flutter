import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:trivia_app/src/features/authentication/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:trivia_app/src/features/profile/presentation/widgets/avatar_widget.dart';
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
          if (isWinner) Lottie.asset('assets/animations/confetti.json'),
          AvatarWidget(
            photoUrl: context.read<AuthBloc>().state.publicUserData.photoUrl,
          ),
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
