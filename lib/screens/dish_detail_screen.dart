import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme.dart';

class DishDetailScreen extends StatefulWidget {
  final Dish dish;
  final void Function(Dish dish, PlanType plan) onAddToCart;

  const DishDetailScreen({super.key, required this.dish, required this.onAddToCart});

  @override
  State<DishDetailScreen> createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  PlanType _selected = PlanType.oneTime;

  @override
  Widget build(BuildContext context) {
    final dish = widget.dish;
    return Scaffold(
      appBar: AppBar(title: Text(dish.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: const Text('Dish photo', style: TextStyle(color: AppColors.textSecondary)),
          ),
          const SizedBox(height: 14),
          Text(dish.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          Text('${dish.cookName} · ${dish.area}',
              style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 18),
          const Text('Choose a plan', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ...PlanType.values.map((plan) => _PlanTile(
                label: planLabel(plan),
                price: dish.priceFor(plan),
                selected: _selected == plan,
                onTap: () => setState(() => _selected = plan),
              )),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              widget.onAddToCart(dish, _selected);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to cart')),
              );
            },
            child: const Text('Add to cart'),
          ),
        ],
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  final String label;
  final double price;
  final bool selected;
  final VoidCallback onTap;

  const _PlanTile({
    required this.label,
    required this.price,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: selected ? AppColors.primary.withOpacity(0.06) : AppColors.surface,
      child: RadioListTile<bool>(
        value: true,
        groupValue: selected ? true : null,
        onChanged: (_) => onTap(),
        activeColor: AppColors.primary,
        title: Text(label),
        secondary: Text('\u09f3${price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
