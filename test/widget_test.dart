import 'package:flutter_test/flutter_test.dart';
import 'package:counter_history/main.dart';

void main() {
  testWidgets('Counter history app starts successfully', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CounterHistoryApp());

    expect(find.text('Лічильник із історією'), findsOneWidget);
    expect(find.text('Поточне значення'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Історія поки порожня'), findsOneWidget);
  });
}