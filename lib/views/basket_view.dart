import 'package:flutter/material.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  @override
  Widget build(BuildContext context) {
    final basket = BasketRepository.instance;
    final items = basket.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Basket'),
      ),
      drawer: const NavDrawer(),
      body: items.isEmpty
          ? const Center(
              child: Text('Your basket is empty.'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return Card(
                        color: cinemaSurface,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text(
                            item.movie.title,
                            style: const TextStyle(
                              color: cinemaFontWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${item.quantity} ticket(s) at ${item.movie.formattedPrice} each',
                            style: const TextStyle(
                              color: cinemaFontMuted,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '£${item.lineTotal.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: cinemaBrandLight,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 12),
                              IconButton(
                                tooltip: 'Remove ${item.movie.title}',
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: cinemaBrand,
                                ),
                                onPressed: () {
                                  setState(() {
                                    basket.removeMovie(item.movie.id);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Total: £${basket.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      PrimaryButton(
                        label: 'Checkout',
                        onPressed: () {
                          final total = basket.total;

                          setState(() {
                            basket.clear();
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Demo checkout complete: £${total.toStringAsFixed(2)}',
                              ),
                            ),
                          );
                        },
                      ),
                      PrimaryButton(
                        label: 'Clear Basket',
                        onPressed: () {
                          setState(() {
                            basket.clear();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
