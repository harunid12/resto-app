import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String label;
  final IconData icon;

  const CategoryCard({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.orange),
          const SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}
