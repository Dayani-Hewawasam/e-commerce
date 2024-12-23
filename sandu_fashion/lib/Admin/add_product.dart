/* import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:sandu_fashion/services/database_methods.dart';

// Ensure this import is correct and the file exists

import 'dart:typed_data';

class AppWidget {
  static TextStyle semiBoldTextFeildStyle() {
    return TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
    );
  }

  static TextStyle LightTextFeildStyle() {
    return TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 16.0,
    );
  }
}

class DatabaseMethods {
  Future<void> addProduct(Map<String, dynamic> product, String category) async {
    // Add your implementation here
  }

  Future<void> addAllProducts(Map<String, dynamic> product) async {
    // Add your implementation here
  }
}

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  TextEditingController detailscontroller = new TextEditingController();

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  UploadItem() async {
    if (selectedImage != null && namecontroller.text != "") {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImage").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var dowloadUrl = await (await task).ref.getDownloadURL();
      String firstletter = namecontroller.text.substring(0, 1).toUpperCase();

      Map<String, dynamic> addProduct = {
        "Name": namecontroller.text,
        "Image": dowloadUrl,
        "SearchKey": firstletter,
        "UpdatedName": namecontroller.text.toUpperCase(),
        "Price": pricecontroller.text,
        "Detail": detailscontroller.text,
      };

      await DatabaseMethods()
          .addProduct(addProduct, value!)
          .then((value) async {
        await DatabaseMethods().addAllProducts(addProduct);
        selectedImage = null;
        namecontroller.text = "";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: const Text(
              "product has been uploaded Successfully!!!",
              style: TextStyle(fontSize: 20.0),
            )));
      });
    }
  }

  String? value;
  final List<String> categoryitem = [
    'mini_dress',
    'maxi_midi_dress',
    'tshirt_blouses'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_rounded)),
        title: Text(
          "Add Product",
          style: AppWidget.semiBoldTextFeildStyle(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload the Product Image",
                style: AppWidget.LightTextFeildStyle(),
              ),
              SizedBox(
                height: 20.0,
              ),
              selectedImage == null
                  ? GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Center(
                        child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(Icons.camera_alt_outlined)),
                      ),
                    )
                  : Center(
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Product Name ",
                style: AppWidget.LightTextFeildStyle(),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xffececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Product Price ",
                style: AppWidget.LightTextFeildStyle(),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xffececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: pricecontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Product Detail ",
                style: AppWidget.LightTextFeildStyle(),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xffececf8),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLines: 6,
                  controller: detailscontroller,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Product Category ",
                style: AppWidget.LightTextFeildStyle(),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xffececf8),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      items: categoryitem
                          .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item, // Display the item value here
                                style: AppWidget.semiBoldTextFeildStyle(),
                              )))
                          .toList(),
                      onChanged: ((Value) => setState(() {
                            this.value = Value;
                          })),
                      dropdownColor: Colors.white,
                      hint: Text("Seelect Category"),
                      iconSize: 36,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      value: value,
                    ),
                  )),
              SizedBox(
                height: 30.0,
              ),
              Center(
                  child: ElevatedButton(
                onPressed: () {
                  UploadItem();
                },
                child: Text(
                  "Add Product",
                  style: TextStyle(fontSize: 22.0),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
*/


import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddPage extends StatefulWidget {
  @override
  _ProductAddPageState createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _detailController =
      TextEditingController(); // New field for product details
  String _selectedCategory = '';
  Uint8List? _imageBytes;
  String? _imageUrl;

  // Pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  // Upload the image to Firebase Storage
  Future<void> _uploadImage() async {
    if (_imageBytes != null) {
      try {
        final fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final storageRef =
            FirebaseStorage.instance.ref().child('images/$fileName');
        final uploadTask = await storageRef.putData(_imageBytes!);
        _imageUrl = await uploadTask.ref.getDownloadURL();

        print('Image uploaded successfully. URL: $_imageUrl');
      } catch (e) {
        print('Error uploading image: $e');
        _imageUrl = null;
      }
    }
  }

  // Add the product to Firestore
  Future<void> _addProduct() async {
    if (_nameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _detailController.text.isNotEmpty &&
        _selectedCategory.isNotEmpty &&
        _imageBytes != null) {
      await _uploadImage(); // Upload image and get its URL

      if (_imageUrl != null) {
        final firestoreRef =
            FirebaseFirestore.instance.collection(_selectedCategory);
        await firestoreRef.add({
          'name': _nameController.text,
          'price': _priceController.text, // Store price as a string
          'detail': _detailController.text, // Adding the detail field
          'imageUrl': _imageUrl, // Save the valid image URL
        });

        // Clear the form fields and state
        _nameController.clear();
        _priceController.clear();
        _detailController.clear(); // Clear the detail field
        setState(() {
          _imageBytes = null;
          _selectedCategory = '';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Product Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _detailController,
                decoration: InputDecoration(
                    labelText: 'Product Detail'), // Input for detail
              ),
              DropdownButton<String>(
                value: _selectedCategory.isEmpty ? null : _selectedCategory,
                hint: Text('Select Category'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                items: <String>[
                  'mini_dress',
                  'maxi_midi_dress',
                  't_shirt_blouses'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.replaceAll('_', ' ').toUpperCase()),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              if (_imageBytes != null)
                Image.memory(
                  _imageBytes!,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}