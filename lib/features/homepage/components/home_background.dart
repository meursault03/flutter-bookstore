import 'package:flutter/material.dart';
import '../../../services/session_manager.dart';
import '../../login/components/helper.dart';
import '../../profile/components/profile_screen.dart';
import '../../shared/text_styles.dart';
import '../../shared/app_colors.dart';
import 'all_books_screen.dart';
import 'book_details.dart';
import 'book_purchase_bar.dart';
import 'cart_screen.dart';
import 'mock_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Book>> _booksFuture;
  String _userName = 'Leitor';

  @override
  void initState() {
    super.initState();
    _booksFuture = loadBooks();
    _loadUserSession();
  }

  Future<void> _loadUserSession() async {
    final Map<String, dynamic> session = await SessionManager().getSession();
    final String? forename = session['forename'] as String?;

    if (mounted && forename != null && forename.isNotEmpty) {
      setState(() {
        _userName = forename;
      });
    }
  }

  static String _greetingForHour(int hour) {
    if (hour >= 5 && hour < 12) return 'Bom dia';
    if (hour >= 12 && hour < 18) return 'Boa tarde';
    return 'Boa noite';
  }

  static String _emojiForHour(int hour) {
    if (hour >= 5 && hour < 12) return '☀️';
    if (hour >= 12 && hour < 18) return '🌤️';
    if (hour >= 18 && hour < 21) return '🌆';
    return '🌙';
  }

  void _navigateToDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetailsScreen(book: book)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<List<Book>>(
          future: _booksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar dados: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum livro encontrado.'));
            }

            final List<Book> allBooks = snapshot.data!;
            final List<Book> discoveryBooks = allBooks.take(5).toList();
            final List<Book> bestSellingBooks = allBooks.length > 5
                ? allBooks.skip(5).toList()
                : allBooks;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildFeaturedCarousel(discoveryBooks),
                    const SizedBox(height: 36),
                    _buildSectionTitle('Mais Vendidos', allBooks),
                    const SizedBox(height: 16),
                    _buildBooksList(bestSellingBooks),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeader() {
    final hour = DateTime.now().hour;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyleTextUnaligned(
            '${_greetingForHour(hour)},\n$_userName ${_emojiForHour(hour)}',
            32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          const SizedBox(height: 8),
          const StyleTextUnaligned(
            'Descubra sua próxima leitura',
            16,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCarousel(List<Book> books) {
    if (books.isEmpty) return const SizedBox.shrink();

    final wide = ScreenHelper.isWideScreen(context);
    return SizedBox(
      height: 350,
      child: PageView.builder(
        controller: PageController(viewportFraction: wide ? 0.45 : 0.8),
        itemBuilder: (context, index) {
          final book = books[index % books.length];
          return GestureDetector(
            onTap: () => _navigateToDetails(book),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  book.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.image_not_supported, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, List<Book> allBooks) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StyleTextUnaligned(
            title,
            20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AllBooksScreen(books: allBooks),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const StyleTextUnaligned(
                'Ver todos',
                12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBooksList(List<Book> books) {
    if (books.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () => _navigateToDetails(book),
            child: Container(
              width: 130,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          book.image,
                          width: 130,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
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
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(height: 6),
                  StyleTextUnaligned(
                    'R\$ ${book.price.toStringAsFixed(2)}',
                    14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade700,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      iconSize: 28,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
      onTap: (index) {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartScreen()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          );
        }
      },
      items: [
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Icon(Icons.home),
          ),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: ValueListenableBuilder<List<Book>>(
            valueListenable: CartManager().itens,
            builder: (context, itens, _) {
              return Badge(
                isLabelVisible: itens.isNotEmpty,
                backgroundColor: AppColors.badgeRed,
                label: Text(
                  itens.length.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 4.0),
                  child: Icon(Icons.shopping_cart_outlined),
                ),
              );
            },
          ),
          label: 'Carrinho',
        ),
        const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Icon(Icons.person_outline),
          ),
          label: 'Perfil',
        ),
      ],
    );
  }
}
