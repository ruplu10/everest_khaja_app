import 'package:flutter/material.dart';
import '../app_bottom_nav.dart';
import '../theme.dart';

/// Screen 6 of the Figma prototype. Static status list - in the real product
/// this would subscribe to live order-status updates from a backend/kitchen
/// system, which is out of scope for this front-end-only assessment.
class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      ('Order confirmed', true),
      ('Preparing your food', true),
      ('Out for delivery', false),
      ('Delivered', false),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Order #4821')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Estimated arrival 6:40pm', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 20),
            for (final step in steps)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 11,
                      backgroundColor: step.$2 ? AppColors.brandRed : AppColors.border,
                      child: step.$2 ? const Icon(Icons.check, size: 13, color: Colors.white) : null,
                    ),
                    const SizedBox(width: 12),
                    Text(step.$1, style: TextStyle(color: step.$2 ? Colors.black87 : Colors.grey)),
                  ],
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }
}
