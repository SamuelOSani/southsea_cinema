import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatelessWidget {
  const MovieListing({super.key});

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
            Text('FAVOUR IS A CLOWN DESCRIBES A YOUNG GIRL FROM DOUALA WHO DOES NOT HAVE SENSE'),
            Row(
              children: [
                Text('Runtime: 90 mins'),
                Text('Age rating: 18'),
              ]
            )
          ],
        ),
      ),
    );
  }
}