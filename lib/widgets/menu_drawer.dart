
// widgets/menu_drawer.dart
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black.withOpacity(0.95),
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                'Samuel Adams',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  title: 'Portfolio',
                  onTap: () => Navigator.pop(context),
                ),
                _buildMenuItem(
                  title: 'Instagram',
                  onTap: () => Navigator.pop(context),
                ),
                _buildMenuItem(
                  title: 'Contact',
                  onTap: () => Navigator.pop(context),
                ),
                const Divider(color: Colors.white24),
                _buildMenuItem(
                  title: 'Being One',
                  onTap: () => Navigator.pop(context),
                  isSpecial: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required VoidCallback onTap,
    bool isSpecial = false,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isSpecial ? Colors.amber : Colors.white70,
          fontSize: isSpecial ? 18 : 16,
          fontWeight: isSpecial ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
      hoverColor: Colors.amber.withOpacity(0.1),
    );
  }
}
