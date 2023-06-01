import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semesterprojectadminpanel/screens/new_product_screen.dart';
import '../models/models.dart';
import '../controllers/controllers.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    print('kainat');

    return Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          backgroundColor: hexToColor('#00008B'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
              height: 100,
              child: Card(
                  margin: EdgeInsets.zero,
                  color: hexToColor('#00008B'),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(() => NewProductScreen());
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                      ),
                      const Text('Add a New Product',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ],
                  )),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 210,
                      child: ProductCard(
                        product: productController.products[index],
                        index: index,
                      ),
                    );
                  },
                ),
              ),
            )
          ]),
        ));
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;
  ProductCard({super.key, required this.product, required this.index});
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    print('Kainat');
    print(index);
    return Card(
      margin: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              product.name,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: hexToColor('#00008B')),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.description,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: hexToColor('#00008B')),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Text(
                              'Price',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: hexToColor('#00008B')),
                            ),
                          ),
                          SizedBox(
                            width: 190,
                            child: Slider(
                              value: product.price,
                              min: 0,
                              max: 25,
                              divisions: 10,
                              activeColor: hexToColor('#00008B'),
                              inactiveColor: Colors.lightBlueAccent,
                              onChanged: (value) {
                                productController.updateProductPrice(
                                    index, product, value);
                              },
                              onChangeEnd: (value) {
                                productController.saveNewProductPrice(
                                    product, 'price', value);
                              },
                            ),
                          ),
                          Text(
                            '\$${product.price.toStringAsFixed(1)}',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: hexToColor('#00008B')),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Text(
                              'Qty',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: hexToColor('#00008B')),
                            ),
                          ),
                          SizedBox(
                            width: 190,
                            child: Slider(
                              value: product.quantity.toDouble(),
                              min: 0,
                              max: 100,
                              divisions: 10,
                              activeColor: hexToColor('#00008B'),
                              inactiveColor: Colors.lightBlueAccent,
                              onChanged: (value) {
                                productController.updateProductQuantity(
                                    index, product, value.toInt());
                              },
                              onChangeEnd: (value) {
                                productController.saveNewProductQuantity(
                                    product, 'quantity', value.toInt());
                              },
                            ),
                          ),
                          Text(
                            '${product.quantity.toInt()}',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: hexToColor('#00008B')),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

Color hexToColor(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
