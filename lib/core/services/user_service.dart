import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resto_app/models/user_model.dart';

class UserService {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel> getUser() async {

    final user = FirebaseAuth.instance.currentUser;

    final doc = await firestore
        .collection("users")
        .doc(user!.uid)
        .get();

    return UserModel.fromMap(doc.data()!);
  }

}