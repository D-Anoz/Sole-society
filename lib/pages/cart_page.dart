import 'package:flutter/material.dart';
import 'package:mark/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          centerTitle: true,
        ),
        body: cart.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animation/empty.json', repeat: false, height: 400),
                    Text(
                      'Empty list',
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final cartItem = cart[index];

                  return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(cartItem['imgUrl'] as String),
                        radius: 30,
                      ),
                      title: Text(
                        cartItem['title'].toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      subtitle: Text('Size:${cartItem['size']}'),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Column(
                                    children: [
                                      Lottie.asset('assets/animation/wipe.json', repeat: true, height: 200),
                                      Text(
                                        'Remove  item?',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                  content: const Text(
                                    'Are you sure you want to remove this item?',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800))),
                                    TextButton(
                                        onPressed: () {
                                          context.read<CartProvider>().removeProduct(cartItem);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Remove',
                                          style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.w800),
                                        ))
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ));
                }));
  }
}
