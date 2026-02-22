import 'package:flutter/material.dart';
import '../../../services/session_manager.dart';
import '../../login/components/auth.dart';
import '../../login/components/background.dart';
import '../../shared/app_colors.dart';
import '../../shared/custom_buttons.dart';
import '../../shared/responsive_center.dart';
import '../../shared/text_styles.dart';
import '../../homepage/components/book_purchase_bar.dart';
import '../../homepage/components/purchase_manager.dart';
import 'purchase_history_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _forename = '';
  String _surname = '';
  String _email = '';
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final session = await SessionManager().getSession();
    if (mounted) {
      setState(() {
        _forename = session['forename'] ?? '';
        _surname = session['surname'] ?? '';
        _email = session['email'] ?? '';
        _loaded = true;
      });
    }
  }

  String get _initials {
    final first = _forename.isNotEmpty ? _forename[0] : '';
    final last = _surname.isNotEmpty ? _surname[0] : '';
    return '$first$last'.toUpperCase();
  }

  String get _fullName => '$_forename $_surname'.trim();

  Future<void> _logout() async {
    await SessionManager().clearSession();
    CartManager().itens.value = [];
    PurchaseManager().limpar();
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: GradientContainer(
              Color.fromARGB(255, 15, 81, 250),
              Color.fromARGB(255, 0, 180, 238),
              child: SingleChildScrollView(
                child: ResponsiveCenter(child: AuthScreen()),
              ),
            ),
          ),
        ),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
        title: const StyleTextUnaligned(
          'Perfil',
          18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppColors.paddingPage),
        child: ResponsiveCenter(
          child: Column(
            children: [
              _buildAvatar(),
              const SizedBox(height: 16),
              StyleTextUnaligned(
                _fullName,
                22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              const SizedBox(height: 4),
              StyleTextUnaligned(
                _email,
                14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 32),
              _ProfileMenuItem(
                icon: Icons.shopping_bag_outlined,
                label: 'Meus Pedidos',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PurchaseHistoryScreen()),
                ),
              ),
              _ProfileMenuItem(
                icon: Icons.location_on_outlined,
                label: 'Endereços',
                onTap: () => _showPlaceholder('Endereços'),
              ),
              _ProfileMenuItem(
                icon: Icons.credit_card_outlined,
                label: 'Pagamento',
                onTap: () => _showPlaceholder('Pagamento'),
              ),
              _ProfileMenuItem(
                icon: Icons.settings_outlined,
                label: 'Configurações',
                onTap: () => _showPlaceholder('Configurações'),
              ),
              const SizedBox(height: 32),
              OutlinedRoundButton(
                'Sair',
                borderColor: AppColors.badgeRed,
                textColor: AppColors.badgeRed,
                onPressed: _logout,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 80,
      height: 80,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: Center(
        child: StyleTextUnaligned(
          _initials,
          28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showPlaceholder(String feature) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$feature em desenvolvimento')));
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppColors.radiusCard),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.divider, width: 1),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: StyleTextUnaligned(
                label,
                15,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.iconInactive,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
