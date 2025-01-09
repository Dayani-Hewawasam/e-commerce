

import 'package:flutter/material.dart';
import 'package:sandu_fashion/pages/category_products.dart';
import 'package:sandu_fashion/services/shared_pref.dart';
import 'package:sandu_fashion/widget/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    "images/298-2.JPEG",
    "images/Puffsleevemini-3.JPEG",
    "images/blackblouse-3.jpeg"
  ];

  List<String> categoryNames = [
    'mini_dress',
    'maxi_midi_dress',
    't_shirt_blouses'
  ];

  String? name, image;

  Future<void> getTheSharedPref() async {
    SharedPreferenceHelper sharedPreferenceHelper = SharedPreferenceHelper();
    name = await sharedPreferenceHelper.getUserName();

    setState(() {});
  }

  ontheload() async {
    await getTheSharedPref();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 230, 244),
      body: name == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hey " + name!,
                            style: AppWidget.boldTextFeildStyle(),
                          ),
                          Text(
                            "Good Morning",
                            style: AppWidget.lightTextFeildStyle(),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          "images/SachiProfile.jpeg", // Use Image.asset to load local images
                          height: 70.0,
                          width: 70.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Container(

                    margin: const EdgeInsets.only(right: 20.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search here",
                        hintStyle: AppWidget.lightTextFeildStyle(),
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Categories",
                          style: AppWidget.semiBoldTextFeildStyle()),
                      const Text(
                        "see all",
                        style: TextStyle(
                            color: Color(0xFFfd6f9e),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Container(
                        height: 210.0,
                        padding: const EdgeInsets.all(23.0),
                        margin: const EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 180, 135, 172),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            "All",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                      ),
                      Expanded(
                        child: SizedBox(
                          height: 210.0,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                image: categories[index],
                                name: categoryNames[index],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("All Products",
                          style: AppWidget.semiBoldTextFeildStyle()),
                      const Text(
                        "see all",
                        style: TextStyle(
                            color: Color(0xFFfd6f9e),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return ProductTile(
                          image: categories[index],
                          name: categoryNames[index],
                        );
                      },

                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image, name;
  const CategoryTile({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProducts(category: name),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(right: 20.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              height: 55,
              width: 55,
              fit: BoxFit.cover,
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}


class ProductTile extends StatelessWidget {
  final String image, name;
  const ProductTile({super.key, required this.image, required this.name});


  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.only(right: 20.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),

      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 250.0,
            width: 130.0,
            fit: BoxFit.cover,
          ),

          Text(
            name,
            style: AppWidget.semiBoldTextFeildStyle(),
          ),

        ],
      ),
    );
  }
}
