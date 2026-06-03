import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assignmen/main.dart';

void main() {
  testWidgets('Todo List UX Improvements Test', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());
    expect(find.text('Chưa có công việc nào'), findsOneWidget);
    expect(find.byIcon(Icons.assignment_outlined), findsOneWidget);
    expect(find.text('Title:'), findsOneWidget);
    expect(find.text('Content:'), findsOneWidget);
    expect(find.text('Date:'), findsOneWidget);
    expect(find.text('Type:'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(0), 'Test Task');
    await tester.enterText(find.byType(TextFormField).at(1), 'Test Content');
    await tester.tap(find.byType(TextFormField).at(2));
    await tester.pumpAndSettle();
    expect(find.byType(DatePickerDialog), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(tester.widget<TextFormField>(find.byType(TextFormField).at(2)).controller!.text, isNotEmpty);
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Khó').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('ADD'));
    await tester.pumpAndSettle();
    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('Chưa có công việc nào'), findsNothing);
    await tester.tap(find.byIcon(Icons.cancel));
    await tester.pumpAndSettle();
    expect(find.text('Xác nhận xóa'), findsOneWidget);
    await tester.tap(find.text('Hủy'));
    await tester.pumpAndSettle();
    expect(find.text('Test Task'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.cancel));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Xóa'));
    await tester.pumpAndSettle();
    expect(find.text('Test Task'), findsNothing);
    expect(find.text('Chưa có công việc nào'), findsOneWidget);
  });
}
