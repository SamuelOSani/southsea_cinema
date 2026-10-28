import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

void main() {
  group('PrimaryButton widget tests', () {
    testWidgets('PrimaryButton displays its label',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              label: 'Book Now',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Book Now'), findsOneWidget);
    });

    testWidgets('PrimaryButton calls onPressed when tapped',
        (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PrimaryButton(
              label: 'Book Now',
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Book Now'));
      await tester.pump();

      expect(wasPressed, isTrue);
        });
  });
}
