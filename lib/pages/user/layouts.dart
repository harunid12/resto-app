import 'package:flutter/material.dart';
import 'package:resto_app/pages/user/home_page.dart';
import 'package:resto_app/pages/user/product_page.dart';
import 'package:resto_app/pages/user/profile_page.dart';


class LayoutsScreen extends StatefulWidget {
  const LayoutsScreen({super.key});

  @override
  State<LayoutsScreen> createState() => _LayoutsScreenState();
}

class _LayoutsScreenState extends State<LayoutsScreen> {

  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    ProductPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Products",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}