import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semesterprojectadminpanel/screens/orders_screen.dart';
import 'package:semesterprojectadminpanel/screens/product_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ecommerce AdminPanel'),
          backgroundColor: hexToColor('#00008B'),
        ),
        body: SizedBox(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: InkWell(
                  onTap: () {
                    Get.to(() => ProductScreen());
                  },
                  child:
                      const Card(child: Center(child: Text('Go To Products')))),
            ),
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: InkWell(
                  onTap: () {
                    Get.to(() =>  OrdersScreen());
                  },
                  child:
                      const Card(child: Center(child: Text('Go To Orders')))),
            )
          ]),
        ));
  }
}
