import 'package:flutter/material.dart';
import 'package:mark/global_variables.dart';
import 'package:mark/pages/product_card.dart';

import 'product_detail.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filter = const [
    'All',
    'Prada',
    'Armani',
    'Fendi'
  ];
  late String selectedFilter;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    selectedFilter = filter[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color.fromRGBO(225, 225, 225, 1)), borderRadius: BorderRadius.horizontal(left: Radius.circular(50)));
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Shoe\ncollection',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: 'Search', prefixIcon: Icon(Icons.search), border: border, enabledBorder: border, focusedBorder: border),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filter.length,
              itemBuilder: (context, index) {
                final shoeList = filter[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = shoeList;
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedFilter == shoeList ? Theme.of(context).colorScheme.primary : const Color.fromRGBO(245, 247, 249, 1),
                      label: Text(
                        shoeList,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      labelStyle: const TextStyle(fontSize: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      side: const BorderSide(color: Color.fromRGBO(245, 247, 249, 1)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: size.width > 650
                ? GridView.builder(
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetail(product: product)));
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imgUrl'] as String,
                          backgroundColor: index.isEven ? const Color.fromRGBO(216, 240, 253, 1) : const Color.fromRGBO(245, 247, 249, 1),
                        ),
                      );
                    })
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetail(product: product)));
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imgUrl'] as String,
                          backgroundColor: index.isEven ? const Color.fromRGBO(216, 240, 253, 1) : const Color.fromRGBO(245, 247, 249, 1),
                        ),
                      );
                    }),
          )
        ]),
      ),
    );
  }
}
