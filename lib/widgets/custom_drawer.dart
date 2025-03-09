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
            decoration: BoxDecoration(
              color: Colors.grey[800],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isGuest ? 'Guest User' : 'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  isGuest
                      ? 'Sign in to access all features'
                      : 'john.doe@example.com',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home_outlined,
            title: 'Home',
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.shopping_bag_outlined,
            title: 'Shop',
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.face_outlined,
            title: 'Virtual Try-On',
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.favorite_border,
            title: 'Wishlist',
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.local_offer_outlined,
            title: 'Offers',
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.location_on_outlined,
            title: 'Store Locator',
            onTap: () => Navigator.pop(context),
          ),
          const Divider(color: Colors.grey),
          _buildDrawerItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () => Navigator.pop(context),
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
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      hoverColor: Colors.grey[200],
    );
  }
}
