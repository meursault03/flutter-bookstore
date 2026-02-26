import 'package:flutter/material.dart';
import '../../shared/app_colors.dart';
import '../../shared/responsive_center.dart';
import '../../shared/text_styles.dart';
import '../../homepage/components/purchase_manager.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  const PurchaseHistoryScreen({super.key});

  static const _months = [
    'jan', 'fev', 'mar', 'abr', 'mai', 'jun',
    'jul', 'ago', 'set', 'out', 'nov', 'dez',
  ];

  static String _formatDate(DateTime date) {
    return '${date.day} ${_months[date.month - 1]} ${date.year}';
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
          'Meus Pedidos',
          18,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
      ),
      body: ValueListenableBuilder<List<Purchase>>(
        valueListenable: PurchaseManager().history,
        builder: (context, purchases, _) {
          if (purchases.isEmpty) return _buildEmptyState(context);
          return _buildList(context, purchases);
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
          Icon(Icons.receipt_long_outlined, size: 80, color: colors.surfaceLight),
          const SizedBox(height: 16),
          StyleTextUnaligned(
            'Nenhum pedido ainda',
            18,
            fontWeight: FontWeight.w600,
            color: colors.textSecondary,
          ),
          const SizedBox(height: 8),
          StyleTextUnaligned(
            'Suas compras aparecerão aqui',
            14,
            fontWeight: FontWeight.w400,
            color: colors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Purchase> purchases) {
    return ResponsiveCenter(
      child: ListView.separated(
        padding: const EdgeInsets.all(AppColors.paddingPage),
        itemCount: purchases.length,
        separatorBuilder: (context, _) {
          final colors = AppColors.of(context);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(height: 1, color: colors.divider),
          );
        },
        itemBuilder: (context, index) {
          final purchase = purchases[index];
          return _PurchaseRow(purchase: purchase);
        },
      ),
    );
  }
}

class _PurchaseRow extends StatelessWidget {
  final Purchase purchase;

  const _PurchaseRow({required this.purchase});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            purchase.book.image,
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
                purchase.book.title,
                15,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
              const SizedBox(height: 2),
              StyleTextUnaligned(
                purchase.book.authorName,
                13,
                fontWeight: FontWeight.w400,
                color: colors.iconInactive,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  StyleTextUnaligned(
                    'R\$ ${purchase.total.toStringAsFixed(2)}',
                    14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryBlue,
                  ),
                  if (purchase.quantity > 1) ...[
                    const SizedBox(width: 6),
                    StyleTextUnaligned(
                      '\u00d7${purchase.quantity}',
                      12,
                      fontWeight: FontWeight.w400,
                      color: colors.textSecondary,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        StyleTextUnaligned(
          PurchaseHistoryScreen._formatDate(purchase.date),
          12,
          fontWeight: FontWeight.w400,
          color: colors.textSecondary,
        ),
      ],
    );
  }
}
