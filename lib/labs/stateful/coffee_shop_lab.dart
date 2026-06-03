import 'package:flutter/material.dart';

class CoffeeShopLab extends StatefulWidget {
  const CoffeeShopLab({super.key});

  @override
  State<CoffeeShopLab> createState() => _CoffeeShopLabState();
}

class _CoffeeShopLabState extends State<CoffeeShopLab> {
  final List<Map<String, dynamic>> _items = [
    {'name': 'Coffee', 'price': 2.0, 'quantity': 0},
    {'name': 'Milk Tea', 'price': 3.5, 'quantity': 0},
    {'name': 'Cake', 'price': 2.5, 'quantity': 0},
  ];

  double get _totalPrice {
    double total = 0;
    for (var item in _items) {
      total += (item['price'] as double) * (item['quantity'] as int);
    }
    return total;
  }

  void _updateQuantity(int index, bool increment) {
    setState(() {
      if (increment) {
        _items[index]['quantity']++;
      } else {
        if (_items[index]['quantity'] > 0) {
          _items[index]['quantity']--;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coffee Shop')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(item['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text('\$${item['price'].toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => _updateQuantity(index, false),
                        ),
                        Text('${item['quantity']}', style: const TextStyle(fontSize: 18)),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => _updateQuantity(index, true),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, -5))],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Price:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text(
                  '\$${_totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
