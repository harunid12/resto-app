import 'package:flutter/material.dart';
import 'package:resto_app/pages/admin/home_page_admin.dart';
import 'package:resto_app/pages/admin/product_page_admin.dart';
import 'package:resto_app/pages/admin/profile_page_admin.dart';


class LayoutsScreenAdmin extends StatefulWidget {
  const LayoutsScreenAdmin({super.key});

  @override
  State<LayoutsScreenAdmin> createState() => _LayoutsScreenAdminState();
}

class _LayoutsScreenAdminState extends State<LayoutsScreenAdmin> {

  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePageAdmin(),
    ProductPageAdmin(),
    ProfilePageAdmin()
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