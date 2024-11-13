import 'package:flutter/material.dart';
import 'package:mark/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedSize = 0;

  void onTap() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct({
        'id': widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'imgUrl': widget.product['imgUrl'],
        'company': widget.product['company'],
        'size': selectedSize,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Shoe added to the cart.')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Hey! You forgot to select the shoe size.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(widget.product['imgUrl'] as String),
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(color: const Color.fromRGBO(245, 247, 249, 1), borderRadius: BorderRadius.circular(40)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['sizes'] as List<int>).length,
                      itemBuilder: (context, index) {
                        final size = (widget.product['sizes'] as List<int>)[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = size;
                                });
                              },
                              child: Chip(backgroundColor: selectedSize == size ? Theme.of(context).colorScheme.primary : const Color.fromRGBO(245, 247, 249, 1), label: Text(size.toString()))),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton.icon(
                      onPressed: onTap,
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                      ),
                      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary, minimumSize: const Size(double.infinity, 50)),
                      label: const Text(
                        'Add to cart',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
