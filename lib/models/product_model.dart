class ProductModel {
  String? id;
  String name;
  String category;
  String image;
  int price;

  ProductModel({
    this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.price,
  });

  // dari Firestore ke Object
  factory ProductModel.fromMap(String id, Map<String, dynamic> data) {
    return ProductModel(
      id: id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      image: data['image'] ?? '',
      price: data['price'] ?? 0,
    );
  }

  // dari Object ke Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'image': image,
      'price': price,
    };
  }
}