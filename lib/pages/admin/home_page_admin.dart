import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:resto_app/models/product_model.dart';
import 'package:resto_app/widgets/product_card.dart';

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {

  final TextEditingController searchController = TextEditingController();

  String selectedCategory = "All";
  String searchQuery = "";

  final List<String> categories = [
    "All",
    "Makanan",
    "Minuman",
    "Snack",
    "Dessert",
  ];

  final currency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Resto App Admin"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Halo 👋",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "Kelola produk restoran",
                style: TextStyle(color: Colors.grey[600]),
              ),

              const SizedBox(height: 20),

              // 🔎 SEARCH
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                      selectedCategory = "All"; // optional UX
                    });
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search),
                    hintText: "Cari produk...",
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🏷 CATEGORY FILTER
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {

                    final cat = categories[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = cat;
                          searchQuery = "";
                          searchController.clear();
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: selectedCategory == cat
                              ? Colors.orange
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          cat,
                          style: TextStyle(
                            color: selectedCategory == cat
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Produk",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              // 📦 FIREBASE STREAM
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .snapshots(),

                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<ProductModel> products = snapshot.data!.docs.map((doc) {
                    return ProductModel.fromMap(
                      doc.id,
                      doc.data() as Map<String, dynamic>,
                    );
                  }).toList();

                  // 🏷 FILTER CATEGORY
                  if (selectedCategory != "All") {
                    products = products
                        .where((p) => p.category == selectedCategory)
                        .toList();
                  }

                  // 🔎 FILTER SEARCH
                  if (searchQuery.isNotEmpty) {
                    products = products
                        .where((p) =>
                            p.name.toLowerCase().contains(searchQuery))
                        .toList();
                  }

                  if (products.isEmpty) {
                    return const Center(
                      child: Text("Produk tidak ditemukan"),
                    );
                  }

                  return Column(
                    children: products.map((product) {
                      return ProductCard(
                        name: product.name,
                        price: currency.format(product.price),
                        image: product.image,
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}