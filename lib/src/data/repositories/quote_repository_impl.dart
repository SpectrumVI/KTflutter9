import 'package:flutter_application_9kt/src/data/datasources/quote_local_data_source.dart';
import 'package:flutter_application_9kt/src/domain/entities/quote.dart';
import 'package:flutter_application_9kt/src/domain/repositories/quote_repository.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  QuoteRepositoryImpl(this._localDataSource);

  final QuoteLocalDataSource _localDataSource;

  @override
  Future<CookingPhrase> getRandomPhrase() async {
    final raw = await _localDataSource.fetchRandomPhrase();
    return CookingPhrase(
      question: raw['question'] ?? '',
      answer: raw['answer'] ?? '',
    );
  }
}
