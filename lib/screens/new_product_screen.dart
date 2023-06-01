import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:semesterprojectadminpanel/services/database_service.dart';
import 'package:semesterprojectadminpanel/services/storage_service.dart';

import '../controllers/controllers.dart';
import '../models/models.dart';

class NewProductScreen extends StatelessWidget {
  NewProductScreen({super.key});
  final ProductController productController = Get.find();
  StorageService storage = StorageService();

  DatabaseService database = DatabaseService();

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Smoothies', 'Soft Drinks', 'Water'];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a product'),
          backgroundColor: hexToColor('#00008B'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(
              () => Column(children: [
                SizedBox(
                  height: 100,
                  child: Card(
                      margin: EdgeInsets.zero,
                      color: hexToColor('#00008B'),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              ImagePicker _picker = ImagePicker();
                              final XFile? _image = await _picker.pickImage(
                                  source: ImageSource.gallery);

                              if (_image == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('No image was selected'),
                                  ),
                                );
                              }

                              if (_image != null) {
                                await storage.uploadImage(_image);
                                var imageUrl =
                                    await storage.getDownloadURL(_image.name);

                                productController.newProduct.update(
                                    'imageUrl', (value) => imageUrl,
                                    ifAbsent: () => imageUrl);
                              }
                              print(productController.newProduct['imageUrl']);
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.white,
                            ),
                          ),
                          const Text('Add an Image',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))
                        ],
                      )),
                ),
                const SizedBox(height: 20),
                Text(
                  'Product Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: hexToColor('#00008B'),
                  ),
                ),
                _buildTextFormField('Product Name', 'name', productController),
                _buildTextFormField(
                    'Product Description', 'description', productController),
                // _buildTextFormField(
                //     'Product Category', 'category', productController),
                DropdownButtonFormField(
                  iconSize: 20,
                  decoration:
                      const InputDecoration(hintText: 'Product Category'),
                  items: categories.map(
                    (category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    productController.newProduct.update(
                        'category', (_) => value,
                        ifAbsent: () => value);
                  },
                ),
                const SizedBox(height: 10),
                _buildSlider('Price', 'price', productController,
                    productController.price),
                _buildSlider('Quantity', 'quantity', productController,
                    productController.quantity),
                _buildCheckbox('isRecommended', 'isRecommended',
                    productController, productController.isRecommended),
                _buildCheckbox('isPopular', 'isPopular', productController,
                    productController.isPopular),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      print(productController.newProduct);
                      database.addProduct(
                        Product(
                          id: productController.newProduct['id'],
                          name: productController.newProduct['name'],
                          category: productController.newProduct['category'],
                          description:
                              productController.newProduct['description'],
                          imageUrl: productController.newProduct['imageUrl'],
                          isRecommended:
                              productController.newProduct['isRecommended'] ??
                                  false,
                          isPopular:
                              productController.newProduct['isPopular'] ??
                                  false,
                          price: productController.newProduct['price'],
                          quantity:
                              productController.newProduct['quantity'].toInt(),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: hexToColor('#00008B'),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ));
  }

  Row _buildCheckbox(String title, String name,
      ProductController productController, bool? controllerValue) {
    return Row(
      children: [
        SizedBox(
          width: 125,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: hexToColor('#00008B'),
            ),
          ),
        ),
        Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          checkColor: hexToColor('#00008B'),
          activeColor: Colors.lightBlueAccent,
          onChanged: (value) {
            productController.newProduct
                .update(name, (_) => value, ifAbsent: () => value);
          },
        ),
      ],
    );
  }

  Row _buildSlider(String title, String name,
      ProductController productController, double? controllerValue) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: hexToColor('#00008B'),
            ),
          ),
        ),
        Expanded(
          child: Slider(
            value: (controllerValue == null) ? 0 : controllerValue,
            min: 0,
            max: 25,
            divisions: 10,
            activeColor: hexToColor('#00008B'),
            inactiveColor: Colors.lightBlueAccent,
            onChanged: (value) {
              productController.newProduct
                  .update(name, (_) => value, ifAbsent: () => value);
            },
          ),
        ),
      ],
    );
  }

  TextFormField _buildTextFormField(
      String hintText, String name, ProductController productController) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      onChanged: (value) {
        productController.newProduct
            .update(name, (_) => value, ifAbsent: () => value);
      },
    );
  }
}

Color hexToColor(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
