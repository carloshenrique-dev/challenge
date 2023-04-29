import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:challenge/modules/entity/widgets/error_entity_widget.dart';

void main() {
  group('ErrorEntityWidget', () {
    const message = 'Error message';
    onButtonPressed() => debugPrint('Button pressed');

    testWidgets('should display the message', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ErrorEntityWidget(
            message: message,
            onButtonPressed: onButtonPressed,
          ),
        ),
      );

      expect(find.text(message), findsOneWidget);
    });

    testWidgets(
        'should call the onButtonPressed callback when the button is pressed',
        (tester) async {
      var callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: ErrorEntityWidget(
            message: message,
            onButtonPressed: () {
              callbackCalled = true;
            },
          ),
        ),
      );

      await tester.tap(find.byType(TextButton));
      expect(callbackCalled, isTrue);
    });
  });
}
