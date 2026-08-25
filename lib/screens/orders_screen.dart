import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme.dart';

class OrdersScreen extends StatelessWidget {
  final List<FoodOrder> orders;

  const OrdersScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: orders.isEmpty
          ? const Center(child: Text('No orders yet', style: TextStyle(color: AppColors.textSecondary)))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: orders.map((order) => _OrderCard(order: order)).toList(),
            ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final FoodOrder order;

  const _OrderCard({required this.order});

  static const _steps = [
    (OrderStatus.placed, Icons.check_circle_outline, 'Placed'),
    (OrderStatus.cooking, Icons.local_fire_department_outlined, 'Cooking'),
    (OrderStatus.pickedUp, Icons.directions_bike_outlined, 'Picked up'),
    (OrderStatus.delivered, Icons.home_outlined, 'Delivered'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _steps.indexWhere((s) => s.$1 == order.status);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${order.dish.name} · ${order.dish.cookName}',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              children: List.generate(_steps.length * 2 - 1, (i) {
                if (i.isOdd) {
                  final passed = (i ~/ 2) < currentIndex;
                  return Expanded(
                    child: Container(height: 1, color: passed ? AppColors.success : const Color(0xFFE6E2D9)),
                  );
                }
                final stepIndex = i ~/ 2;
                final step = _steps[stepIndex];
                final reached = stepIndex <= currentIndex;
                return Column(
                  children: [
                    Icon(step.$2, size: 18, color: reached ? AppColors.success : AppColors.textSecondary),
                    const SizedBox(height: 2),
                    Text(step.$3, style: TextStyle(fontSize: 10, color: reached ? AppColors.textPrimary : AppColors.textSecondary)),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
