import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dish.dart';
import '../state/cart_state.dart';
import '../theme.dart';

/// FEATURE 1 (screen 2 of 3): Dish customisation and add-to-cart.
class DishDetailScreen extends StatefulWidget {
  final Dish dish;
  const DishDetailScreen({super.key, required this.dish});

  @override
  State<DishDetailScreen> createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  String _spice = 'Medium';
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    final dish = widget.dish;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 180,
                color: AppColors.gold.withOpacity(0.2),
                child: const Icon(Icons.ramen_dining, size: 64, color: AppColors.gold),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dish.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text(dish.description, style: const TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 20),
                  const Text('Spice level', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['Mild', 'Medium', 'Hot'].map((level) {
                      final selected = level == _spice;
                      return ChoiceChip(
                        label: Text(level),
                        selected: selected,
                        onSelected: (_) => setState(() => _spice = level),
                        selectedColor: AppColors.brandRed.withOpacity(0.12),
                        labelStyle: TextStyle(color: selected ? AppColors.brandRed : AppColors.textSecondary),
                        side: BorderSide(color: selected ? AppColors.brandRed : AppColors.border),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text('Portion', style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => setState(() => _qty = _qty > 1 ? _qty - 1 : 1),
                      ),
                      Text('$_qty', style: const TextStyle(fontSize: 16)),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => setState(() => _qty++),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  context.read<CartState>().addDish(dish, spiceLevel: _spice, quantity: _qty);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${dish.name} added to cart'), duration: const Duration(seconds: 1)),
                  );
                  Navigator.pop(context);
                },
                child: Text('Add to cart · \$${(dish.price * _qty).toStringAsFixed(2)}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
