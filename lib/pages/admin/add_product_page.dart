import 'package:flutter/material.dart';
import 'package:resto_app/core/services/product_service.dart';
import 'package:resto_app/models/product_model.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();

  final ProductService service = ProductService();

  String? selectedCategory;

  final List<String> categories = [
    "Makanan",
    "Minuman",
    "Snack",
    "Dessert",
  ];

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    imageController.dispose();
    super.dispose();
  }

  Future<void> addProduct() async {

    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        imageController.text.isEmpty ||
        selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field wajib diisi")),
      );
      return;
    }

    final product = ProductModel(
      name: nameController.text,
      category: selectedCategory!,
      image: imageController.text,
      price: int.parse(priceController.text),
    );

    await service.addProduct(product);

    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Produk berhasil ditambahkan!!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ),
  );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Tambah Produk"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            _input(nameController, "Nama Produk"),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories.map((cat) {
                return DropdownMenuItem(
                  value: cat,
                  child: Text(cat),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Pilih Kategori",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 12),

            _input(priceController, "Harga"),
            const SizedBox(height: 12),

            _input(imageController, "Image URL"),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addProduct,
                child: const Text("Simpan Produk"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      keyboardType: hint == "Harga"
          ? TextInputType.number
          : TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}