import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../models/models.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/app_drawer.dart';
import 'tabs/dashboard_tab.dart';
import 'tabs/marketplace_tab.dart';
import 'tabs/profile_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Tab config — label, icon, active icon
  static const _tabs = [
    _TabConfig(
        label: 'Home', icon: Icons.home_outlined, activeIcon: Icons.home),
    _TabConfig(
        label: 'Courses',
        icon: Icons.menu_book_outlined,
        activeIcon: Icons.menu_book),
    _TabConfig(
        label: 'Marketplace',
        icon: Icons.storefront_outlined,
        activeIcon: Icons.storefront),
    _TabConfig(
        label: 'Profile', icon: Icons.person_outline, activeIcon: Icons.person),
  ];

  // AppBar titles per tab
  // ignore: unused_field
  static const _titles = ['Dashboard', 'Courses', 'Marketplace', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(user: mockUser),
      appBar: _buildAppBar(),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          DashboardTab(),
          _CoursesPlaceholder(),
          MarketplaceTab(),
          ProfileTab(),
        ],
      ),
      floatingActionButton: _currentIndex == 2
          ? _buildMarketplaceFAB()
          : _currentIndex == 0
              ? _buildDashboardFAB()
              : null,
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ── AppBar ─────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.cardBg,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      // Builder required — context must be descendant of Scaffold
      leading: Builder(
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.menu, color: AppColors.textDark),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
        ),
      ),
      title: const UbitLogo(),
      centerTitle: false,
      actions: [
        if (_currentIndex != 3) ...[
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textDark, size: 22),
            onPressed: () {},
          ),
        ],
        if (_currentIndex == 2) ...[
          // Notification bell with badge for marketplace
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: AppColors.textDark, size: 22),
                onPressed: () {},
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
        ],
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: CircleAvatar(
            radius: 17,
            backgroundColor: AppColors.primary,
            child: Text(
              mockUser.initials,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }

  // ── FABs ───────────────────────────────────
  Widget _buildDashboardFAB() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: AppColors.primary,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }

  Widget _buildMarketplaceFAB() {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 4,
      icon: const Icon(Icons.add, size: 20),
      label: const Text('Sell Item',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
    );
  }

  // ── Bottom Nav ─────────────────────────────
  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (i) => setState(() => _currentIndex = i),
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.cardBg,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textMuted,
      selectedLabelStyle:
          const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontSize: 11),
      elevation: 12,
      items: _tabs
          .asMap()
          .entries
          .map((e) => BottomNavigationBarItem(
                icon: Icon(e.value.icon),
                activeIcon: Icon(e.value.activeIcon),
                label: e.value.label,
              ))
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────
//  TAB CONFIG HELPER
// ─────────────────────────────────────────────
class _TabConfig {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  const _TabConfig(
      {required this.label, required this.icon, required this.activeIcon});
}

// ─────────────────────────────────────────────
//  COURSES PLACEHOLDER
// ─────────────────────────────────────────────
class _CoursesPlaceholder extends StatelessWidget {
  const _CoursesPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.menu_book_outlined,
              size: 60, color: AppColors.primary.withOpacity(0.3)),
          const SizedBox(height: 16),
          const Text('Courses',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark)),
          const SizedBox(height: 8),
          const Text('Coming soon in the next update.',
              style: TextStyle(fontSize: 14, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}
