import 'package:flutter/material.dart';
import '../../shared/app_colors.dart';
import '../../shared/custom_buttons.dart';
import '../../shared/responsive_center.dart';
import '../../shared/text_styles.dart';
import 'book_purchase_bar.dart';
import 'checkout_screen.dart';
import 'mock_data.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  List<({Book book, int qty})> _grouped(List<Book> itens) {
    final Map<int, ({Book book, int qty})> map = {};
    for (final book in itens) {
      final current = map[book.id];
      map[book.id] = current == null
          ? (book: book, qty: 1)
          : (book: book, qty: current.qty + 1);
    }
    return map.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        centerTitle: true,
        title: StyleTextUnaligned(
          'Carrinho',
          18,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
      ),
      body: ValueListenableBuilder<List<Book>>(
        valueListenable: CartManager().itens,
        builder: (context, itens, _) {
          if (itens.isEmpty) return _buildEmptyState(context);
          return _buildCartContent(context, itens);
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final colors = AppColors.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: colors.surfaceLight),
          const SizedBox(height: 16),
          StyleTextUnaligned(
            'Seu carrinho está vazio',
            18,
            fontWeight: FontWeight.w600,
            color: colors.textSecondary,
          ),
          const SizedBox(height: 8),
          StyleTextUnaligned(
            'Adicione livros para vê-los aqui',
            14,
            fontWeight: FontWeight.w400,
            color: colors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, List<Book> itens) {
    final cart = CartManager();
    final grouped = _grouped(itens);

    return ResponsiveCenter(
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppColors.paddingPage),
              itemCount: grouped.length,
              separatorBuilder: (context, _) {
                final colors = AppColors.of(context);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(height: 1, color: colors.divider),
                );
              },
              itemBuilder: (context, index) {
                final item = grouped[index];
                return _CartItemRow(
                  book: item.book,
                  quantity: item.qty,
                  onAdd: () => cart.adicionarLivro(item.book),
                  onRemove: () => cart.removerUmLivro(item.book.id),
                );
              },
            ),
          ),
          _buildBottomBar(context, cart),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, CartManager cart) {
    return ValueListenableBuilder<List<Book>>(
      valueListenable: cart.itens,
      builder: (context, itens, _) {
        if (itens.isEmpty) return const SizedBox.shrink();

        final colors = AppColors.of(context);
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppColors.paddingPage,
              vertical: AppColors.paddingCard,
            ),
            decoration: BoxDecoration(
              color: colors.background,
              border: Border(
                top: BorderSide(color: colors.divider, width: 1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StyleTextUnaligned(
                      '${itens.length} ${itens.length == 1 ? "item" : "itens"}',
                      14,
                      fontWeight: FontWeight.w500,
                      color: colors.textSecondary,
                    ),
                    StyleTextUnaligned(
                      'R\$ ${cart.precoTotal.toStringAsFixed(2)}',
                      20,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                RoundButton(
                  'Finalizar Compra',
                  onPressed: () {
                    final grouped = _grouped(itens);
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => CheckoutScreen(itens: grouped),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CartItemRow extends StatelessWidget {
  final Book book;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const _CartItemRow({
    required this.book,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            book.image,
            width: 56,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) => Container(
              width: 56,
              height: 80,
              color: colors.surfaceLight,
              child: Icon(Icons.book_outlined, color: colors.iconInactive),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyleTextUnaligned(
                book.title,
                15,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
              const SizedBox(height: 2),
              StyleTextUnaligned(
                book.authorName,
                13,
                fontWeight: FontWeight.w400,
                color: colors.iconInactive,
              ),
              const SizedBox(height: 8),
              StyleTextUnaligned(
                'R\$ ${book.price.toStringAsFixed(2)}',
                14,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryBlue,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        _QuantityControl(
          quantity: quantity,
          onAdd: onAdd,
          onRemove: onRemove,
        ),
      ],
    );
  }
}

class _QuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const _QuantityControl({
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colors.divider),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ControlButton(
            icon: quantity == 1 ? Icons.delete_outline : Icons.remove,
            color: quantity == 1 ? AppColors.badgeRed : colors.textPrimary,
            onTap: onRemove,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: StyleTextUnaligned(
              '$quantity',
              15,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          _ControlButton(
            icon: Icons.add,
            color: colors.textPrimary,
            onTap: onAdd,
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}
