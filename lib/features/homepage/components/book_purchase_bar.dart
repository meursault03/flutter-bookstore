import 'package:flutter/material.dart';
import '../../shared/custom_buttons.dart';
import '../../shared/text_styles.dart';
import 'checkout_screen.dart';
import 'mock_data.dart';

class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final ValueNotifier<List<Book>> itens = ValueNotifier([]);

  void adicionarLivro(Book livro) {
    itens.value = [...itens.value, livro];
  }

  void removerUmLivro(int bookId) {
    final updated = List<Book>.from(itens.value);
    final index = updated.lastIndexWhere((b) => b.id == bookId);
    if (index != -1) updated.removeAt(index);
    itens.value = updated;
  }

  int get totalItens => itens.value.length;

  double get precoTotal =>
      itens.value.fold(0.0, (sum, book) => sum + book.price);
}

class BookPurchaseBar extends StatelessWidget {
  final Book livro;

  const BookPurchaseBar({super.key, required this.livro});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                StyleTextUnaligned(
                  'Preço Total  ',
                  12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
                StyleTextUnaligned(
                  'R\$ ${livro.price.toStringAsFixed(2)}',
                  18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 12),
            RoundButton(
              'Comprar Agora',
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (_) => CheckoutScreen(livro: livro),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            OutlinedRoundButton(
              'Adicionar ao Carrinho',
              onPressed: () {
                CartManager().adicionarLivro(livro);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item adicionado ao carrinho!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
