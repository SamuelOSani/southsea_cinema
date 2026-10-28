import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';

class BasketRepository {
  BasketRepository._internal();

  static final BasketRepository instance = BasketRepository._internal();

  final List<BasketItem> _items = [];

  List<BasketItem> get items => List.unmodifiable(_items);

  void addTickets(Movie movie, int quantity) {
    if (quantity <= 0) {
      throw ArgumentError('Quantity must be greater than zero');
    }

    final index = _items.indexWhere((item) => item.movie.id == movie.id);

    if (index == -1) {
      _items.add(BasketItem(movie: movie, quantity: quantity));
    } else {
      final existingItem = _items[index];

      _items[index] = BasketItem(
        movie: movie,
        quantity: existingItem.quantity + quantity,
      );
    }
  }

  void removeMovie(String movieId) {
    _items.removeWhere((item) => item.movie.id == movieId);
  }

  double get total {
    double sum = 0;

    for (final item in _items) {
      sum += item.lineTotal;
    }

    return sum;
  }

  void clear() {
    _items.clear();
  }
}
