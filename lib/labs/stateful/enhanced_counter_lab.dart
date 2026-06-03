import 'package:flutter/material.dart';

class EnhancedCounterLab extends StatefulWidget {
  const EnhancedCounterLab({super.key});

  @override
  State<EnhancedCounterLab> createState() => _EnhancedCounterLabState();
}

class _EnhancedCounterLabState extends State<EnhancedCounterLab> {
  int _counter = 0;

  void _increment() => setState(() => _counter++);
  void _decrement() => setState(() => _counter--);
  void _reset() => setState(() => _counter = 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enhanced Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Current Value:', style: TextStyle(fontSize: 20)),
            Text(
              '$_counter',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: _counter > 10 ? Colors.red : Colors.blue,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _decrement, child: const Icon(Icons.remove)),
                const SizedBox(width: 20),
                ElevatedButton(onPressed: _increment, child: const Icon(Icons.add)),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _reset,
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: const Text('Reset', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
