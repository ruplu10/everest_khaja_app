import 'package:flutter/foundation.dart';
import '../models/dish.dart';

class CartItem {
  final Dish dish;
  int quantity;
  String spiceLevel;

  CartItem({required this.dish, this.quantity = 1, this.spiceLevel = 'Medium'});

  double get subtotal => dish.price * quantity;
}

/// Feature 1 shared state: Menu browsing & ordering.
/// Holds the cart contents and notifies listeners (Cart screen, badges, totals)
/// whenever an item is added, removed, or its quantity changes.
class CartState extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get total => _items.fold(0.0, (sum, item) => sum + item.subtotal);

  void addDish(Dish dish, {String spiceLevel = 'Medium', int quantity = 1}) {
    final existingIndex = _items.indexWhere((i) => i.dish.id == dish.id && i.spiceLevel == spiceLevel);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += quantity;
    } else {
      _items.add(CartItem(dish: dish, quantity: quantity, spiceLevel: spiceLevel));
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void updateQuantity(CartItem item, int delta) {
    final newQty = item.quantity + delta;
    if (newQty <= 0) {
      removeItem(item);
    } else {
      item.quantity = newQty;
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

/// Feature 2 shared state: Table reservation.
/// Holds the most recently confirmed booking so the confirmation screen
/// and (in a later iteration) a "My reservations" screen can read it.
class ReservationState extends ChangeNotifier {
  DateTime? date;
  String? time;
  int guests = 2;
  bool confirmed = false;

  void setReservation({required DateTime date, required String time, required int guests}) {
    this.date = date;
    this.time = time;
    this.guests = guests;
    confirmed = true;
    notifyListeners();
  }

  void reset() {
    date = null;
    time = null;
    guests = 2;
    confirmed = false;
    notifyListeners();
  }
}
