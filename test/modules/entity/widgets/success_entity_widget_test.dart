import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:challenge/modules/entity/widgets/success_entity_widget.dart';

void main() {
  testWidgets('SuccessEntityWidget displays success message',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SuccessEntityWidget(),
      ),
    );

    final successMessageFinder =
        find.text('Success creating your new house rules');
    expect(successMessageFinder, findsOneWidget);
  });

  testWidgets('SuccessEntityWidget displays redirect message',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SuccessEntityWidget(),
      ),
    );

    final redirectMessageFinder = find.text('Redirecting...');
    expect(redirectMessageFinder, findsOneWidget);
  });
}
