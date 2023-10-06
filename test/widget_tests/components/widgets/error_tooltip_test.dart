import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gluon_test/components/widgets/error_tooltip.dart';

void main() {
  group('test ErrorTooltip', () {
    testWidgets(
      'when initiated, should show correct widgets ',
      (tester) async {
        // Arrange
        await tester.pumpWidget(
          const MaterialApp(
            home: ErrorTooltip(text: 'Test'),
          ),
        );

        // Assert

        expect(
          find.text('Test'),
          findsOneWidget,
        );
      },
    );
  });
}
