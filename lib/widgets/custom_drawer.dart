import 'package:ar_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:ar_app/constants/app_colors.dart';
import 'package:ar_app/constants/text_styles.dart';

class CustomDrawer extends StatelessWidget {
  final bool isGuest;

  const CustomDrawer({
    super.key,
    required this.isGuest,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isGuest ? 'Guest User' : 'John Doe',
                  style: AppTextStyles.heading3.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  isGuest ? 'Sign in to access all features' : 'john.doe@example.com',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home_outlined,
            title: 'Home',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _buildDrawerItem(
            icon: Icons.shopping_bag_outlined,
            title: 'Shop',
            onTap: () {
              Navigator.pop(context);
              // Navigate to shop
            },
          ),
          _buildDrawerItem(
            icon: Icons.face_outlined,
            title: 'Virtual Try-On',
            onTap: () {
              Navigator.pop(context);
              // Navigate to AR try-on
            },
          ),
          _buildDrawerItem(
            icon: Icons.favorite_border,
            title: 'Wishlist',
            onTap: () {
              Navigator.pop(context);
              // Navigate to wishlist
            },
          ),
          _buildDrawerItem(
            icon: Icons.local_offer_outlined,
            title: 'Offers',
            onTap: () {
              Navigator.pop(context);
              // Navigate to offers
            },
          ),
          _buildDrawerItem(
            icon: Icons.location_on_outlined,
            title: 'Store Locator',
            onTap: () {
              Navigator.pop(context);
              // Navigate to store locator
            },
          ),
          const Divider(),
          _buildDrawerItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),
          _buildDrawerItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {
              Navigator.pop(context);
              // Navigate to help
            },
          ),
          if (isGuest)
            _buildDrawerItem(
              icon: Icons.login,
              title: 'Sign In',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            )
          else
            _buildDrawerItem(
              icon: Icons.logout,
              title: 'Sign Out',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
      ),
      title: Text(
        title,
        style: AppTextStyles.body,
      ),
      onTap: onTap,
    );
  }
}