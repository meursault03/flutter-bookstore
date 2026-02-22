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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        title: const StyleTextUnaligned(
          'Meus Pedidos',
          18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      body: ValueListenableBuilder<List<Purchase>>(
        valueListenable: PurchaseManager().history,
        builder: (context, purchases, _) {
          if (purchases.isEmpty) return _buildEmptyState();
          return _buildList(purchases);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.receipt_long_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const StyleTextUnaligned(
            'Nenhum pedido ainda',
            18,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 8),
          const StyleTextUnaligned(
            'Suas compras aparecerão aqui',
            14,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<Purchase> purchases) {
    return ResponsiveCenter(
      child: ListView.separated(
        padding: const EdgeInsets.all(AppColors.paddingPage),
        itemCount: purchases.length,
        separatorBuilder: (_, _) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(height: 1, color: AppColors.divider),
        ),
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
              color: AppColors.surfaceLight,
              child: const Icon(Icons.book_outlined, color: AppColors.iconInactive),
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
                color: AppColors.textPrimary,
              ),
              const SizedBox(height: 2),
              StyleTextUnaligned(
                purchase.book.authorName,
                13,
                fontWeight: FontWeight.w400,
                color: AppColors.iconInactive,
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
                      '×${purchase.quantity}',
                      12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
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
          color: AppColors.textSecondary,
        ),
      ],
    );
  }
}
