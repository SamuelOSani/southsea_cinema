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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('FAVOUR IS A CLOWN'),
            Text(
                'FAVOUR IS A CLOWN DESCRIBES A YOUNG GIRL FROM DOUALA WHO DOES NOT HAVE SENSE'),
            Row(children: [
              Text('Runtime: 90 mins'),
              Text('Age rating: 18'),
            ]),
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
                })
          ],
        ),
      ),
    );
  }
}
