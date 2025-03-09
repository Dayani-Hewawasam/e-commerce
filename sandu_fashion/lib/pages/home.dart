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
      backgroundColor: const Color(0xFFF3CCFF),
      body: name == null
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hey ${name!}",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Good Morning",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: Image.asset(
                                    "images/SachiProfile.jpeg",
                                    height: 70.0,
                                    width: 70.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Search Bar
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search your favorite dress...",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.grey[400]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Categories Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "See All",
                              style: TextStyle(
                                color: Color(0xFFfd6f9e),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Categories List
                    SizedBox(
                      height: 160,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            width: 100,
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 180, 135, 172),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Center(
                              child: Text(
                                "All",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ...List.generate(
                            categories.length,
                            (index) => CategoryTile(
                              image: categories[index],
                              name: categoryNames[index],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Products Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "All Products",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "See All",
                              style: TextStyle(
                                color: Color(0xFFfd6f9e),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Products List
                    Container(
                      height: 350,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    ),
                  ],
                ),
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
        width: 100,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                image,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              name.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            const SizedBox(height: 5),
            Icon(Icons.arrow_forward, size: 20, color: Color(0xFFfd6f9e)),
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
      width: 200,
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              image,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name.replaceAll('_', ' ').toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFfd6f9e),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFfd6f9e),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
