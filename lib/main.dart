import 'package:flutter/material.dart';
import 'labs/stateless/profile_card_lab.dart';
import 'labs/stateless/business_card_lab.dart';
import 'labs/stateless/product_display_lab.dart';
import 'labs/stateful/enhanced_counter_lab.dart';
import 'labs/stateful/color_changer_lab.dart';
import 'labs/stateful/student_form_lab.dart';
import 'labs/stateful/coffee_shop_lab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Labs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainMenu(),
    );
  }
}

// --- Main Menu ---
class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Labs Menu'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader('StatelessWidget Labs'),
          _buildLabTile(context, '1. Personal Profile Card', const ProfileCardLab()),
          _buildLabTile(context, '2. Business Card App', const BusinessCardLab()),
          _buildLabTile(context, '3. Simple Product Display', const ProductDisplayLab()),
          const SizedBox(height: 20),
          _buildSectionHeader('StatefulWidget Labs'),
          _buildLabTile(context, '1. Enhanced Counter App', const EnhancedCounterLab()),
          _buildLabTile(context, '2. Background Color Changer', const ColorChangerLab()),
          _buildLabTile(context, '3. Student Information Form', const StudentFormLab()),
          _buildLabTile(context, '4. Coffee Shop Ordering App', const CoffeeShopLab()),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey),
      ),
    );
  }

  Widget _buildLabTile(BuildContext context, String title, Widget labPage) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => labPage)),
      ),
    );
  }
}
