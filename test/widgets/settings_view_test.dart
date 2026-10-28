import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  testWidgets('Customer can enter and save profile settings', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsView(),
      ),
    );

    // Verify that the form displays three input fields.
    expect(find.byType(TextField), findsNWidgets(3));

    // Enter customer information.
    await tester.enterText(
      find.widgetWithText(TextField, 'Full name'),
      '  Alex Smith  ',
    );

    await tester.enterText(
      find.widgetWithText(TextField, 'Email address'),
      'alex@example.com',
    );

    await tester.enterText(
      find.widgetWithText(TextField, 'Phone number'),
      '07123456789',
    );

    // Verify that the newsletter switch starts off.
    expect(
      tester.widget<Switch>(find.byType(Switch)).value,
      isFalse,
    );

    // Turn the newsletter preference on.
    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(
      tester.widget<Switch>(find.byType(Switch)).value,
      isTrue,
    );

    // Save the customer settings.
    await tester.ensureVisible(find.text('Save Settings'));
    await tester.tap(find.text('Save Settings'));
    await tester.pump();

    // Verify the confirmation message and trimmed name.
    expect(
      find.text('Settings saved for Alex Smith'),
      findsOneWidget,
    );
  });
}