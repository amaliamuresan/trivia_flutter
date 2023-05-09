class QuizCategory {
  const QuizCategory({
    required this.id,
    required this.name,
  });

  factory QuizCategory.fromMap(Map<String, dynamic> map) {
    return QuizCategory(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
  final int id;
  final String name;

  static List<QuizCategory> fromList(List<dynamic> list) {
    final categories = <QuizCategory>[];
    for (final dynamic element in list) {
      categories.add(QuizCategory.fromMap(element as Map<String, dynamic>));
    }
    return categories;
  }
}
