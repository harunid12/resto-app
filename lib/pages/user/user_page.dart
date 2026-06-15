import 'package:flutter/material.dart';
import 'package:resto_app/core/services/auth_service.dart';
import 'package:resto_app/pages/auth/login_page.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return Scaffold(
      appBar: AppBar(title: const Text("User")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Ini Halaman User", style: TextStyle(fontSize: 30)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authService.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
