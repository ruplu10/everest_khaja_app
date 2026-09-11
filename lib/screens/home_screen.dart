import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dish.dart';
import '../state/cart_state.dart';
import '../theme.dart';
import '../app_bottom_nav.dart';
import 'dish_detail_screen.dart';
import 'cart_screen.dart';
import 'reservation_screen.dart';

/// FEATURE 1 (screen 1 of 3): Menu browsing.
/// Lets the user filter dishes by category and tap through to a dish's
/// detail page. Also links out to reservations (Feature 2) and the cart.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final categories = ['All', ...{for (final d in menuDishes) d.category}];
    final filtered = _selectedCategory == 'All'
        ? menuDishes
        : menuDishes.where((d) => d.category == _selectedCategory).toList();

    final cart = context.watch<CartState>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.brandRed,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Everest Khaja',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                            onPressed: () => Navigator.push(
                                context, MaterialPageRoute(builder: (_) => const CartScreen())),
                          ),
                          if (cart.itemCount > 0)
                            Positioned(
                              right: 4,
                              top: 4,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: AppColors.gold,
                                child: Text('${cart.itemCount}',
                                    style: const TextStyle(fontSize: 10, color: Colors.white)),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.brandRed,
                      minimumSize: const Size(0, 36),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                    ),
                    icon: const Icon(Icons.calendar_today, size: 16),
                    label: const Text('Book a table'),
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => const ReservationScreen())),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final cat = categories[i];
                  final selected = cat == _selectedCategory;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: selected,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                    selectedColor: AppColors.gold,
                    labelStyle: TextStyle(color: selected ? Colors.white : AppColors.textSecondary),
                    backgroundColor: Colors.grey.shade100,
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.border),
                itemBuilder: (context, i) {
                  final dish = filtered[i];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 6),
                    leading: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.ramen_dining, color: AppColors.gold),
                    ),
                    title: Text(dish.name, style: const TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text(dish.description,
                        maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    trailing: Text('\$${dish.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => DishDetailScreen(dish: dish))),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
    );
  }
}
