import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resto_app/models/product_model.dart';

class ProductService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final String collection = "products";

  // CREATE
  Future<void> addProduct(ProductModel product) async {
    await firestore.collection(collection).add(product.toMap());
  }

  // READ (stream realtime)
  Stream<List<ProductModel>> getProducts() {
    return firestore.collection(collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  // update
  Future<void> updateProduct(ProductModel product) async {
    await firestore
        .collection("products")
        .doc(product.id)
        .update(product.toMap());
  }

  // delete
  Future<void> deleteProduct(String id) async {
    await firestore.collection("products").doc(id).delete();
  }
}
