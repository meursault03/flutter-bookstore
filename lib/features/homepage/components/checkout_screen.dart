import 'package:flutter/material.dart';
import '../../shared/app_colors.dart';
import '../../shared/custom_buttons.dart';
import '../../shared/responsive_center.dart';
import '../../shared/text_styles.dart';
import 'book_purchase_bar.dart';
import 'mock_data.dart';
import 'purchase_manager.dart';

/// Tipo agrupado: livro + quantidade.
typedef ItemPedido = ({Book book, int qty});

/// Tela de finalização de compra. Exibe o resumo do pedido e ações de pagamento.
/// Aceita uma lista de itens agrupados por livro.
class CheckoutScreen extends StatelessWidget {
  final List<ItemPedido> itens;

  const CheckoutScreen({super.key, required this.itens});

  /// Construtor de conveniência para compra direta de um único livro.
  factory CheckoutScreen.compraAvulsa({Key? key, required Book livro}) {
    return CheckoutScreen(key: key, itens: [(book: livro, qty: 1)]);
  }

  double get _precoTotal =>
      itens.fold(0.0, (sum, item) => sum + item.book.price * item.qty);

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
          'Finalizar Compra',
          18,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
      ),
      body: SafeArea(
        child: ResponsiveCenter(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle(context, 'Resumo do Pedido'),
                      const SizedBox(height: 16),
                      ...itens.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _OrderItemRow(
                              livro: item.book,
                              quantidade: item.qty,
                            ),
                          )),
                      const SizedBox(height: 12),
                      Container(height: 1, color: colors.divider),
                      const SizedBox(height: 24),

                      // Endereço de entrega
                      _buildSectionTitle(context, 'Endereço de Entrega'),
                      const SizedBox(height: 16),
                      const _InfoCard(
                        icon: Icons.location_on_outlined,
                        label: 'Endereço não configurado',
                        subtitle: 'Toque para adicionar um endereço',
                      ),
                      const SizedBox(height: 24),
                      Container(height: 1, color: colors.divider),
                      const SizedBox(height: 24),

                      // Método de pagamento
                      _buildSectionTitle(context, 'Método de Pagamento'),
                      const SizedBox(height: 16),
                      const _InfoCard(
                        icon: Icons.credit_card_outlined,
                        label: 'Nenhum cartão cadastrado',
                        subtitle: 'Toque para adicionar um cartão',
                      ),
                      const SizedBox(height: 24),
                      Container(height: 1, color: colors.divider),
                      const SizedBox(height: 24),

                      // Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StyleTextUnaligned(
                            'Total',
                            16,
                            fontWeight: FontWeight.w600,
                            color: colors.textPrimary,
                          ),
                          StyleTextUnaligned(
                            'R\$ ${_precoTotal.toStringAsFixed(2)}',
                            20,
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              // Botão confirmar pedido
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                decoration: BoxDecoration(
                  color: colors.surface,
                  border: Border(
                    top: BorderSide(color: colors.divider, width: 1),
                  ),
                ),
                child: RoundButton(
                  'Confirmar Pedido',
                  onPressed: () {
                    for (final item in itens) {
                      PurchaseManager().registrarCompra(
                        item.book,
                        quantity: item.qty,
                      );
                    }
                    CartManager().itens.value = [];
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pedido realizado com sucesso!'),
                      ),
                    );
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final colors = AppColors.of(context);
    return StyleTextUnaligned(
      title,
      16,
      fontWeight: FontWeight.bold,
      color: colors.textPrimary,
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final Book livro;
  final int quantidade;
  const _OrderItemRow({required this.livro, required this.quantidade});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            livro.image,
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
                livro.title,
                15,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
              const SizedBox(height: 4),
              StyleTextUnaligned(
                livro.authorName,
                13,
                fontWeight: FontWeight.w400,
                color: colors.iconInactive,
              ),
              if (quantidade > 1) ...[
                const SizedBox(height: 4),
                StyleTextUnaligned(
                  'Qtd: $quantidade',
                  12,
                  fontWeight: FontWeight.w400,
                  color: colors.textSecondary,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 12),
        StyleTextUnaligned(
          'R\$ ${(livro.price * quantidade).toStringAsFixed(2)}',
          15,
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: colors.divider),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: colors.iconInactive, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyleTextUnaligned(
                label,
                14,
                fontWeight: FontWeight.w500,
                color: colors.textPrimary,
              ),
              StyleTextUnaligned(
                subtitle,
                12,
                fontWeight: FontWeight.w400,
                color: colors.iconInactive,
              ),
            ],
          ),
          const Spacer(),
          Icon(Icons.chevron_right, color: colors.iconInactive),
        ],
      ),
    );
  }
}
