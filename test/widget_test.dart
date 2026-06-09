import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab6/main.dart';

void main() {
  testWidgets('MVC Multi-file smoke test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;
    
    await tester.pumpWidget(const ResponsiveMovieApp());
    await tester.pumpAndSettle();

    expect(find.text('Find a Movie'), findsOneWidget);
    expect(find.text('Invincible'), findsWidgets);
    expect(find.text('Arcane'), findsWidgets);
  });

  testWidgets('MVC Multi-file Search test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const ResponsiveMovieApp());

    await tester.enterText(find.byType(TextField), 'One Piece');
    await tester.pumpAndSettle();

    expect(find.text('One Piece'), findsAtLeastNWidgets(1));
    expect(find.text('Breaking Bad'), findsNothing);
  });

  testWidgets('MVC Multi-file Genre test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const ResponsiveMovieApp());

    await tester.tap(find.text('Anime'));
    await tester.pumpAndSettle();

    expect(find.text('Attack on Titan'), findsWidgets);
    expect(find.text('One Piece'), findsWidgets);
    expect(find.text('The Boys'), findsNothing);
  });
}
