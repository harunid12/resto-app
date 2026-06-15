import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resto_app/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        uid: credential.user!.uid,
        name: name,
        email: email,
        role: "user",
      );

      await _firestore.collection("users").doc(user.uid).set(user.toMap());

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<String> getRole() async {
    final uid = _auth.currentUser!.uid;
    final data = await _firestore.collection("users").doc(uid).get();
    return data['role'];
  }
}
