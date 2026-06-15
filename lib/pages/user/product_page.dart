import 'package:flutter/material.dart';
import 'package:resto_app/widgets/product_card_user.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [

          ProductCardUser(
              name: "Nasi Goreng",
              price: "Rp 20.000",
              category: "Makanan",
              image:
                  "https://dcostseafood.id/wp-content/uploads/2023/04/Nasi-Goreng-telor.jpg",
            ),

            ProductCardUser(
              name: "Es Teh",
              price: "Rp 5.000",
              category: "Minuman",
              image:
                  "https://i.pinimg.com/originals/ab/30/7e/ab307ec373a3987d0151938bc9d4c5a1.jpg",
            ),

            ProductCardUser(
              name: "Burger",
              price: "Rp 25.000",
              category: "Makanan",
              image:
                  "https://images.unsplash.com/photo-1550547660-d9450f859349",
            ),

        ],
      ),
    );
  }
}