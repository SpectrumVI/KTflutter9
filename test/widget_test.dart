import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_9kt/src/app.dart';

void main() {
  testWidgets('App starts and shows title', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('Clean Architecture + MVVM'), findsOneWidget);
  });
}
