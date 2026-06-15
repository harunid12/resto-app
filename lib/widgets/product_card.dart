import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.network(image, width: 60, height: 60, fit: BoxFit.cover),

          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(name), Text(price)],
          ),
        ],
      ),
    );
  }
}
