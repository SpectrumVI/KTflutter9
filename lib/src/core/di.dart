import 'package:flutter_application_9kt/src/data/datasources/quote_local_data_source.dart';
import 'package:flutter_application_9kt/src/data/repositories/quote_repository_impl.dart';
import 'package:flutter_application_9kt/src/domain/repositories/quote_repository.dart';
import 'package:flutter_application_9kt/src/domain/usecases/get_random_quote_use_case.dart';

class AppDependencies {
  factory AppDependencies.create() {
    final localDataSource = QuoteLocalDataSource();
    final repository = QuoteRepositoryImpl(localDataSource);
    final useCase = GetRandomQuoteUseCase(repository);

    return AppDependencies._(
      quoteLocalDataSource: localDataSource,
      quoteRepository: repository,
      getRandomQuoteUseCase: useCase,
    );
  }

  AppDependencies._({
    required QuoteLocalDataSource quoteLocalDataSource,
    required QuoteRepository quoteRepository,
    required GetRandomQuoteUseCase getRandomQuoteUseCase,
  })  : _quoteLocalDataSource = quoteLocalDataSource,
        _quoteRepository = quoteRepository,
        _getRandomQuoteUseCase = getRandomQuoteUseCase;

  final QuoteLocalDataSource _quoteLocalDataSource;
  final QuoteRepository _quoteRepository;
  final GetRandomQuoteUseCase _getRandomQuoteUseCase;

  GetRandomQuoteUseCase get getRandomQuoteUseCase => _getRandomQuoteUseCase;
  QuoteRepository get quoteRepository => _quoteRepository;
  QuoteLocalDataSource get quoteLocalDataSource => _quoteLocalDataSource;
}
