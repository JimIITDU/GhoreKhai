import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> items;
  final VoidCallback onPlaceOrder;

  const CartScreen({super.key, required this.items, required this.onPlaceOrder});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _slot = '1:00 PM \u2013 1:30 PM';

  double get _total => widget.items.fold(0, (sum, item) => sum + item.dish.priceFor(item.plan));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your cart')),
      body: widget.items.isEmpty
          ? const Center(
              child: Text('Your cart is empty', style: TextStyle(color: AppColors.textSecondary)),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...widget.items.map((item) => Card(
                      child: ListTile(
                        title: Text(item.dish.name),
                        subtitle: Text('${planLabel(item.plan)} · ${item.dish.cookName}'),
                        trailing: Text('\u09f3${item.dish.priceFor(item.plan).toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    )),
                const SizedBox(height: 8),
                const Text('Delivery slot', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _slot,
                  items: const [
                    DropdownMenuItem(value: '1:00 PM \u2013 1:30 PM', child: Text('1:00 PM \u2013 1:30 PM')),
                    DropdownMenuItem(value: '7:30 PM \u2013 8:00 PM', child: Text('7:30 PM \u2013 8:00 PM')),
                  ],
                  onChanged: (v) => setState(() => _slot = v ?? _slot),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontWeight: FontWeight.w600)),
                    Text('\u09f3${_total.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 6),
                const Row(
                  children: [
                    Icon(Icons.payments_outlined, size: 16, color: AppColors.textSecondary),
                    SizedBox(width: 6),
                    Text('Cash on delivery', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    widget.onPlaceOrder();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order placed')),
                    );
                  },
                  child: const Text('Place order'),
                ),
              ],
            ),
    );
  }
}
