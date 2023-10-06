import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gluon_test/main.dart';

void main() {
  group('test MyApp', () {
    testWidgets(
      'when initiated, should show correct widgets ',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          const MyApp(),
        );

        var materialApp = tester.widget<MaterialApp>(
          find.byType(MaterialApp),
        );

        // Act
        await tester.pumpAndSettle();

        // Assert
        expect(materialApp.title, 'Flutter Demo');
        expect(materialApp.home.runtimeType, MyHomePage);
        expect(materialApp.theme?.colorScheme.error, Colors.red.shade900);
        expect(
          materialApp.theme?.inputDecorationTheme.prefixIconColor,
          Colors.grey,
        );
      },
    );
  });
  group('test MyHomePage', () {
    testWidgets(
      'when initiated, should show correct widgets ',
      (WidgetTester tester) async {
        // Arrange
        await tester.pumpWidget(
          const MaterialApp(
            home: MyHomePage(),
          ),
        );

        // Assert
        expect(
          find.widgetWithText(AppBar, 'Gluon Test'),
          findsOneWidget,
        );
        expect(
          find.widgetWithText(ElevatedButton, 'Widget Test'),
          findsOneWidget,
        );
        expect(
          find.widgetWithText(ElevatedButton, 'Logic Test'),
          findsOneWidget,
        );
      },
    );
  });
}
