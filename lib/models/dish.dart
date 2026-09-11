class Dish {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;

  const Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
  });
}

const List<Dish> menuDishes = [
  Dish(
    id: 'momo',
    name: 'Chicken Momo',
    description: 'Steamed dumplings served with tomato achar, 10 pieces',
    price: 12.50,
    category: 'Momo',
  ),
  Dish(
    id: 'thukpa',
    name: 'Thukpa Noodle Soup',
    description: 'Warming veg or chicken broth with hand-pulled noodles',
    price: 14.00,
    category: 'Thukpa',
  ),
  Dish(
    id: 'sekuwa',
    name: 'Sekuwa Skewers',
    description: 'Grilled marinated chicken, Himalayan spice rub',
    price: 16.00,
    category: 'Tandoori',
  ),
  Dish(
    id: 'dal-bhat',
    name: 'Dal Bhat Set',
    description: 'Steamed rice, lentil soup, seasonal vegetable curry, pickle',
    price: 18.50,
    category: 'Curry',
  ),
  Dish(
    id: 'chiya',
    name: 'Masala Chiya',
    description: 'Spiced Nepali milk tea',
    price: 4.50,
    category: 'Drinks',
  ),
];
