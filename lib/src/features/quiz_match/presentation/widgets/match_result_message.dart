import 'package:flutter/material.dart';

class MatchResultMessage extends StatelessWidget {
  const MatchResultMessage({
    super.key,
    required this.isWinner,
    required this.isDraw,
  });

  final bool isWinner;
  final bool isDraw;

  static const String winnerText = 'You won';
  static const String winnerSubtext = 'Keep it up!';

  static const String drawText = 'Draw';
  static const String drawSubtext = 'A very close one!';

  static const String loserText = 'You lost';
  static const String loserSubtext = 'Better luck next time!';

  @override
  Widget build(BuildContext context) {
    final title = isWinner
        ? winnerText
        : isDraw
            ? drawText
            : loserText;
    final subtitle = isWinner
        ? winnerSubtext
        : isDraw
            ? drawSubtext
            : loserSubtext;
    final color = isWinner
        ? Colors.green
        : isDraw
            ? Colors.yellow
            : Colors.red;

    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 20,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: color,
            // fontSize: 20,
          ),
        ),
      ],
    );
  }
}
