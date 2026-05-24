import 'package:flutter_application_9kt/src/domain/entities/quote.dart';
import 'package:flutter_application_9kt/src/domain/repositories/quote_repository.dart';

class GetRandomQuoteUseCase {
  GetRandomQuoteUseCase(this._quoteRepository);

  final QuoteRepository _quoteRepository;

  Future<CookingPhrase> call() {
    return _quoteRepository.getRandomPhrase();
  }
}
