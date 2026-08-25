import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme.dart';
import 'dish_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Dish> dishes;
  final void Function(Dish dish, PlanType plan) onAddToCart;

  const HomeScreen({super.key, required this.dishes, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Tiffin nearby'),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check, size: 12, color: AppColors.success),
                  SizedBox(width: 4),
                  Text('DU verified', style: TextStyle(fontSize: 11, color: AppColors.success)),
                ],
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Search dish or cook',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Home cooks near you', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 10),
          ...dishes.map((dish) => _DishCard(
                dish: dish,
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DishDetailScreen(dish: dish, onAddToCart: onAddToCart),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}

class _DishCard extends StatelessWidget {
  final Dish dish;
  final VoidCallback onTap;

  const _DishCard({required this.dish, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.secondary.withOpacity(0.25),
                child: Text(
                  dish.cookName.substring(0, 1),
                  style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dish.cookName, style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text('${dish.name} · ${dish.area}',
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 12, color: AppColors.secondary),
                        const SizedBox(width: 2),
                        Text('${dish.rating}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ],
                ),
              ),
              Text('\u09f3${dish.priceOneTime.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
