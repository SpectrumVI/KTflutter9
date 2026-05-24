import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9kt/src/core/di.dart';
import 'package:flutter_application_9kt/src/domain/entities/quote.dart';
import 'package:flutter_application_9kt/src/domain/usecases/get_random_quote_use_case.dart';

class HomeScreen extends ElementaryWidget<IHomeWidgetModel> {
  HomeScreen({super.key, required AppDependencies di})
      : super((context) => homeWidgetModelFactory(context, di));

  @override
  Widget build(IHomeWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clean Architecture + MVVM')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ValueListenableBuilder<QuoteState>(
            valueListenable: wm.quoteState,
            builder: (_, state, __) {
              if (state.isLoading) {
                return const CircularProgressIndicator();
              }

              if (state.phrase == null) {
                return const Text('Нажмите кнопку, чтобы получить кулинарную фразу');
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.phrase!.question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.phrase!.answer,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: wm.loadQuote,
        child: const Icon(Icons.restaurant_menu),
      ),
    );
  }
}

HomeWidgetModel homeWidgetModelFactory(BuildContext context, AppDependencies di) {
  return HomeWidgetModel(HomeModel(di.getRandomQuoteUseCase));
}

class HomeModel extends ElementaryModel {
  HomeModel(this._getRandomQuoteUseCase);

  final GetRandomQuoteUseCase _getRandomQuoteUseCase;

  Future<CookingPhrase> getRandomQuote() => _getRandomQuoteUseCase();
}

class QuoteState {
  const QuoteState({
    required this.isLoading,
    required this.phrase,
  });

  final bool isLoading;
  final CookingPhrase? phrase;

  factory QuoteState.initial() => const QuoteState(isLoading: false, phrase: null);

  QuoteState copyWith({bool? isLoading, CookingPhrase? phrase}) {
    return QuoteState(
      isLoading: isLoading ?? this.isLoading,
      phrase: phrase ?? this.phrase,
    );
  }
}

abstract interface class IHomeWidgetModel implements IWidgetModel {
  ValueListenable<QuoteState> get quoteState;

  Future<void> loadQuote();
}

class HomeWidgetModel extends WidgetModel<HomeScreen, HomeModel>
    implements IHomeWidgetModel {
  HomeWidgetModel(super.model);

  final ValueNotifier<QuoteState> _quoteState =
      ValueNotifier<QuoteState>(QuoteState.initial());

  @override
  ValueListenable<QuoteState> get quoteState => _quoteState;

  @override
  Future<void> loadQuote() async {
    _quoteState.value = _quoteState.value.copyWith(isLoading: true);
    final phrase = await model.getRandomQuote();
    _quoteState.value = QuoteState(isLoading: false, phrase: phrase);
  }
}
