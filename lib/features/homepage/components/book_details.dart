import 'package:flutter/material.dart';
import '../../shared/app_colors.dart';
import '../../shared/responsive_center.dart';
import '../../shared/text_styles.dart';
import 'book_cover.dart';
import 'book_purchase_bar.dart';
import 'mock_data.dart';

/// Tela de detalhes de um livro. Exibe capa, sinopse e preço, com botão de compra fixo na base.
class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

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
          'Detalhes',
          18,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
      ),
      body: ResponsiveCenter(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookCover(imageUrl: book.image),
                    const SizedBox(height: 32),
                    _buildTitleAndAuthor(colors),
                    const SizedBox(height: 24),
                    Container(height: 1, color: colors.divider),
                    const SizedBox(height: 24),
                    _buildSynopsis(colors),
                  ],
                ),
              ),
            ),
            BookPurchaseBar(livro: book),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndAuthor(AppColorsTheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleTextUnaligned(
          book.title,
          26,
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
        ),
        const SizedBox(height: 8),
        StyleTextUnaligned(
          book.authorName,
          16,
          fontWeight: FontWeight.w500,
          color: colors.textSecondary,
        ),
      ],
    );
  }

  Widget _buildSynopsis(AppColorsTheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleTextUnaligned(
          'Sinopse',
          20,
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
        ),
        const SizedBox(height: 16),
        StyleTextUnaligned(
          book.description,
          15,
          fontWeight: FontWeight.w400,
          color: colors.textSubtle,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
