import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

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

    testWidgets('Book Now opens the correct movie listing',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      await tester.tap(find.text('Book Now').first);
      await tester.pumpAndSettle();

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('Weapons (2025) (18)'), findsOneWidget);
      await tester.tap(find.text('Add to order'));
      await tester.pump();

      expect(find.text('1 ticket(s) added to order'), findsOneWidget);
    });
  });
}
