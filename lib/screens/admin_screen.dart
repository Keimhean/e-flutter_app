import 'package:flutter/material.dart';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pendingSellers = [
      {'name': 'Campus Cafe', 'since': '1d ago', 'approved': false},
      {'name': 'Dorm Mart', 'since': '2h ago', 'approved': false},
    ];

    final inventory = [
      {'name': 'Iced Latte', 'stock': 24, 'visible': true},
      {'name': 'Notebook A5', 'stock': 8, 'visible': true},
      {'name': 'Chips Combo', 'stock': 0, 'visible': false},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionHeader(title: 'Seller approval'),
          const SizedBox(height: 8),
          ...pendingSellers.map(
            (seller) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(seller['name'] as String),
                subtitle: Text('Pending • ${seller['since']}'),
                trailing: AdaptiveSwitch(
                  value: seller['approved'] as bool,
                  activeColor: const Color(0xFF1D3357),
                  onChanged: (value) {
                    debugPrint('Approve ${seller['name']}: $value');
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _SectionHeader(title: 'Inventory'),
          const SizedBox(height: 8),
          ...inventory.map(
            (item) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                title: Text(item['name'] as String),
                subtitle: Text('Stock: ${item['stock']}'),
                trailing: AdaptiveSwitch(
                  value: item['visible'] as bool,
                  activeColor: const Color(0xFF1D3357),
                  onChanged: (value) {
                    debugPrint('Switch ${item['name']}: $value');
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _SectionHeader(title: 'Today’s numbers'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              _StatCard(label: 'Orders', value: '32'),
              _StatCard(label: 'COD collected', value: '\$247'),
              _StatCard(label: 'Approvals', value: '2 pending'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
