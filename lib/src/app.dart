import 'package:flutter/material.dart';
import 'package:flutter_application_9kt/src/core/di.dart';
import 'package:flutter_application_9kt/src/presentation/home/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final di = AppDependencies.create();

    return MaterialApp(
      title: 'Elementary Clean App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomeScreen(di: di),
    );
  }
}
