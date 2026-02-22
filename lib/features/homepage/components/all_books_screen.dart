import 'package:flutter/material.dart';
import '../../shared/text_styles.dart';
import '../../shared/app_colors.dart';
import 'book_details.dart';
import 'mock_data.dart';

/// Tela que exibe todos os livros em um GridView.
/// Acessada pelo botão "Ver todos" na seção Mais Vendidos.
class AllBooksScreen extends StatelessWidget {
  final List<Book> books;

  const AllBooksScreen({super.key, required this.books});

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
          'Mais Vendidos',
          18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppColors.paddingCard),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.55,
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return _BookGridItem(book: book);
        },
      ),
    );
  }
}

class _BookGridItem extends StatelessWidget {
  final Book book;

  const _BookGridItem({required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (_) => BookDetailsScreen(book: book),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppColors.radiusCard),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppColors.radiusCard),
                child: Image.network(
                  book.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.surfaceLight,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: AppColors.iconInactive,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          StyleTextUnaligned(
            book.title,
            14,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
          const SizedBox(height: 2),
          StyleTextUnaligned(
            book.authorName,
            12,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 4),
          StyleTextUnaligned(
            'R\$ ${book.price.toStringAsFixed(2)}',
            14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }
}
