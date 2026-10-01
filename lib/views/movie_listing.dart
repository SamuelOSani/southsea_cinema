import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

class _MovieListingState extends State<MovieListing> {
  int selectedTickets = 1;
  String bookingMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Text('Weapons (2025) (18)',
            style: TextStyle(
              color: cinemaFontWhite,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
            const SizedBox(height: 24),
            const Text(
                'When all but one child from the same class mysteriously vanish on the same night at exactly the same time, a community is left questioning who or what is behind their disappearance.',
                style: TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
            Row(children: [
              const Text('Sunday 4th October 2026, 21:00 - ends at 23:08',
              style: TextStyle(
                  color: cinemaFontMuted,
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 16),
              const Text('Age rating: 18',
              style: TextStyle(
                  color: cinemaFontMuted,
                  fontSize: 15,
                ),
              ),
            ]),
            const SizedBox(height: 32),
            const Text('Ticket(s)',
              style: TextStyle(
                color: cinemaFontWhite,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DropdownMenu<int>(
                initialSelection: selectedTickets,
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: 1, label: 'One ticket'),
                  DropdownMenuEntry(value: 2, label: 'Two tickets'),
                  DropdownMenuEntry(value: 3, label: 'Three tickets'),
                  DropdownMenuEntry(value: 4, label: 'Four tickets'),
                  DropdownMenuEntry(value: 5, label: 'Five tickets'),
                ],
                onSelected: (int? value) {
                  if (value != null) {
                    setState(() {
                      selectedTickets = value;
                    });
                  }
                }),
                const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: cinemaBrand,
                  foregroundColor: cinemaBackground,
                  padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    bookingMessage = '$selectedTickets ticket(s) added to order';
                  });
                },
                child: const Text('Add to order'),
              ),
              const SizedBox(height: 16),
              Text(bookingMessage,
              style: TextStyle(
                  color: cinemaBrandLight,
                  fontSize: 12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
