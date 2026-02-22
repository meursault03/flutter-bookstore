import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const StyleTextUnaligned(
          'Detalhes',
          18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
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
                    _buildTitleAndAuthor(),
                    const SizedBox(height: 24),
                    Container(height: 1, color: Colors.grey.shade200),
                    const SizedBox(height: 24),
                    _buildSynopsis(),
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

  Widget _buildTitleAndAuthor() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleTextUnaligned(
          book.title,
          26,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(height: 8),
        StyleTextUnaligned(
          book.authorName,
          16,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade600,
        ),
      ],
    );
  }

  Widget _buildSynopsis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const StyleTextUnaligned(
          'Sinopse',
          20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(height: 16),
        StyleTextUnaligned(
          book.description,
          15,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
