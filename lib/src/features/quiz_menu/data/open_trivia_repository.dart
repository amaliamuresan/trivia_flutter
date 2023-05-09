import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:trivia_app/src/features/quiz_menu/domain/quiz_category.dart';
import 'package:trivia_app/src/features/quiz_menu/domain/quiz_question.dart';

class OpenTriviaRepository {
  factory OpenTriviaRepository() => _singleton;

  OpenTriviaRepository._internal() : super();
  static final OpenTriviaRepository _singleton = OpenTriviaRepository._internal();

  final _baseUrl = 'opentdb.com';

  Future<List<QuizCategory>> getCategories() async {
    final uri = Uri.https(_baseUrl, '/api_category.php');
    final response = await http.get(uri, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    print(body);
    return QuizCategory.fromList(body['trivia_categories'] as List);
  }

  Future<List<QuizQuestion>> getQuestions({
    String? categoryId,
    int amount = 10,

    /// multiple or boolean
    String type = 'multiple',

    /// easy, medium, hard or none
    String? difficulty,
  }) async {
    final queryParameters = <String, dynamic>{
      'amount': amount.toString(),
      'category': categoryId,
      'difficulty': difficulty,
      'type': type,
    }..removeWhere((key, value) => value == null);
    final uri = Uri.https(_baseUrl, '/api.php', queryParameters);

    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    print(body);
    return QuizQuestion.fromList(body['results'] as List);
  }
}
