import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gluon_test/components/widgets/gluon_text_form_field.dart';
import 'package:gluon_test/screens/logic_test_screen.dart';

void main() {
  group('test LogicTestScreen', () {
    testWidgets(
      'when initiated, should show correct widgets ',
      (tester) async {
        // Arrange
        await tester.pumpWidget(
          const MaterialApp(
            home: LogicTestScreen(),
          ),
        );

        // Assert
        expect(
          find.widgetWithText(AppBar, 'Converter app'),
          findsOneWidget,
        );
        expect(
          find.textContaining('Please enter an integer'),
          findsOneWidget,
        );
        expect(
          find.byType(GluonTextFormField),
          findsNWidgets(2),
        );
        expect(
          find.widgetWithText(ElevatedButton, 'Convert'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'when text field is submitted with empty value, should show error',
      (tester) async {
        // Arrange
        await tester.pumpWidget(
          const MaterialApp(
            home: LogicTestScreen(),
          ),
        );
        var outputField = tester.widget<GluonTextFormField>(
          find.byType(GluonTextFormField).at(1),
        );

        // Act
        await tester.tap(
          find.widgetWithText(ElevatedButton, 'Convert'),
        );
        await tester.pump();

        // Assert
        expect(find.text('Input cannot be empty'), findsOneWidget);
        expect(find.byIcon(Icons.info_rounded), findsOneWidget);
        expect(outputField.controller?.text, '');
      },
    );

    testWidgets(
      'when text field is submitted and has value, '
      'should show output and error won\'t be shown',
      (tester) async {
        // Arrange
        await tester.pumpWidget(
          const MaterialApp(
            home: LogicTestScreen(),
          ),
        );
        var outputField = tester.widget<GluonTextFormField>(
          find.byType(GluonTextFormField).at(1),
        );

        // Act
        await tester.enterText(
          find.byType(GluonTextFormField).at(0),
          '123',
        );
        await tester.tap(
          find.widgetWithText(ElevatedButton, 'Convert'),
        );
        await tester.pump();

        // Assert
        expect(find.text('Input cannot be empty'), findsNothing);
        expect(find.byIcon(Icons.info_rounded), findsNothing);
        expect(outputField.controller?.text, 'One hundred twenty-three.');
      },
    );
  });
}
