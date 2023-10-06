import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gluon_test/components/widgets/gluon_text_form_field.dart';

void main() {
  group('test GluonTextFormField', () {
    testWidgets(
      'when initiated, should show correct widgets based on passed params',
      (tester) async {
        // Arrange
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: GluonTextFormField(
                enabled: true,
                maxLength: 20,
                maxLines: 2,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
          ),
        );
        var field = tester.widget<GluonTextFormField>(
          find.byType(GluonTextFormField),
        );

        // Assert
        expect(field.enabled, true);
        expect(field.maxLength, 20);
        expect(field.maxLines, 2);
        expect(field.keyboardType, TextInputType.number);
        expect(find.byType(FormField<String>), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
        expect(
          find.widgetWithIcon(GluonTextFormField, Icons.person),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'when validator is error, should show error tooltip',
      (tester) async {
        // Arrange
        var formKey = GlobalKey<FormState>();
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  formKey.currentState?.validate();
                },
              ),
              body: Form(
                key: formKey,
                child: GluonTextFormField(
                  validator: (value) =>
                      (value?.isEmpty ?? true) ? 'Field cannot be empty' : null,
                ),
              ),
            ),
          ),
        );

        // Act
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();

        // Assert
        expect(find.text('Field cannot be empty'), findsOneWidget);
      },
    );

    testWidgets(
      'when input decoration have hintText, '
      'hint text should be shown top of the TextFormField widget',
      (tester) async {
        // Arrange
        var formKey = GlobalKey<FormState>();
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  formKey.currentState?.validate();
                },
              ),
              body: GluonTextFormField(
                decoration: const InputDecoration(hintText: '123'),
              ),
            ),
          ),
        );


        // Assert
        expect(find.widgetWithText(Padding, '123'), findsOneWidget);
      },
    );
  });
}
