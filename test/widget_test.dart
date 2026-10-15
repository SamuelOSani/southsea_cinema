import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/constants.dart';

void main() {
  group('Southsea Cinema widget tests', () {
    testWidgets('App opens the HomeView', (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.byType(HomeView), findsOneWidget);
      expect(find.text(appTitle), findsOneWidget);
    });

    testWidgets('HomeView displays movie and booking buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.text('Weapons (2025)'), findsOneWidget);
      expect(find.text('Digger (2026)'), findsOneWidget);
      expect(find.text('Book Now'), findsNWidgets(2));
    });
  });
}
