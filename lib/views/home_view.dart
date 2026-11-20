import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class HomeView extends StatefulWidget {
  // The optional path also allows widget tests to check the error state.
  const HomeView({
    super.key,
    this.assetPath = 'assets/data/movies.json',
  });

  final String assetPath;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Movie> _movies = [];
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    try {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = await repository.loadMoviesFromAsset(
        assetPath: widget.assetPath,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _movies = movies;
        _loading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorMessage = 'Could not load movies: $error';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget body;

    if (_loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_errorMessage.isNotEmpty) {
      body = Center(child: Text(_errorMessage));
    } else {
      body = ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _movies.length,
        itemBuilder: (BuildContext context, int index) {
          return MovieCard(movie: _movies[index]);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text(appTitle)),
      drawer: const NavDrawer(),
      body: body,
    );
  }
}
