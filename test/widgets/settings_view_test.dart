import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  testWidgets('Customer can enter and save profile settings', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsView(),
      ),
    );

    await tester.pumpAndSettle();

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
    await tester.pumpAndSettle();

    // Verify the confirmation message and trimmed name.
    expect(
      find.text('Settings saved for Alex Smith'),
      findsOneWidget,
    );

    // Check actual saved values, not just the on-screen confirmation.
    final SharedPreferencesAsync prefs = SharedPreferencesAsync();
    expect(await prefs.getString(prefName), 'Alex Smith');
    expect(await prefs.getString(prefEmail), 'alex@example.com');
    expect(await prefs.getString(prefPhone), '07123456789');
    expect(await prefs.getBool(prefNewsletter), isTrue);

    // Recreate the screen to prove it reads the stored profile.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

    expect(find.text('Alex Smith'), findsOneWidget);
    expect(find.text('alex@example.com'), findsOneWidget);
    expect(find.text('07123456789'), findsOneWidget);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
  });

  testWidgets('Saved profile is pre-filled when Settings opens',
      (tester) async {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.withData(<String, Object>{
      prefName: 'Jamie Morgan',
      prefEmail: 'jamie@example.com',
      prefPhone: '07000000000',
      prefNewsletter: true,
    });

    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

    expect(find.text('Jamie Morgan'), findsOneWidget);
    expect(find.text('jamie@example.com'), findsOneWidget);
    expect(find.text('07000000000'), findsOneWidget);
    expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
  });

  testWidgets('New profile starts with empty text and news off',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SettingsView()));
    await tester.pumpAndSettle();

    for (final TextField field in tester.widgetList<TextField>(
      find.byType(TextField),
    )) {
      expect(field.controller?.text, isEmpty);
    }
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
  });
}