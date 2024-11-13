// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:mark/pages/cart_page.dart';
import 'package:mark/pages/productList.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> pages = const [
    ProductList(),
    CartPage()
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          iconSize: 32,
          selectedFontSize: 0, //to remove the font size when the icon is selected
          unselectedFontSize: 0, //to remove the font size when the icon is not selected
          currentIndex: currentPage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: '')
          ]),
    );
  }
}
