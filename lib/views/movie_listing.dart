import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieListing extends StatefulWidget {
  final Movie movie;

  const MovieListing({
    super.key,
    required this.movie,
  });

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 600;
          final movieInfo = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.movie.title} (${widget.movie.ageRating})',
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Image.asset(widget.movie.posterPath,
                  width: 120, height: 180, fit: BoxFit.cover),
              const SizedBox(height: 24),
              Text(
                widget.movie.description,
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.movie.showtime,
                style: const TextStyle(
                  color: cinemaFontMuted,
                  fontSize: 15,
                ),
              ),
            ],
          );
          final ticketControls = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ticket(s) (£${widget.movie.ticketPrice.toStringAsFixed(2)} each)',
                style: const TextStyle(
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
                    bookingMessage =
                        '$selectedTickets ticket(s) added to order';
                  });
                },
                child: const Text('Add to order'),
              ),
              const SizedBox(height: 16),
              Text(
                bookingMessage,
                style: TextStyle(
                  color: cinemaBrandLight,
                  fontSize: 12,
                ),
              ),
            ],
          );

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: movieInfo),
                        const SizedBox(width: 32),
                        ticketControls,
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        movieInfo,
                        const SizedBox(height: 32),
                        ticketControls,
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
