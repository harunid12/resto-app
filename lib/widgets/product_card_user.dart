import 'package:flutter/material.dart';

class ProductCardUser extends StatelessWidget {
  final String name;
  final String price;
  final String category;
  final String image;

  const ProductCardUser({
    super.key,
    required this.name,
    required this.price,
    required this.category,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(price),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(category),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}