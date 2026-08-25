import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../theme.dart';
import 'cart_screen.dart';
import 'home_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';

/// Holds cart/order state and switches between the four bottom-nav
/// tabs. This is intentionally simple (no external state management
/// package) since the app is still a prototype on mock data.
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;
  final List<CartItem> _cart = [];
  final List<FoodOrder> _orders = [];

  void _addToCart(Dish dish, PlanType plan) {
    setState(() => _cart.add(CartItem(dish: dish, plan: plan)));
  }

  void _placeOrder() {
    setState(() {
      for (final item in _cart) {
        _orders.add(FoodOrder(
          id: 'o${_orders.length + 1}',
          dish: item.dish,
          plan: item.plan,
        ));
      }
      _cart.clear();
      _index = 2; // jump to Orders tab after checkout
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(dishes: MockData.dishes, onAddToCart: _addToCart),
      CartScreen(items: _cart, onPlaceOrder: _placeOrder),
      OrdersScreen(orders: _orders),
      ProfileScreen(user: MockData.currentUser),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: AppColors.background,
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: _cart.isNotEmpty,
              label: Text('${_cart.length}'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            selectedIcon: const Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          const NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Orders'),
          const NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
