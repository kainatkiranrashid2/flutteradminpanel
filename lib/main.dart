import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:semesterprojectadminpanel/screens/new_product_screen.dart';
import 'package:semesterprojectadminpanel/screens/product_screen.dart';
import 'package:get/get.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ecommerce Admin Panel',
      theme: ThemeData(
        primarySwatch: myColor,
      ),
      home: const HomeScreen(),
      getPages: [
        GetPage(name: '/products', page: () => ProductScreen()),
        GetPage(name: '/products/new', page: () => NewProductScreen()),
        GetPage(name: '/orders', page: () =>  OrdersScreen()),
      ],
    );
  }
}

const myColor = MaterialColor(0xFF00008B, {
  50: Color(0xFFe5e5ff),
  100: Color(0xFFb3b3ff),
  200: Color(0xFF8080ff),
  300: Color(0xFF4d4dff),
  400: Color(0xFF1a1aff),
  500: Color(0xFF0000e6),
  600: Color(0xFF0000b3),
  700: Color(0xFF000080),
  800: Color(0xFF00004d),
  900: Color(0xFF00001a),
});
