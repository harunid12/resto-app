import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resto_app/core/services/auth_service.dart';
import 'package:resto_app/core/services/user_service.dart';
import 'package:resto_app/models/user_model.dart';
import 'package:resto_app/pages/auth/login_page.dart';

class ProfilePageAdmin extends StatefulWidget {
  const ProfilePageAdmin({super.key});

  @override
  State<ProfilePageAdmin> createState() => _ProfilePageAdminState();
}

class _ProfilePageAdminState extends State<ProfilePageAdmin> {

  final authService = AuthService();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> logout() async {
    await authService.logout();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 40,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),

            const SizedBox(height: 15),

            FutureBuilder<UserModel>(
              future: UserService().getUser(),

              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return const Text("-");
                }

                final user = snapshot.data!;

                return Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),

            const SizedBox(height: 5),

            FutureBuilder<UserModel>(
              future: UserService().getUser(),

              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return const Text("-");
                }

                final user = snapshot.data!;

                return Text(
                  user.email,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                children: [

                  _menuItem(Icons.star, "Rate Us"),
                  const Divider(),

                  _menuItem(Icons.info, "App Version 1.0.0"),
                  const Divider(),

                  _menuItem(Icons.help_outline, "About App"),

                ],
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: logout,
              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String title) {
    return Row(
      children: [

        Icon(icon, color: Colors.orange),

        const SizedBox(width: 10),

        Text(title),

      ],
    );
  }
}