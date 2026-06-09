import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assignmen/main.dart';

void main() {
  testWidgets('Todo List Apple Design Smoke Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TodoApp());

    // Verify UI components
    expect(find.text('TODO MANAGER'), findsOneWidget);
    expect(find.text('No tasks yet'), findsOneWidget);

    // Add a task
    // The first TextField is Search, the second is Task input
    await tester.enterText(find.byType(TextField).at(1), 'Buy Milk');
    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();

    // Verify task added
    expect(find.text('Buy Milk'), findsOneWidget);
    expect(find.text('No tasks yet'), findsNothing);
    
    // Verify Statistics (Total: 1, Completed: 0, Remaining: 1)
    expect(find.text('1'), findsNWidgets(2)); // Total and Remaining
    expect(find.text('0'), findsOneWidget); // Completed
  });
}
