import 'package:flutter/material.dart';

class GroupListPage extends StatelessWidget {
  const GroupListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, dynamic>>> teams = {
      'Team A': [
        {'name': 'Klay Lewis', 'initials': 'KL', 'color': Colors.pinkAccent},
        {'name': 'Ehsan Woodard', 'initials': 'EW', 'color': Colors.purpleAccent},
        {'name': 'River Bains', 'initials': 'RB', 'color': Colors.blueGrey},
      ],
      'Team B': [
        {'name': 'Toyah Downs', 'initials': 'TD', 'color': Colors.redAccent},
        {'name': 'Tyla Kane', 'initials': 'TK', 'color': Colors.teal},
      ],
      'Team C': [
        {'name': 'Marcus Romero', 'initials': 'MR', 'color': Colors.orangeAccent},
        {'name': 'Farrah Parkes', 'initials': 'FP', 'color': Colors.deepPurpleAccent},
      ],
    };

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Group List View Demo',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: teams.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Text(
                  entry.key,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...entry.value.map((member) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: member['color'],
                      child: Text(
                        member['initials'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(member['name']),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
