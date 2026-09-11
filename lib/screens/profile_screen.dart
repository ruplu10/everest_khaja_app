import 'package:flutter/material.dart';
import '../app_bottom_nav.dart';
import '../theme.dart';
import 'order_tracking_screen.dart';

/// Screen 8 of the Figma prototype. Menu rows are presentational except
/// "Order history", which links through to the tracking screen as a stand-in
/// for a real order-history list (would need a backend to be real data).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rows = [
      (Icons.history, 'Order history'),
      (Icons.calendar_month_outlined, 'My reservations'),
      (Icons.place_outlined, 'Saved addresses'),
      (Icons.settings_outlined, 'Settings'),
      (Icons.logout, 'Log out'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.gold.withOpacity(0.2),
                  child: const Text('RS', style: TextStyle(color: AppColors.gold, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ram Sharma', style: TextStyle(fontWeight: FontWeight.w500)),
                    Text('ram@email.com', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            for (final row in rows)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(row.$1, color: AppColors.textSecondary),
                title: Text(row.$2),
                onTap: row.$2 == 'Order history'
                    ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen()))
                    : null,
              ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
    );
  }
}
