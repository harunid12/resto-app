import 'package:flutter/material.dart';
import 'package:resto_app/core/services/product_service.dart';
import 'package:resto_app/models/product_model.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel product;

  const EditProductPage({super.key, required this.product});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController imageController;

  late String selectedCategory;

  final ProductService service = ProductService();

  final List<String> categories = ["Makanan", "Minuman", "Snack", "Dessert"];

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.product.name);
    priceController = TextEditingController(
      text: widget.product.price.toString(),
    );
    imageController = TextEditingController(text: widget.product.image);
    selectedCategory = widget.product.category;
  }

  Future<void> updateProduct() async {
    final updated = ProductModel(
      id: widget.product.id,
      name: nameController.text,
      category: selectedCategory,
      image: imageController.text,
      price: int.parse(priceController.text),
    );

    await service.updateProduct(updated);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Produk berhasil diupdate!!"),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pop(context);
  }

  Future<void> deleteProduct() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Produk"),
          content: const Text("Yakin ingin menghapus produk ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                "Hapus",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await service.deleteProduct(widget.product.id!);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Produk berhasil dihapus!!"),
          backgroundColor: Colors.red,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Edit Product"),

        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: deleteProduct,
          ),
        ],
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
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              decoration: _decoration("Kategori"),
            ),

            const SizedBox(height: 12),

            _input(priceController, "Harga"),
            const SizedBox(height: 12),

            _input(imageController, "Image URL"),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: updateProduct,
                child: const Text("Update Produk"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(TextEditingController controller, String hint) {
    return TextField(controller: controller, decoration: _decoration(hint));
  }

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
