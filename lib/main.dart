import 'package:flutter/material.dart';
import 'counter_page.dart';

void main() {
  runApp(const CounterHistoryApp());
}

class CounterHistoryApp extends StatelessWidget {
  const CounterHistoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лічильник із історією',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}