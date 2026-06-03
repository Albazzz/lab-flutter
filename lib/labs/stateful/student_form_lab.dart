import 'package:flutter/material.dart';

class StudentFormLab extends StatefulWidget {
  const StudentFormLab({super.key});

  @override
  State<StudentFormLab> createState() => _StudentFormLabState();
}

class _StudentFormLabState extends State<StudentFormLab> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _classController = TextEditingController();
  String _infoSummary = "";

  void _showInfo() {
    setState(() {
      _infoSummary = "Full Name: ${_nameController.text}\n"
          "Student ID: ${_idController.text}\n"
          "Class: ${_classController.text}";
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _classController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Information Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _idController,
              decoration: const InputDecoration(labelText: 'Student ID', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _classController,
              decoration: const InputDecoration(labelText: 'Class', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _showInfo,
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              child: const Text('Show Information', style: TextStyle(fontSize: 18)),
            ),
            if (_infoSummary.isNotEmpty) ...[
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _infoSummary,
                  style: const TextStyle(fontSize: 18, height: 1.5),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
