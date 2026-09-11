import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/cart_state.dart';
import '../theme.dart';
import '../app_bottom_nav.dart';

/// FEATURE 1 (screen 3 of 3): Cart, editable quantities, and checkout.
/// This is the screen that proves the "complex process" requirement:
/// state (the cart) persists and updates live across three linked screens.
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _fulfilment = 'Delivery';

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Your order')),
      body: cart.items.isEmpty
          ? const Center(child: Text('Your cart is empty', style: TextStyle(color: AppColors.textSecondary)))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.border),
                    itemBuilder: (context, i) {
                      final item = cart.items[i];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('${item.dish.name} (${item.spiceLevel})'),
                        subtitle: Text('\$${item.dish.price.toStringAsFixed(2)} each'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, size: 20),
                              onPressed: () => context.read<CartState>().updateQuantity(item, -1),
                            ),
                            Text('${item.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline, size: 20),
                              onPressed: () => context.read<CartState>().updateQuantity(item, 1),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Delivery or pickup', style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Row(
                        children: ['Delivery', 'Pickup'].map((option) {
                          final selected = option == _fulfilment;
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () => setState(() => _fulfilment = option),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: selected ? AppColors.brandRed : Colors.white,
                                    border: Border.all(color: selected ? AppColors.brandRed : AppColors.border),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(option,
                                      style: TextStyle(color: selected ? Colors.white : AppColors.textSecondary)),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          Text('\$${cart.total.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      final total = cart.total;
                      context.read<CartState>().clear();
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Order placed'),
                          content: Text(
                              'Your $_fulfilment order (\$${total.toStringAsFixed(2)}) has been confirmed.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Pay and place order'),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }
}
