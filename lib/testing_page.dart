import 'package:flutter/material.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {'title': 'LidTerm', 'subtitle': '3'},
      {'title': 'CraftRock', 'subtitle': '4'},
      {'title': 'BootClay', 'subtitle': '5'},
      {'title': 'CheckSuit', 'subtitle': '6'},
      {'title': 'TeamSake', 'subtitle': '7'},
      {'title': 'NewLaugh', 'subtitle': '8'},
      {'title': 'BlueCop', 'subtitle': '9'},
      {'title': 'WildTent', 'subtitle': '10'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Getting Started Testing',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.list, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: ListTile(
              title: Text(
                items[index]['title']!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(items[index]['subtitle']!),
              trailing: IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
