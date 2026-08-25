import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme.dart';

class ProfileScreen extends StatefulWidget {
  final AppUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _cookMode = false;
  bool _deliveryMode = false;

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primary.withOpacity(0.12),
                child: Text(user.fullName.substring(0, 1),
                    style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.fullName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  Text(user.email, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  if (user.verified)
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Text('DU verified \u00b7 email + ID checked',
                          style: TextStyle(color: AppColors.success, fontSize: 11)),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: SwitchListTile(
              title: const Text('Cook mode'),
              subtitle: const Text('List dishes and manage orders', style: TextStyle(fontSize: 12)),
              value: _cookMode,
              activeColor: AppColors.primary,
              onChanged: (v) => setState(() => _cookMode = v),
            ),
          ),
          if (_cookMode) const _CookDashboard(),
          Card(
            child: SwitchListTile(
              title: const Text('Delivery mode'),
              subtitle: const Text('Accept nearby deliveries', style: TextStyle(fontSize: 12)),
              value: _deliveryMode,
              activeColor: AppColors.primary,
              onChanged: (v) => setState(() => _deliveryMode = v),
            ),
          ),
          if (_deliveryMode) const _DeliveryDashboard(),
        ],
      ),
    );
  }
}

class _CookDashboard extends StatelessWidget {
  const _CookDashboard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(child: _StatCard(label: "Today's orders", value: '7')),
              SizedBox(width: 10),
              Expanded(child: _StatCard(label: 'This week', value: '\u09f32,460')),
            ],
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              title: const Text('Bhorta thali x2', style: TextStyle(fontSize: 13)),
              trailing: const Text('Cooking', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliveryDashboard extends StatelessWidget {
  const _DeliveryDashboard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(child: _StatCard(label: 'Assigned today', value: '4')),
              SizedBox(width: 10),
              Expanded(child: _StatCard(label: 'Expected earnings', value: '\u09f3320')),
            ],
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              title: const Text('Pickup: Rima\'s Kitchen', style: TextStyle(fontSize: 13)),
              subtitle: const Text('Deliver to: Amtali hostel', style: TextStyle(fontSize: 11)),
              trailing: const Text('Ready', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
