import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/products.dart';
import '../../utils/snakbars.dart';
import '../providers.dart';
import 'InputProduceDetails.dart';

class AdminAddProduct extends ConsumerStatefulWidget {
  const AdminAddProduct({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminAddProductState();
}
class _AdminAddProductState extends ConsumerState<AdminAddProduct> {

  final titleTextEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
        body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  children: [
                    CustomInputFieldFb1(
                      inputController: titleTextEditingController,
                      labelText: 'Product Name',
                      hintText: 'Product Name',
                    ),
                    const SizedBox(height: 15),
                    CustomInputFieldFb1(
                      inputController: descriptionEditingController,
                      labelText: 'Product Description',
                      hintText: 'Product Description',
                    ),
                    const SizedBox(height: 15),
                    CustomInputFieldFb1(
                      inputController: priceEditingController,
                      labelText: 'Price',
                      hintText: 'Price',
                    ),
                    ElevatedButton(
                        onPressed: () => _addProduct(),
                        child: const Text("Add Product")
                    ),

                    Consumer(
                      builder: (context, watch, child) {
                        final image = ref.watch(imagePickerProvider);
                        return image == null
                            ? const Text('No image selected')
                            : Image.file(
                          File(image.path),
                          height: 200,
                        );
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Upload Image'),
                      onPressed: () async {
                        final image = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );
                        if (image != null) {
                          ref.watch(imagePickerProvider.state).state = image;
                        }
                      },
                    ),
                  ]
              ),
            )
        )
    );
  }
  _addProduct() async{
    final storage = ref.read(databaseProvider);
    final fileStorage = ref.read(storageProvider);
    final imageFile = ref.read(imagePickerProvider.state).state;

    if (storage == null || fileStorage == null || imageFile == null) {
      print("Error: storage, fileStorage or imageFile is null");
      return;
    }
    final imageUrl = await fileStorage.uploadFile(imageFile.path);
    await storage.addProduct(Product(
      name: titleTextEditingController.text,
      description: descriptionEditingController.text,
      price: double.parse(priceEditingController.text),
      imageUrl: imageUrl,
    ));
    openIconSnackBar(context, "Product added successfully",const Icon(Icons.check, color: Colors.white));
    Navigator.pop(context);
  }
}
