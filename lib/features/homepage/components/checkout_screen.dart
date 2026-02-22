import 'package:flutter/material.dart';
import '../../shared/custom_buttons.dart';
import '../../shared/responsive_center.dart';
import '../../shared/text_styles.dart';
import 'mock_data.dart';
import 'purchase_manager.dart';

/// Tela de finalização de compra. Exibe o resumo do pedido e ações de pagamento.
class CheckoutScreen extends StatelessWidget {
  final Book livro;

  const CheckoutScreen({super.key, required this.livro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const StyleTextUnaligned(
          'Finalizar Compra',
          18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
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
                      // Resumo do item
                      _buildSectionTitle('Resumo do Pedido'),
                      const SizedBox(height: 16),
                      _OrderItemRow(livro: livro),
                      const SizedBox(height: 24),
                      Container(height: 1, color: Colors.grey.shade200),
                      const SizedBox(height: 24),

                      // Endereço de entrega
                      _buildSectionTitle('Endereço de Entrega'),
                      const SizedBox(height: 16),
                      const _InfoCard(
                        icon: Icons.location_on_outlined,
                        label: 'Endereço não configurado',
                        subtitle: 'Toque para adicionar um endereço',
                      ),
                      const SizedBox(height: 24),
                      Container(height: 1, color: Colors.grey.shade200),
                      const SizedBox(height: 24),

                      // Método de pagamento
                      _buildSectionTitle('Método de Pagamento'),
                      const SizedBox(height: 16),
                      const _InfoCard(
                        icon: Icons.credit_card_outlined,
                        label: 'Nenhum cartão cadastrado',
                        subtitle: 'Toque para adicionar um cartão',
                      ),
                      const SizedBox(height: 24),
                      Container(height: 1, color: Colors.grey.shade200),
                      const SizedBox(height: 24),

                      // Total
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const StyleTextUnaligned(
                            'Total',
                            16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          StyleTextUnaligned(
                            'R\$ ${livro.price.toStringAsFixed(2)}',
                            20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
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
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade200, width: 1),
                  ),
                ),
                child: RoundButton(
                  'Confirmar Pedido',
                  onPressed: () {
                    PurchaseManager().registrarCompra(livro);
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

  Widget _buildSectionTitle(String title) {
    return StyleTextUnaligned(
      title,
      16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final Book livro;
  const _OrderItemRow({required this.livro});

  @override
  Widget build(BuildContext context) {
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
              color: Colors.grey.shade200,
              child: const Icon(Icons.book_outlined, color: Colors.grey),
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
                color: Colors.black,
              ),
              const SizedBox(height: 4),
              StyleTextUnaligned(
                livro.authorName,
                13,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        StyleTextUnaligned(
          'R\$ ${livro.price.toStringAsFixed(2)}',
          15,
          fontWeight: FontWeight.bold,
          color: Colors.black,
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade500, size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyleTextUnaligned(
                label,
                14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              StyleTextUnaligned(
                subtitle,
                12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ],
          ),
          const Spacer(),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}
