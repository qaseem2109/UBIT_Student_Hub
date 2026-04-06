import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../models/models.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/sign_out_dialog.dart';

class AppDrawer extends StatelessWidget {
  final AppUser user;
  const AppDrawer({super.key, required this.user});

  void _showSignOutDialog(BuildContext context) {
    Navigator.pop(context); // close drawer first
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => const SignOutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.cardBg,
      width: MediaQuery.of(context).size.width * 0.78,
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel('NAVIGATION'),
                  _DrawerNavItem(
                    icon: Icons.home_outlined,
                    label: 'Dashboard',
                    onTap: () => Navigator.pop(context),
                  ),
                  _DrawerNavItem(
                    icon: Icons.storefront_outlined,
                    label: 'Marketplace',
                    onTap: () => Navigator.pop(context),
                  ),
                  _DrawerNavItem(
                    icon: Icons.menu_book_outlined,
                    label: 'My Courses',
                    onTap: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 6),
                  Divider(color: AppColors.borderColor.withOpacity(0.6)),
                  const SizedBox(height: 6),
                  _sectionLabel('ACCOUNT'),
                  _DrawerNavItem(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    onTap: () => Navigator.pop(context),
                  ),
                  _DrawerNavItem(
                    icon: Icons.info_outline,
                    label: 'About',
                    onTap: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Divider(color: AppColors.borderColor.withOpacity(0.6)),
                  const SizedBox(height: 4),
                  // Destructive logout item
                  _DrawerNavItem(
                    icon: Icons.logout_rounded,
                    label: 'Log Out',
                    isDestructive: true,
                    onTap: () => _showSignOutDialog(context),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 0, 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.textMuted.withOpacity(0.7),
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UbitLogo(lightMode: true),
            const Spacer(),
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white.withOpacity(0.25),
                  child: Text(
                    user.initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user.email,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 11,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PRIVATE DRAWER NAV ITEM
// ─────────────────────────────────────────────
class _DrawerNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _DrawerNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.textMuted;
    final textColor = isDestructive ? AppColors.error : AppColors.textDark;
    final bgColor =
        isDestructive ? AppColors.errorLight : AppColors.primaryLight;

    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: color),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
      trailing: Icon(Icons.chevron_right,
          size: 18,
          color: isDestructive
              ? AppColors.error.withOpacity(0.5)
              : AppColors.textMuted),
      onTap: onTap,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
