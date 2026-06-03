import 'package:flutter/material.dart';
import 'dart:math';

class ColorChangerLab extends StatefulWidget {
  const ColorChangerLab({super.key});

  @override
  State<ColorChangerLab> createState() => _ColorChangerLabState();
}

class _ColorChangerLabState extends State<ColorChangerLab> {
  Color _backgroundColor = Colors.white;
  String _colorName = 'White';

  void _updateColor(Color color, String name) {
    setState(() {
      _backgroundColor = color;
      _colorName = name;
    });
  }

  void _setRandomColor() {
    final random = Random();
    final color = Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
    _updateColor(color, 'Random (#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()})');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(title: const Text('Background Color Changer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white.withOpacity(0.7),
              child: Text(
                'Current Color: $_colorName',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _colorButton(Colors.red, 'Red'),
                const SizedBox(width: 10),
                _colorButton(Colors.green, 'Green'),
                const SizedBox(width: 10),
                _colorButton(Colors.blue, 'Blue'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _setRandomColor,
              child: const Text('Generate Random Color'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorButton(Color color, String name) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
      onPressed: () => _updateColor(color, name),
      child: Text(name),
    );
  }
}
