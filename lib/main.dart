import 'package:flutter/material.dart';
import 'package:mark/provider/cart_provider.dart';
import 'package:mark/pages/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(254, 206, 1, 1),
            primary: const Color.fromRGBO(254, 206, 1, 1),
          ),
          appBarTheme: const AppBarTheme(titleTextStyle: TextStyle(fontSize: 20, color: Colors.black)), //global property for the appbar
          inputDecorationTheme: const InputDecorationTheme(hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), prefixIconColor: Color.fromRGBO(119, 119, 119, 1)), // gloabal input decoration for hint style
          textTheme: const TextTheme(
              titleLarge: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
              titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
