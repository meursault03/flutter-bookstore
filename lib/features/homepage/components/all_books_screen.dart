import 'package:flutter/material.dart';
import '../../shared/app_colors.dart';
import '../../shared/text_styles.dart';
import 'book_details.dart';
import 'mock_data.dart';

/// Tela que exibe todos os livros em um GridView com filtros por categoria.
/// Acessada pelo botão "Ver todos" na seção Mais Vendidos.
class AllBooksScreen extends StatefulWidget {
  final List<Book> books;

  const AllBooksScreen({super.key, required this.books});

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  String? _selectedCategory;

  List<Book> get _filteredBooks {
    if (_selectedCategory == null) return widget.books;
    return widget.books
        .where((b) => b.categoria == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final categories = extractCategories(widget.books);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        centerTitle: true,
        title: StyleTextUnaligned(
          'Mais Vendidos',
          18,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
      ),
      body: Column(
        children: [
          _buildCategoryFilters(colors, categories),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(AppColors.paddingCard),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 0.55,
                crossAxisSpacing: 16,
                mainAxisSpacing: 20,
              ),
              itemCount: _filteredBooks.length,
              itemBuilder: (context, index) {
                final book = _filteredBooks[index];
                return _BookGridItem(book: book);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters(AppColorsTheme colors, List<String> categories) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppColors.paddingPage,
          vertical: 8,
        ),
        itemCount: categories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            final isSelected = _selectedCategory == null;
            return FilterChip(
              label: Text('Todos'),
              selected: isSelected,
              labelStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : colors.textPrimary,
              ),
              backgroundColor: colors.surfaceLight,
              selectedColor: AppColors.primaryBlue,
              checkmarkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (_) {
                setState(() => _selectedCategory = null);
              },
            );
          }

          final cat = categories[index - 1];
          final isSelected = _selectedCategory == cat;
          return FilterChip(
            label: Text(cat),
            selected: isSelected,
            labelStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : colors.textPrimary,
            ),
            backgroundColor: colors.surfaceLight,
            selectedColor: AppColors.primaryBlue,
            checkmarkColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            onSelected: (_) {
              setState(() => _selectedCategory = isSelected ? null : cat);
            },
          );
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
    final colors = AppColors.of(context);
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
                    color: colors.cardShadow,
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
                    color: colors.surfaceLight,
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: colors.iconInactive,
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
            color: colors.textPrimary,
          ),
          const SizedBox(height: 2),
          StyleTextUnaligned(
            book.authorName,
            12,
            fontWeight: FontWeight.w400,
            color: colors.textSecondary,
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
