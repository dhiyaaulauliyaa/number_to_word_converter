import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gluon_test/components/widgets/gluon_text_form_field.dart';
import 'package:gluon_test/screens/widget_test_screen.dart';

void main() {
  group('test WidgetTestScreen', () {
    testWidgets(
      'when initiated, should show correct widgets ',
      (tester) async {
        // Arrange
        await tester.pumpWidget(
           const MaterialApp(
            home: WidgetTestScreen(),
          ),
        );

        // Assert
        expect(
          find.widgetWithText(AppBar, 'Converter App'),
          findsOneWidget,
        );
        expect(
          find.byType(GluonTextFormField),
          findsOneWidget,
        );
        expect(
          find.widgetWithText(ElevatedButton, 'Submit'),
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
            home: WidgetTestScreen(),
          ),
        );

        // Act
        await tester.tap(
          find.widgetWithText(ElevatedButton, 'Submit'),
        );
        await tester.pump();

        // Assert
        expect(find.text('Username cannot be empty'), findsOneWidget);
        expect(find.byIcon(Icons.info_rounded), findsOneWidget);
      },
    );

    testWidgets(
      'when text field is submitted and has value, '
      'should show success snackbar and error won\'t be shown ',
      (tester) async {
        // Arrange
        await tester.pumpWidget(
           const MaterialApp(
            home: WidgetTestScreen(),
          ),
        );

        // Act
        await tester.enterText(
          find.byType(GluonTextFormField),
          '123',
        );
        await tester.tap(
          find.widgetWithText(ElevatedButton, 'Submit'),
        );
        await tester.pump();

        // Assert
        expect(find.text('Username cannot be empty'), findsNothing);
        expect(find.byIcon(Icons.info_rounded), findsNothing);
        expect(
          find.widgetWithText(SnackBar, 'Success set name: 123'),
          findsOneWidget,
        );
      },
    );
  });
}
