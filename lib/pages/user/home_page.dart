import 'package:flutter/material.dart';
import 'package:resto_app/widgets/category_card.dart';
import 'package:resto_app/widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Resto App"),
        centerTitle: true,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔥 HEADER GREETING
              const Text(
                "Halo 👋",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "Mau pesan apa hari ini?",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 20),

              // 🔎 SEARCH BAR (UI ONLY)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Cari makanan, minuman...",
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🏷 CATEGORY
              const Text(
                "Kategori",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  CategoryCard(label: "Makanan", icon: Icons.fastfood),
                  CategoryCard(label: "Minuman", icon: Icons.local_drink),
                  CategoryCard(label: "Camilan", icon: Icons.cookie),
                ],
              ),

              const SizedBox(height: 25),

              // ⭐ POPULAR
              const Text(
                "Produk Populer",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // LIST STATIC PRODUCT
              Column(
                children: const [
                  ProductCard(
                    name: "Nasi Goreng",
                    price: "Rp 20.000",
                    image:
                        "https://dcostseafood.id/wp-content/uploads/2023/04/Nasi-Goreng-telor.jpg",
                  ),
                  ProductCard(
                    name: "Es Teh Manis",
                    price: "Rp 5.000",
                    image:
                        "https://i.pinimg.com/originals/ab/30/7e/ab307ec373a3987d0151938bc9d4c5a1.jpg",
                  ),
                  ProductCard(
                    name: "Burger",
                    price: "Rp 25.000",
                    image:
                        "https://images.unsplash.com/photo-1550547660-d9450f859349",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}