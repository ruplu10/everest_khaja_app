import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/reservation_screen.dart';
import 'screens/profile_screen.dart';

/// Matches the bottom nav in the Figma prototype (Home / Cart / Reservation / Profile).
/// Present on every core screen so navigation matches the linked-pages structure
/// of the Assessment 3 design.
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  const AppBottomNav({super.key, required this.currentIndex});

  void _go(BuildContext context, int index) {
    if (index == currentIndex) return;
    Widget target;
    switch (index) {
      case 0:
        target = const HomeScreen();
        break;
      case 1:
        target = const CartScreen();
        break;
      case 2:
        target = const ReservationScreen();
        break;
      default:
        target = const ProfileScreen();
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => target));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: AppColors.brandRed,
      unselectedItemColor: Colors.grey,
      onTap: (i) => _go(context, i),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: 'Reserve'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}
