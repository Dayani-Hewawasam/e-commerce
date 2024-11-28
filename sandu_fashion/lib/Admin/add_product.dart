import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:sandu_fashion/widget/support_widget.dart';
import 'package:sandu_fashion/services/database.dart';
import 'package:sandu_fashion/widget/support_widget.dart';

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

      await DatabaseMethods().addProduct(addProduct, value!);
      await DatabaseMethods().addAllProducts(addProduct);
      selectedImage = null;
      namecontroller.text = "";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: const Text(
            "Product has been uploaded Successfully!!!",
            style: TextStyle(fontSize: 20.0),
          )));
    }
  }

  String? value;
  final List<String> categoryitem = [
    'Mini dress',
    'Midi/Maxi dress',
    'T-shirt/Blouse'
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
        title: Text("Add Product", style: AppWidget.semiboldTextFeildStyle()),
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
                style: AppWidget.lightTextFeildStyle(),
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
                style: AppWidget.lightTextFeildStyle(),
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
                style: AppWidget.lightTextFeildStyle(),
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
                style: AppWidget.lightTextFeildStyle(),
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
                style: AppWidget.lightTextFeildStyle(),
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
                                style: AppWidget.semiboldTextFeildStyle(),
                              )))
                          .toList(),
                      onChanged: ((Value) => setState(() {
                            this.value = Value;
                          })),
                      dropdownColor: Colors.white,
                      hint: Text("Select Category"),
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
