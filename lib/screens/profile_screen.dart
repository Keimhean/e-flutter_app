import 'package:flutter/material.dart';
import 'package:ios26_testing/widgets/profile_option.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 24),
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFC46131),
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'Keimhean Hsu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Text(
              'mzkeimhean@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 32),
          ProfileOption(icon: Icons.receipt, title: 'Orders', onTap: () {}),
          ProfileOption(icon: Icons.bookmark, title: 'Wishlist', onTap: () {}),
          ProfileOption(
            icon: Icons.location_on,
            title: 'Addresses',
            onTap: () {},
          ),
          ProfileOption(
            icon: Icons.payment,
            title: 'Payment Methods',
            onTap: () {},
          ),
          ProfileOption(icon: Icons.settings, title: 'Settings', onTap: () {}),
          ProfileOption(icon: Icons.logout, title: 'Logout', onTap: () {}),
        ],
      ),
    );
  }
}
