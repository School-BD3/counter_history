import 'package:flutter/material.dart';
import 'history_entry.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  final List<HistoryEntry> _history = [];

  

  void _incrementCounter() {
    setState(() {
      _counter++;
      _history.insert(
        0,
        HistoryEntry(
          action: 'Збільшення',
          value: _counter,
          timestamp: DateTime.now(),
        ),
      );

      if (_history.length > 10) {
        _history.removeLast();
      }
    });
  }

  void _decrementCounter() {
    if (_counter == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Лічильник не може бути від’ємним!'),
        ),
      );
      return;
    }

    setState(() {
      _counter--;
      _history.insert(
        0,
        HistoryEntry(
          action: 'Зменшення',
          value: _counter,
          timestamp: DateTime.now(),
        ),
      );

      if (_history.length > 10) {
        _history.removeLast();
      }
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _history.insert(
        0,
        HistoryEntry(
          action: 'Скидання',
          value: _counter,
          timestamp: DateTime.now(),
        ),
      );

      if (_history.length > 10) {
        _history.removeLast();
      }
    });
  }

  String _formatTimestamp(DateTime timestamp) {
    final date = timestamp.day.toString().padLeft(2, '0');
    final month = timestamp.month.toString().padLeft(2, '0');
    final year = timestamp.year.toString();
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final second = timestamp.second.toString().padLeft(2, '0');

    return '$date.$month.$year $hour:$minute:$second';
  }

  @override
  Widget build(BuildContext context) {
    final bool isDivisibleByTen = _counter != 0 && _counter % 10 == 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Лічильник із історією'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Text(
              'Поточне значення',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDivisibleByTen
                    ? Colors.green.shade100
                    : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDivisibleByTen ? Colors.green : Colors.blue,
                  width: 2,
                ),
              ),
              child: Text(
                '$_counter',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: isDivisibleByTen
                      ? Colors.green.shade900
                      : Colors.blue.shade900,
                ),
              ),
            ),
            if (isDivisibleByTen)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Число ділиться на 10!',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _incrementCounter,
                  icon: const Icon(Icons.add),
                  label: const Text('Збільшити'),
                ),
                ElevatedButton.icon(
                  onPressed: _decrementCounter,
                  icon: const Icon(Icons.remove),
                  label: const Text('Зменшити'),
                ),
                OutlinedButton.icon(
                  onPressed: _resetCounter,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Скинути'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Історія дій',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: _history.isEmpty
                  ? const Center(
                      child: Text('Історія поки порожня'),
                    )
                  : ListView.builder(
                      itemCount: _history.length,
                      itemBuilder: (context, index) {
                        final entry = _history[index];

                        return ListTile(
                          leading: CircleAvatar(
                            child: Text('${_history.length - index}'),
                          ),
                          title: Text(entry.action),
                          subtitle: Text(
                            _formatTimestamp(entry.timestamp),
                          ),
                          trailing: Text(
                            '${entry.value}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}