import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gluon_test/components/widgets/gluon_text_form_field.dart';
import 'package:gluon_test/main.dart' as app;
import 'package:gluon_test/screens/logic_test_screen.dart';
import 'package:gluon_test/screens/widget_test_screen.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
      'open WidgetTestScreen, verify validator',
      (tester) async {
        // Run App
        app.main();
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 1));

        // Open Widget Test Screen
        await tester.tap(find.widgetWithText(ElevatedButton, 'Widget Test'));
        await tester.pumpAndSettle();
        expect(find.byType(WidgetTestScreen), findsOneWidget);
        await Future.delayed(const Duration(seconds: 1));

        // Submit field when has value
        await tester.enterText(find.byType(GluonTextFormField), '123');
        await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
        await tester.pump();
        expect(find.text('Username cannot be empty'), findsNothing);
        expect(find.byIcon(Icons.info_rounded), findsNothing);
        expect(
          find.widgetWithText(SnackBar, 'Success set name: 123'),
          findsOneWidget,
        );
        await Future.delayed(const Duration(seconds: 1));

        // Submit field when empty
        await tester.enterText(find.byType(GluonTextFormField), '');
        await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
        await tester.pump();
        expect(find.text('Username cannot be empty'), findsOneWidget);
        expect(find.byIcon(Icons.info_rounded), findsOneWidget);
        await Future.delayed(const Duration(seconds: 1));

        // When info icon is tapped, tooltip should be hidden
        await tester.tap(find.byIcon(Icons.info_rounded));
        await tester.pump();
        expect(
          find.text('Username cannot be empty').hitTestable(),
          findsNothing,
        );
        await Future.delayed(const Duration(seconds: 1));
      },
    );

    testWidgets(
      'open LogicTestScreen, verify converter',
      (tester) async {
        // Run App
        app.main();
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 1));

        // Open Widget Test Screen
        await tester.tap(find.widgetWithText(ElevatedButton, 'Logic Test'));
        await tester.pumpAndSettle();
        expect(find.byType(LogicTestScreen), findsOneWidget);
        await Future.delayed(const Duration(seconds: 1));

        // Submit field
        await tester.enterText(find.byType(GluonTextFormField).at(0), '123');
        await tester.tap(find.widgetWithText(ElevatedButton, 'Convert'));
        await tester.pump();
        expect(find.text('Input cannot be empty'), findsNothing);
        expect(find.byIcon(Icons.info_rounded), findsNothing);
        expect(
          tester
              .widget<GluonTextFormField>(
                find.byType(GluonTextFormField).at(1),
              )
              .controller
              ?.text,
          'One hundred twenty-three.',
        );
        await Future.delayed(const Duration(seconds: 1));
      },
    );
  });
}
