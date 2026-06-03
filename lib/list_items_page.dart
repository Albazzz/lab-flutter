import 'package:flutter/material.dart';

class ListItemsPage extends StatelessWidget {
  const ListItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: List.generate(10, (index) {
              return Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Item ${index + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
