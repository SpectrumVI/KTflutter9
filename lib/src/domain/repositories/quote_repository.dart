import 'package:flutter_application_9kt/src/domain/entities/quote.dart';

abstract class QuoteRepository {
  Future<CookingPhrase> getRandomPhrase();
}
