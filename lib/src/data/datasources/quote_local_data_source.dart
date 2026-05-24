import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

class QuoteLocalDataSource {
  Future<Map<String, String>> fetchRandomPhrase() async {
    final jsonText = await rootBundle.loadString('assets/data/cooking_phrases.json');
    final jsonMap = jsonDecode(jsonText) as Map<String, dynamic>;
    final rawList = (jsonMap['phrases'] as List<dynamic>)
        .cast<Map<String, dynamic>>();

    final index = Random().nextInt(rawList.length);
    final item = rawList[index];

    return {
      'question': item['question']?.toString() ?? 'Как приготовить блюдо?',
      'answer': item['answer']?.toString() ?? 'Попробуйте простой рецепт из базовых ингредиентов.',
    };
  }
}
