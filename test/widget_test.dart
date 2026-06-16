import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:assignmen/main.dart';

void main() {
  testWidgets('Todo List Login and Home Smoke Test', (WidgetTester tester) async {
    // Build our app starting at login screen
    await tester.pumpWidget(const TodoApp(isLoggedIn: false));

    // Verify Login Screen
    expect(find.text('Login'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);

    // Enter credentials
    await tester.enterText(find.byType(TextFormField).at(0), 'testuser');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify transition to Home Screen
    expect(find.text('Hi, testuser'), findsOneWidget);
    expect(find.text('TODO MANAGER'), findsOneWidget);
  });
}
